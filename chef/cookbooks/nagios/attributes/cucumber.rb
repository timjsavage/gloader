default['nagios']['cucumber'] = Mash.new
default['nagios']['cucumber']['gem_version'] = '0.9.2'
default['nagios']['cucumber']['project'] = 'donations-systest'
default['nagios']['cucumber']['repository'] = "git@github.com:comicrelief/#{node['nagios']['cucumber']['project']}.git"
default['nagios']['cucumber']['ruby_version'] = '1.9.3-p194'
