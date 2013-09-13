logrotate_app "logstash" do
  path "#{node[:logstash][:basedir]}/server/log/*.log"
  frequency "daily"
  rotate "7"
  create "664 #{node[:logstash][:user]} #{node[:logstash][:group]}"
end

template "#{node[:logstash][:basedir]}/server/etc/logstash_indices.json" do
  path   "#{node[:logstash][:basedir]}/server/etc/logstash_indices.json"
  source "logstash_indices.json"
  owner "#{node[:logstash][:user]}"
  group "#{node[:logstash][:group]}"
  mode "0644"
end

bash "Install logstash index template into ElasticSearch" do
  user    'root'
  code    "curl -XPUT -d @#{node[:logstash][:basedir]}/server/etc/logstash_indices.json http://localhost:9200/_template/logstash_per_index"
  only_if "test -d #{node.elasticsearch[:dir]}/elasticsearch"
end

template "#{node[:logstash][:basedir]}/server/bin/logstash-index-optimise.sh" do
  path   "#{node[:logstash][:basedir]}/server/bin/logstash-index-optimise.sh"
  source "logstash-index-optimise.sh.erb"
  owner "#{node[:logstash][:user]}"
  group "#{node[:logstash][:group]}"
  mode "0755"
end

template "/etc/cron.d/logstash" do
  path "/etc/cron.d/logstash"
  source "cron.d/logstash.erb"
  owner "root"
  group "root"
  mode "0644"
end