default[:logstash][:kibana][:repo] = "git://github.com/rashidkpc/Kibana.git"
default[:logstash][:kibana][:sha] = "cfb13eaa4704fe4c9106bf9673123ce767d8afac"
default[:logstash][:kibana][:apache_template] = "kibana.conf.erb"
default[:logstash][:kibana][:config] = "kibana-config.php.erb"
default[:logstash][:kibana][:elasticsearch_role] = "logstash_server"
default[:logstash][:kibana][:apache2_server_name] = node.ipaddress
default[:logstash][:kibana][:basic_auth_username] = "armakuni"
default[:logstash][:kibana][:basic_auth_password] = "wasntmeguv"
