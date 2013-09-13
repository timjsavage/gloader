sbin_dir = "#{node['collectd_proxy']['base_dir']}/#{node['collectd_proxy']['binary']}".sub(/\/[^\/]*$/, '') # KMN
lib_dir  = "#{node['collectd_proxy']['base_dir']}/lib/collectd"
svc_name = node['collectd_proxy']['config']['file'].sub(/.conf$/, '')

user  node['collectd_proxy']['user']
group node['collectd_proxy']['group']

package "libgcrypt11" # compile-time dep in case we add encryption later

[ node['collectd_proxy']['config']['dir'],
  lib_dir,
  sbin_dir ].each do |dir|
  directory dir do
    owner node['collectd_proxy']['user']
    group node['collectd_proxy']['group']
    mode "0755"
    recursive true
  end
end

template "#{ node['collectd_proxy']['config']['dir'] }/#{ node['collectd_proxy']['config']['file'] }" do
  owner node['collectd_proxy']['user']
  group node['collectd_proxy']['group']
  source 'config.erb'
  mode '0700' # might have traffic encyption keys in it
  notifies :restart, "service[#{svc_name}]"
end

template "/etc/init.d/#{ svc_name }" do
  source 'init-script.erb'
  mode '0755'
end

cookbook_file "#{ node['collectd_proxy']['base_dir'] }/#{ node['collectd_proxy']['binary'] }" do
  owner node['collectd_proxy']['user']
  group node['collectd_proxy']['group']
  source 'collect_proxy_binary'
  mode '0755'
end

%w{ write_graphite network }.each do |plugin|
  cookbook_file "#{ lib_dir }/#{ plugin }.so" do
    owner node['collectd_proxy']['user']
    group node['collectd_proxy']['group']
    source "collectd_proxy_plugin_#{plugin}.so"
    mode '0755'
  end
end

service svc_name do
  supports :status => true, :restart => true, :reload => false
  action [ :enable, :start ]
end

