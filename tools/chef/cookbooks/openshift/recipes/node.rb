include_recipe "openshift::common"

execute "install-node" do
  cwd File.join(node['openshift']['crankcase_checkout_path'], 'build')
  environment({'HOME' => '/home/openshift'})
  user "openshift"
  command "rake devnode"
  action :run
end

include_recipe "openshift::selinux_hack"

file "/etc/resolv.conf" do
  action :delete
end
