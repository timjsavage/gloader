#
## Cookbook Name:: bosh
## Recipe:: default
##
## Copyright 2012, Armakuni Ltd
##
## Licensed under the Apache License, Version 2.0 (the "License");
## you may not use this file except in compliance with the License.
## You may obtain a copy of the License at
##
##     http://www.apache.org/licenses/LICENSE-2.0
##
## Unless required by applicable law or agreed to in writing, software  
## distributed under the License is distributed on an "AS IS" BASIS,
## WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
## See the License for the specific language governing permissions and  
## limitations under the License.
##
#

%w{/var/vcap/data/packages/director/5/bosh/director/vendor/bundle/ruby/1.9.1/gems/aws-sdk-1.3.8/ca-bundle.crt /var/vcap/data/packages/aws_registry/3/bosh/aws_registry/vendor/bundle/ruby/1.9.1/gems/aws-sdk-1.3.6/ca-bundle.crt}.each do |bundle|
  cookbook_file bundle do
    owner "vcap"
    group "vcap"
    mode "644"
  end
end

bash "AWS eu-west-1 endpoint hosts override" do
  user "root"
  code "echo \"#{node.bosh.awshosts.euwest1} ec2.eu-west-1.amazonaws.com\" >> /etc/hosts"
  not_if "grep ec2.eu-west-1.amazonaws.com /etc/hosts"
end

bash "AWS us-east-1 endpoint hosts override" do
  user "root"
  code "echo \"#{node.bosh.awshosts.useast1} ec2.us-east-1.amazonaws.com\" >> /etc/hosts"
  not_if "grep ec2.us-east-1.amazonaws.com /etc/hosts"
end

%w{data/jobs/micro_aws/2/packages/director/bosh/director/lib/director/client.rb data/packages/director/5/bosh/director/lib/director/client.rb jobs/micro_aws/packages/director/bosh/director/lib/director/client.rb packages/director/bosh/director/lib/director/client.rb}.each do |file|
  bash "Increase timeouts to 10 minutes in BOSH" do
    user "root"
    code "sed -i 's/wait_until_ready(deadline = 300)/wait_until_ready(deadline = 600)/g' /var/vcap/#{file}"
  end
end

bash "Restart workers" do
  user "root"
  code "ps aux | grep [r]esque | awk {'print $2'} | xargs kill"
end
