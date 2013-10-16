user node['zap']['user']

download_tar_path = "#{Chef::Config['file_cache_path']}/zaproxy.tar.gz"

remote_file download_tar_path do
  source "http://zaproxy.googlecode.com/files/ZAP_#{node['zap']['version']}_Linux.tar.gz"
  checksum "6c2c5b82"
end

execute "tar zxf #{download_tar_path} --transform 's/^ZAP_#{node['zap']['version']}/zap-#{node['zap']['version']}/' -C /opt/ &&
  chown -R #{node['zap']['user']}:#{node['zap']['group']} /opt/zap-#{node['zap']['version']} &&
  chmod -R u+rw  /opt/zap-#{node['zap']['version']}"

link "/opt/zaproxy" do
  to "/opt/zap-#{node['zap']['version']}"
end

package "openjdk-6-jdk"
package "xvfb"

directory node['zap']['config_dir'] do
  owner node['zap']['user']
  group node['zap']['group']
  recursive true
end

file "#{node['zap']['config_dir']}/AcceptedLicense" do
  owner node['zap']['user']
  group node['zap']['group']
end

template "#{node['zap']['config_dir']}/config.xml" do
  owner node['zap']['user']
  group node['zap']['group']
end

template "/etc/init.d/zaproxy" do
  mode "0700"
end

service "zaproxy" do
  action [:enable, :start]
end
