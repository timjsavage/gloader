project_root = ::File.join(node['nagios']['home'], 'cucumber')
project_path = ::File.join(project_root, node['nagios']['cucumber']['project'])

["ruby1.8-dev", "libxslt-dev", "libxml2-dev", "xvfb", "firefox"].each do |test_dependency|
  package test_dependency do
    action :install
  end
end

# setup nagios user for access to GitHub
ssh_dir = "#{node['etc']['passwd']['nagios']['dir']}/.ssh"
directory ssh_dir do
  owner node['nagios']['user']
  group node['nagios']['group']
  mode "0700"
  action :create
end

file "#{ssh_dir}/config" do
  action :create
  content "StrictHostKeyChecking no"
end

cookbook_file "#{ssh_dir}/id_rsa" do
  source "nagios"
  owner node['nagios']['user']
  group node['nagios']['group']
  mode "0600"
  action :create
end

# allow nagios to shell out and add the systest script
user node['nagios']['user'] do
  shell "/bin/bash"
end

rbenv_gem "cucumber-nagios" do
  version node['nagios']['cucumber']['gem_version']
  rbenv_version node['nagios']['cucumber']['ruby_version']
end

template "#{node['nagios']['home']}/cucumber-systest.sh" do
  user node['nagios']['user']
  group node['nagios']['group']
  mode "0700"
  variables({
    'checkout_path' => project_path,
    'ruby_version' => node['nagios']['cucumber']['ruby_version']
  })
end

# install and cron feature retrieval
directory project_root do
  user node['nagios']['user']
  group node['nagios']['group']
  mode "0755"
  action :create
end

template "#{node['nagios']['home']}/cucumber-fetch-features.sh" do
  user node['nagios']['user']
  group node['nagios']['group']
  mode "0700"
  variables({
    'checkout_path' => project_path,
    'nagios_user' => node['nagios']['user'],
    'nagios_group' => node['nagios']['group'],
    'repository' => node['nagios']['cucumber']['repository'],
    'ruby_version' => node['nagios']['cucumber']['ruby_version']
  })
end

execute "fetch-initial-features" do
  command "#{node['nagios']['home']}/cucumber-fetch-features.sh"
  action :run
end

cron "refresh-features" do
  hour "*/1"
  minute "0"
  command "#{node['nagios']['home']}/cucumber-fetch-features.sh"
end

rbenv_gem "cucumber" do
  rbenv_version node['nagios']['cucumber']['ruby_version']
  version "1.2.1"
  action :remove
end
