#
# Cookbook Name:: jenkins
# Based on hudson
# Attributes:: default
#
# Author:: Doug MacEachern <dougm@vmware.com>
# Author:: Fletcher Nichol <fnichol@nichol.ca>
#
# Copyright 2010, VMware, Inc.
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

default[:jenkins][:mirror] = "http://mirrors.jenkins-ci.org"
default[:jenkins][:package_url] = "http://pkg.jenkins-ci.org"
default[:jenkins][:java_home] = ENV['JAVA_HOME']

default[:jenkins][:server][:home] = "/var/lib/jenkins"
default[:jenkins][:server][:user] = "jenkins"

case node[:platform]
when "debian", "ubuntu"
  default[:jenkins][:server][:group] = "nogroup"
else
  default[:jenkins][:server][:group] = node[:jenkins][:server][:user]
end

default[:jenkins][:server][:port] = 8080
default[:jenkins][:server][:host] = node[:fqdn]
default[:jenkins][:server][:url]  = "http://#{node[:jenkins][:server][:host]}:#{node[:jenkins][:server][:port]}"

default[:jenkins][:iptables_allow] = "disable"

#download the latest version of plugins, bypassing update center
#example: ["git", "URLSCM", ...]
default[:jenkins][:server][:plugins] = []

#working around: http://tickets.opscode.com/browse/CHEF-1848
#set to true if you have the CHEF-1848 patch applied
default[:jenkins][:server][:use_head] = false

#See Jenkins >> Nodes >> $name >> Configure

#"Name"
default[:jenkins][:node][:name] = node[:fqdn]

#"Description"
default[:jenkins][:node][:description] =
  "#{node[:platform]} #{node[:platform_version]} " <<
  "[#{node[:kernel][:os]} #{node[:kernel][:release]} #{node[:kernel][:machine]}] " <<
  "slave on #{node[:hostname]}"

#"# of executors"
default[:jenkins][:node][:executors] = 1

#"Remote FS root"
if node[:os] == "windows"
  default[:jenkins][:node][:home] = "C:/jenkins"
elsif node[:os] == "darwin"
  default[:jenkins][:node][:home] = "/Users/jenkins"
else
  default[:jenkins][:node][:home] = "/home/jenkins"
end

#"Labels"
default[:jenkins][:node][:labels] = (node[:tags] || []).join(" ")

#"Usage"
#  "Utilize this slave as much as possible" -> "normal"
#  "Leave this machine for tied jobs only"  -> "exclusive"
default[:jenkins][:node][:mode] = "normal"

#"Launch method"
#  "Launch slave agents via JNLP"                        -> "jnlp"
#  "Launch slave via execution of command on the Master" -> "command"
#  "Launch slave agents on Unix machines via SSH"         -> "ssh"
if node[:os] == "windows"
  default[:jenkins][:node][:launcher] = "jnlp"
else
  default[:jenkins][:node][:launcher] = "ssh"
end

#"Availability"
#  "Keep this slave on-line as much as possible"                   -> "always"
#  "Take this slave on-line when in demand and off-line when idle" -> "demand"
default[:jenkins][:node][:availability] = "always"

#  "In demand delay"
default[:jenkins][:node][:in_demand_delay] = 0
#  "Idle delay"
default[:jenkins][:node][:idle_delay] = 1

#"Node Properties"
#[x] "Environment Variables"
default[:jenkins][:node][:env] = nil

default[:jenkins][:node][:user] = "jenkins-node"

#SSH options
default[:jenkins][:node][:ssh_host] = node[:fqdn]
default[:jenkins][:node][:ssh_port] = 22
default[:jenkins][:node][:ssh_user] = default[:jenkins][:node][:user]
default[:jenkins][:node][:ssh_pass] = nil
default[:jenkins][:node][:jvm_options] = nil
#jenkins master defaults to: "#{ENV['HOME']}/.ssh/id_rsa"
default[:jenkins][:node][:ssh_private_key] = nil

default[:jenkins][:http_proxy][:variant]              = nil
default[:jenkins][:http_proxy][:www_redirect]         = "disable"
default[:jenkins][:http_proxy][:listen_ports]         = [ 80 ]
default[:jenkins][:http_proxy][:host_name]            = nil
default[:jenkins][:http_proxy][:host_aliases]         = []
default[:jenkins][:http_proxy][:client_max_body_size] = "1024m"
default[:jenkins][:http_proxy][:basic_auth_username] = "jenkins"
default[:jenkins][:http_proxy][:basic_auth_password] = "jenkins"


