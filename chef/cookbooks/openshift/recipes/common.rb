execute "sshd-keepalive" do
  command %q{
    echo 'ClientAliveInterval 30' >> /etc/ssh/sshd_config
    echo 'ClientAliveCountMax 1000' >> /etc/ssh/sshd_config
    echo 'TCPKeepAlive yes' >> /etc/ssh/sshd_config
  }.strip
  action :run
end

service "sshd" do
  action :restart
end

execute "disable-se-linux" do
  command "setenforce 0; sed -i /etc/selinux/config -e 's/SELINUX=enforcing/SELINUX=disabled/'"
  action :run
end

user "openshift" do
  comment "OpenShift PaaS"
  action :create
end

execute "yum -y update"
%w{git libffi-devel rubygem-rake ntp}.each{|build_pkg| package build_pkg}

git node['openshift']['crankcase_checkout_path'] do
  repository "git://github.com/openshift/origin-server.git"
  reference "aad8d3ff2b31bcc9ad1beb853bd3e058819241bc"
  user "openshift"
  action :sync
end

build_path = File.join(node['openshift']['crankcase_checkout_path'], 'build')

# Rakefile checks for a TTY and attempts to use su if a TTY is not available.
# Unfortunately su prompts for a password. Instead enable passwordless sudo
# and override the sudo function in the Rakefile to always use sudo.
file "/etc/sudoers.d/openshift" do
  content %q{
    Defaults !requiretty
    openshift ALL=(ALL) NOPASSWD: ALL
  }
  mode "0440"
  action :create
end

file File.join(build_path, 'always-use-sudo') do
  content %q{
    # Always use sudo
    def sudo(cmd)
      sh "sudo -n bash -c '#{cmd}'"
    end
  }
end

execute "always-use-sudo" do
  cwd build_path
  command "cat always-use-sudo >> Rakefile"
  not_if "grep 'Always use sudo' #{File.join(build_path, 'Rakefile')}"
  action :run
end

execute "install-basic-dependencies" do
  cwd build_path
  user "openshift"
  environment({'HOME' => '/home/openshift'})
  command "rake build_setup"
  action :run
end
