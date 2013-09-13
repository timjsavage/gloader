if node.attribute?('rackspace')
  rhc_user = "root"
  home_dir = "/root"
else
  rhc_user = "ec2-user"
  home_dir = "/home/#{rhc_user}"
end

# point rhc at local broker
directory "#{home_dir}/.openshift" do
  owner rhc_user
  group rhc_user
  mode "0700"
  action :create
end

file "#{home_dir}/.openshift/express.conf" do
  content "libra_server=broker.example.com\n"
  owner rhc_user
  group rhc_user
  mode "0600"
  action :create
end

# avoid prompting on initial app creation
file "#{home_dir}/.ssh/config" do
  content "StrictHostKeyChecking=no"
  owner rhc_user
  group rhc_user
  mode "0600"
  action :create
end

file "#{home_dir}/.ssh/id_rsa" do
  action :delete
end

file "#{home_dir}/.ssh/id_rsa.pub" do
  action :delete
end
