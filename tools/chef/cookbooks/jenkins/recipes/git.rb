#
# Cookbook Name:: jenkins
# Based on hudson
# Recipe:: git_keys
#
# Author:: Colin Humphreys <colin@armakuni.com>
#
# Copyright 2012, Armakuni, Ltd.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "git"

directory "/var/lib/jenkins/.ssh/" do
  owner "jenkins"
  mode "0700"
  action :create
end

template "/var/lib/jenkins/.ssh/id_rsa.pub" do
  backup false
  owner "jenkins"
  mode "0644"
  source "jenkins.id_rsa.pub.erb"
  action :create
  variables(
      :key => node["jenkins"]["git"]["public"]
  )
end

template "/var/lib/jenkins/.ssh/id_rsa" do
  backup false
  owner "jenkins"
  mode "0600"
  source "jenkins.id_rsa.erb"
  action :create
  variables(
    :key => node["jenkins"]["git"]["private"]
  )
end

file "/var/lib/jenkins/.ssh/config" do
  owner "jenkins"
  content "StrictHostKeyChecking no"
end
  

template "/var/lib/jenkins/.gitconfig" do
  owner "jenkins"
  source "config.ssh.erb"
  variables(
    :user => node["jenkins"]["git"]["user"],
    :email => node["jenkins"]["git"]["email"]
  )
end
