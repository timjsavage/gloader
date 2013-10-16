#
# Cookbook Name:: jenkins_backup
# Recipe:: default
#
# Copyright 2012, Comic Relief
#
# All rights reserved - Do Not Redistribute
#

s3_curl_root = "/opt/s3-curl"

directory s3_curl_root do
  action :create
end

remote_file "#{s3_curl_root}/s3-curl.zip" do
  source "http://s3.amazonaws.com/doc/s3-example-code/s3-curl.zip"
  mode "0600"
  action :create
end

package "unzip" do
  action :install
end

package "libdigest-hmac-perl" do
  action :install
end

execute "extract-s3-curl" do
  command "rm -rf s3-curl && unzip s3-curl.zip"
  cwd s3_curl_root
  action :run
end

file "#{s3_curl_root}/s3-curl/s3curl.pl" do
  mode "0700"
  action :create
end

template "/root/.s3curl" do
  source "s3curl.erb"
  variables({
    :id => node['jenkins_backup']['access_key_id'],
    :key => node['jenkins_backup']['secret_access_key']
  })
  action :create
end

template "/root/backup-jenkins.sh" do
  variables({
    :archive_dir => Chef::Config[:file_cache_path],
    :jenkins_home => node['jenkins']['server']['home'],
    :s3_curl_root => s3_curl_root
  })
  mode "0700"
  action :create
end

cron "backup-jenkins" do
  hour "18"
  minute "45"
  command "/root/backup-jenkins.sh"
end
