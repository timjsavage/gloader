include_recipe "apache2::mod_python"

version = node[:graphite][:version]
pyver = node[:graphite][:python_version]

package "python-cairo-dev"
package "python-django"
package "python-django-tagging"
package "python-memcache"
package "python-rrdtool"

remote_file "/usr/src/graphite-web-#{version}.tar.gz" do
  source node[:graphite][:graphite_web][:uri]
  checksum node[:graphite][:graphite_web][:checksum]
end

execute "untar graphite-web" do
  command "tar xzf graphite-web-#{version}.tar.gz"
  creates "/usr/src/graphite-web-#{version}"
  cwd "/usr/src"
end

execute "install graphite-web" do
  command "python setup.py install"
  creates "/opt/graphite/webapp/graphite_web-#{version}-py#{pyver}.egg-info"
  cwd "/usr/src/graphite-web-#{version}"
end

template "/etc/apache2/sites-available/graphite" do
  source "graphite-vhost.conf.erb"
  notifies  :restart, 'service[apache2]'
end

apache_site "000-default" do
  enable false
end

apache_site "graphite"

template "/opt/graphite/webapp/htpasswd" do
  variables( :username => node.graphite.basic_auth_username,
             :password => node.graphite.basic_auth_password)
  owner node.apache.user
  group node.apache.user
  mode 0600
end

directory "/opt/graphite/storage/log" do
  owner "www-data"
  group "www-data"
end

directory "/opt/graphite/storage/log/webapp" do
  owner "www-data"
  group "www-data"
end

directory "/opt/graphite/storage" do
  owner "www-data"
  group "www-data"
end

directory "/opt/graphite/storage/whisper" do
  owner "www-data"
  group "www-data"
end

cookbook_file "/opt/graphite/bin/set_admin_passwd.py" do
  mode "755"
end

cookbook_file "/opt/graphite/storage/graphite.db" do
  action :create_if_missing
  notifies :run, "execute[set admin password]"
end

execute "set admin password" do
  command "/opt/graphite/bin/set_admin_passwd.py root #{node[:graphite][:password]}"
  action :nothing
end

file "/opt/graphite/storage/graphite.db" do
  owner "www-data"
  group "www-data"
  mode "644"
end
