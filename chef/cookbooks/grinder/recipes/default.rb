#
# Cookbook Name:: grinder
# Recipe:: default
#
# Copyright 2012, Armakuni Ltd
#
# All rights reserved - Do Not Redistribute
#

package "unzip" do
  action :install
end

package "curl" do
  action :install
end

grinder_zip_file = "#{Chef::Config[:file_cache_path]}/grinder.zip"

remote_file grinder_zip_file do
  source "http://central.maven.org/maven2/net/sf/grinder/grinder/#{node[:grinder][:version]}/grinder-#{node[:grinder][:version]}-binary.zip"
  mode "0600"
  action :create
end

execute "unzip grinder" do
  command "unzip #{grinder_zip_file} -d /opt/"
  not_if { File.directory?("/opt/grinder-#{node[:grinder][:version]}") }
  action :run
end

user node[:grinder][:node][:user] do
  home node[:grinder][:node][:home]
  shell "/bin/sh"
end

group node[:grinder][:node][:group] do
end

execute "make available to defined user" do
  command "chown -R #{node[:grinder][:node]['user']}:#{node[:grinder][:node]['group']} /opt/grinder-#{node[:grinder][:version]}"
  action :run
end

# we could use the link resource, but it was broken on a recent version of Chef
execute "symlink grinder" do
  command "cd /opt && rm -f grinder && ln -s grinder-#{node[:grinder][:version]} grinder"
end

case node[:grinder][:role]

  when "console"
    directory "/tmp/grinder" do
      mode 0755
      owner "ubuntu"
      group "ubuntu"
    end
    execute "start grinder console" do
      command "nohup java -cp /opt/grinder/lib/grinder.jar -Dgrinder.console.httpHost=0.0.0.0 net.grinder.Console -headless >> /tmp/grinder-console.log 2>&1 &"
      cwd "/tmp/grinder"
      action :run
    end

  when "agent"
    python_pip "python-logstash" do
      action :install
    end
    execute "allow git to connect to bitbucket.org" do
      command 'echo -e "Host bitbucket.org\n\tStrictHostKeyChecking no\n" >> ~/.ssh/config'
      action :run
    end
    execute "install g2g from source" do
      command "pip install git+https://bitbucket.org/armakuni/grinder_to_graphite.git"
      action :run
    end
    directory "/tmp/grinder" do
      mode 0755
      owner "ubuntu"
      group "ubuntu"
    end
    console_server = search(:node, "role:#{node['grinder']['console_role']} AND chef_environment:#{node.chef_environment}")
    execute "start grinder agent" do
      command "nohup java -cp /opt/grinder/lib/grinder.jar -Dgrinder.jvm.arguments=-Xms3g -Xmx3g -XX:PermSize=256m -XX:MaxPermSize=256m -Dgrinder.consoleHost=#{console_server.first['ipaddress']} net.grinder.Grinder -daemon 30 >> /tmp/grinder-agent.log 2>&1 &"
      cwd "/tmp/grinder"
      action :run
    end
end