default[:jenkins][:git][:public] = "
-----BEGIN RSA PRIVATE KEY-----
MIIEpQIBAAKCAQEAvQmRBS08XljgSJDkHdEp5uNswUp/1rM3duid/aTNQ4B1NWbR
SdVXc1fUJs28tWT7pyJUwwQaaoUb/N4WTcPSlThORJhLT+QJwB3dm4URnqbkynDV
Wbt0j6txm2vZwy1IwLu0reCZ6cbzu3YUI7yGbMIlsGSsl/ItcJcXI3I5H9JivzFg
sDltEcty23j+fpYsSPZhavAMMEqavUuF+wfE3qF9b6uIl40hopKoDaFTUFqP7+su
94NXOEWasejO6PO7ot6b3kTgc3AIW13AlDZOwjiORY8MZro16hqcGyp44NxBsMgR
CDZlgBP4nviaSacQuBigg2444+KbRk6R4t+WnQIDAQABAoIBAAfcLvh9IgZ2QZUi
2SlYOhrMmAgNdfVSbFr4XyFdyd8lpzn6NXeRdFpqa3rVkSQlt8UCS230bLjDIh/I
iDrhio8D0VVO08rVm4Yud7lwtgPXwqmcOXLKtZUHtuiUenCAIIdLBr84GI485IOF
7F50B07cX77O4NJMkpEc5yxlInTtMzwbWcuVeAeAqk7cxekoMR7gwFmduZB6BApG
YmWLb4LmqKi9TS4DkxfxN2PCo2zteDKWczIi+5wl9gldadkydPytewCCGkhRXwpn
N58Z0fbWQ4kaM3qHNUNjvDelXyrp5NNIsY8MtvXzUMR8vPWNHMPJWX0KjJlhosb7
PnulQqECgYEA301nIVIYBVoh11nMHSwOR9/8Qb/Xcvyaec0/f7je6q/i1kQxvUTv
ZywWMDDwOZpzUqFPo1HX8mUGA2qJefSjrRgqcUMtplHX8gbOt/Ul6jD3lJnOhHzf
5UEe3gqd7Z44T6cyhWtHxAuxFVM54OIUi5UDDy0KZt4U9xbUSzD/qukCgYEA2Le5
WL0tj3V1xILLhwxAF5p/gQ4DWZUN7l40W5Eu3AelzIXCs/6nBNGVbSeQM8YqZfrX
gLHFiMs1nYrgZGXdDQaqzVHNyCLxHQWG26+OjgeCU3KohTbqxmkx5EOxk2geYVhy
/QdYmYAyiGAtcYJvEri6UkOA4hgBrATTGr0sFZUCgYEAjTUiSUTjocbMbaUAWVY5
taPjniRVdwZcHTf4tqjOdnRBKqO3HGwSRBjx8wmPb63GzXLqrGmd+E+ADPr68p8M
PfJxLGyB2pIYz5kUcenZTw4mEddtbASXhR64CUuHcPLDw0MExLABkuydz9FwYVA2
E8poQ9mEoWZAtbu/Bcl3c7kCgYEApVBAiniEcJJhK226Y2Hs4hRwfrl5xLP21IX3
2oF9BUqwJrtCMptmPD7DhWhQj63yWahnCzyQOjEIzQxK70rkvDMBx21HVAuTcVft
71aTn7QKri0gb73ciU1lSYJ5yr/5rLgTvwADjdREt9Ll11hv8hAH0Qi9H7rAS7/C
aPs0zaECgYEAhQN1+ZY8HA+EXf5UlLt21Cv+b9XdMdMh0KJc2CTdEdYtoTqnYwcF
hO79E99iwK26CWPpxTlEjkOaeI/H837MyctUHnbaNFibE/ilKSDH4OwYO3KdlDiJ
geyiVPn9RL+ip4Qw5MS2dOVNNgpFxMijorJsGWkY0eoDRErrfQbjwD0=
-----END RSA PRIVATE KEY-----
"
default[:jenkins][:git][:private] = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC9CZEFLTxeWOBIkOQd0Snm42zBSn/Wszd26J39pM1DgHU1ZtFJ1VdzV9Qmzby1ZPunIlTDBBpqhRv83hZNw9KVOE5EmEtP5AnAHd2bhRGepuTKcNVZu3SPq3Gba9nDLUjAu7St4JnpxvO7dhQjvIZswiWwZKyX8i1wlxcjcjkf0mK/MWCwOW0Ry3LbeP5+lixI9mFq8AwwSpq9S4X7B8TeoX1vq4iXjSGikqgNoVNQWo/v6y73g1c4RZqx6M7o87ui3pveROBzcAhbXcCUNk7COI5FjwxmujXqGpwbKnjg3EGwyBEINmWAE/ie+JpJpxC4GKCDbjjj4ptGTpHi35ad default@default"
default[:jenkins][:git][:user] = "jenkins"
default[:jenkins][:git][:email] = "jenkins@jenkins.com"