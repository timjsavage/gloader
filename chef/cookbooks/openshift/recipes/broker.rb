include_recipe "openshift::common"

execute "install-broker" do
  cwd File.join(node['openshift']['crankcase_checkout_path'], 'build')
  environment({'HOME' => '/home/openshift'})
  user "openshift"
  command "rake devbroker"
  action :run
end

gw = node['network']['interfaces']['eth0']['routes'].find{|r| r['destination'] == 'default'}['via']
execute "ss-setup-broker --external-ip #{node['ipaddress']}/24 --external-gw #{gw}"

## Currently the qpid amqp server that the nodes connect to for mcollective
## does not start successfully. As a workaround manually start qpid.
execute "start-qpid" do
  command "nohup qpidd -d"
  not_if "systemctl status qpid.service"
  not_if "ps -A | grep qpidd"
end

node['openshift']['users'].each do |username|
  execute "add-user-#{username}" do
    password = '2a8462d93a13e51387a5e607cbd1139f'
    user_json = %Q{{"_id":"#{username}","user":"#{username}","password":"#{password}"}}
    command %Q{mongo stickshift_broker_dev --eval 'db.auth_user.update({"_id":"#{username}"}, #{user_json}, true)'}
    action :run
  end
end

include_recipe "openshift::rhc"
include_recipe "build-essential::default"
include_recipe "rbenv::system"
include_recipe "openshift::selinux_hack"
