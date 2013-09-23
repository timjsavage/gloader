# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "gloader"
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Benedict Dodd"]
  s.date = "2013-09-23"
  s.description = "Buids Grinder load test platform and controls test runs"
  s.email = "mail@bendodd.com"
  s.executables = ["gloader"]
  s.extra_rdoc_files = [
    "LICENSE",
    "README.md"
  ]
  s.files = [
    ".rubocop.yml",
    ".travis.yml",
    "Gemfile",
    "Gemfile.lock",
    "Guardfile",
    "LICENSE",
    "README.md",
    "Rakefile",
    "VERSION",
    "bin/gloader",
    "chef/cookbooks/apache2/CHANGELOG.md",
    "chef/cookbooks/apache2/CONTRIBUTING",
    "chef/cookbooks/apache2/LICENSE",
    "chef/cookbooks/apache2/README.md",
    "chef/cookbooks/apache2/attributes/default.rb",
    "chef/cookbooks/apache2/attributes/mod_auth_openid.rb",
    "chef/cookbooks/apache2/definitions/apache_conf.rb",
    "chef/cookbooks/apache2/definitions/apache_module.rb",
    "chef/cookbooks/apache2/definitions/apache_site.rb",
    "chef/cookbooks/apache2/definitions/web_app.rb",
    "chef/cookbooks/apache2/files/default/apache2_module_conf_generate.pl",
    "chef/cookbooks/apache2/metadata.json",
    "chef/cookbooks/apache2/metadata.rb",
    "chef/cookbooks/apache2/recipes/default.rb",
    "chef/cookbooks/apache2/recipes/god_monitor.rb",
    "chef/cookbooks/apache2/recipes/mod_alias.rb",
    "chef/cookbooks/apache2/recipes/mod_apreq2.rb",
    "chef/cookbooks/apache2/recipes/mod_auth_basic.rb",
    "chef/cookbooks/apache2/recipes/mod_auth_digest.rb",
    "chef/cookbooks/apache2/recipes/mod_auth_openid.rb",
    "chef/cookbooks/apache2/recipes/mod_authn_file.rb",
    "chef/cookbooks/apache2/recipes/mod_authnz_ldap.rb",
    "chef/cookbooks/apache2/recipes/mod_authz_default.rb",
    "chef/cookbooks/apache2/recipes/mod_authz_groupfile.rb",
    "chef/cookbooks/apache2/recipes/mod_authz_host.rb",
    "chef/cookbooks/apache2/recipes/mod_authz_user.rb",
    "chef/cookbooks/apache2/recipes/mod_autoindex.rb",
    "chef/cookbooks/apache2/recipes/mod_cgi.rb",
    "chef/cookbooks/apache2/recipes/mod_dav.rb",
    "chef/cookbooks/apache2/recipes/mod_dav_fs.rb",
    "chef/cookbooks/apache2/recipes/mod_dav_svn.rb",
    "chef/cookbooks/apache2/recipes/mod_deflate.rb",
    "chef/cookbooks/apache2/recipes/mod_dir.rb",
    "chef/cookbooks/apache2/recipes/mod_env.rb",
    "chef/cookbooks/apache2/recipes/mod_expires.rb",
    "chef/cookbooks/apache2/recipes/mod_fcgid.rb",
    "chef/cookbooks/apache2/recipes/mod_headers.rb",
    "chef/cookbooks/apache2/recipes/mod_ldap.rb",
    "chef/cookbooks/apache2/recipes/mod_log_config.rb",
    "chef/cookbooks/apache2/recipes/mod_logio.rb",
    "chef/cookbooks/apache2/recipes/mod_mime.rb",
    "chef/cookbooks/apache2/recipes/mod_negotiation.rb",
    "chef/cookbooks/apache2/recipes/mod_perl.rb",
    "chef/cookbooks/apache2/recipes/mod_php5.rb",
    "chef/cookbooks/apache2/recipes/mod_proxy.rb",
    "chef/cookbooks/apache2/recipes/mod_proxy_ajp.rb",
    "chef/cookbooks/apache2/recipes/mod_proxy_balancer.rb",
    "chef/cookbooks/apache2/recipes/mod_proxy_connect.rb",
    "chef/cookbooks/apache2/recipes/mod_proxy_http.rb",
    "chef/cookbooks/apache2/recipes/mod_python.rb",
    "chef/cookbooks/apache2/recipes/mod_rewrite.rb",
    "chef/cookbooks/apache2/recipes/mod_setenvif.rb",
    "chef/cookbooks/apache2/recipes/mod_ssl.rb",
    "chef/cookbooks/apache2/recipes/mod_status.rb",
    "chef/cookbooks/apache2/recipes/mod_wsgi.rb",
    "chef/cookbooks/apache2/recipes/mod_xsendfile.rb",
    "chef/cookbooks/apache2/templates/default/a2dismod.erb",
    "chef/cookbooks/apache2/templates/default/a2dissite.erb",
    "chef/cookbooks/apache2/templates/default/a2enmod.erb",
    "chef/cookbooks/apache2/templates/default/a2ensite.erb",
    "chef/cookbooks/apache2/templates/default/apache2.conf.erb",
    "chef/cookbooks/apache2/templates/default/apache2.god.erb",
    "chef/cookbooks/apache2/templates/default/charset.erb",
    "chef/cookbooks/apache2/templates/default/default-site.erb",
    "chef/cookbooks/apache2/templates/default/mods/README",
    "chef/cookbooks/apache2/templates/default/mods/alias.conf.erb",
    "chef/cookbooks/apache2/templates/default/mods/authopenid.load.erb",
    "chef/cookbooks/apache2/templates/default/mods/autoindex.conf.erb",
    "chef/cookbooks/apache2/templates/default/mods/deflate.conf.erb",
    "chef/cookbooks/apache2/templates/default/mods/dir.conf.erb",
    "chef/cookbooks/apache2/templates/default/mods/fcgid.conf.erb",
    "chef/cookbooks/apache2/templates/default/mods/mime.conf.erb",
    "chef/cookbooks/apache2/templates/default/mods/negotiation.conf.erb",
    "chef/cookbooks/apache2/templates/default/mods/php5.conf.erb",
    "chef/cookbooks/apache2/templates/default/mods/proxy.conf.erb",
    "chef/cookbooks/apache2/templates/default/mods/setenvif.conf.erb",
    "chef/cookbooks/apache2/templates/default/mods/ssl.conf.erb",
    "chef/cookbooks/apache2/templates/default/mods/status.conf.erb",
    "chef/cookbooks/apache2/templates/default/port_apache.erb",
    "chef/cookbooks/apache2/templates/default/ports.conf.erb",
    "chef/cookbooks/apache2/templates/default/security.erb",
    "chef/cookbooks/apache2/templates/default/web_app.conf.erb",
    "chef/cookbooks/apt/CHANGELOG.md",
    "chef/cookbooks/apt/CONTRIBUTING",
    "chef/cookbooks/apt/LICENSE",
    "chef/cookbooks/apt/README.md",
    "chef/cookbooks/apt/files/default/apt-proxy-v2.conf",
    "chef/cookbooks/apt/metadata.json",
    "chef/cookbooks/apt/metadata.rb",
    "chef/cookbooks/apt/providers/preference.rb",
    "chef/cookbooks/apt/providers/repository.rb",
    "chef/cookbooks/apt/recipes/cacher-client.rb",
    "chef/cookbooks/apt/recipes/cacher-ng.rb",
    "chef/cookbooks/apt/recipes/default.rb",
    "chef/cookbooks/apt/resources/preference.rb",
    "chef/cookbooks/apt/resources/repository.rb",
    "chef/cookbooks/ark/.gitignore",
    "chef/cookbooks/ark/.travis.yml",
    "chef/cookbooks/ark/CHANGELOG.md",
    "chef/cookbooks/ark/README.md",
    "chef/cookbooks/ark/Rakefile",
    "chef/cookbooks/ark/Toftfile",
    "chef/cookbooks/ark/Vagrantfile",
    "chef/cookbooks/ark/attributes/default.rb",
    "chef/cookbooks/ark/files/default/foo.tar.gz",
    "chef/cookbooks/ark/files/default/foo.tbz",
    "chef/cookbooks/ark/files/default/foo.tgz",
    "chef/cookbooks/ark/files/default/foo.zip",
    "chef/cookbooks/ark/files/default/tests/minitest/test_test.rb",
    "chef/cookbooks/ark/libraries/provider_ark.rb",
    "chef/cookbooks/ark/libraries/resource_ark.rb",
    "chef/cookbooks/ark/metadata.json",
    "chef/cookbooks/ark/metadata.rb",
    "chef/cookbooks/ark/recipes/default.rb",
    "chef/cookbooks/ark/recipes/test.rb",
    "chef/cookbooks/bosh/attributes/default.rb",
    "chef/cookbooks/bosh/files/default/ca-bundle.crt",
    "chef/cookbooks/bosh/metadata.json",
    "chef/cookbooks/bosh/metadata.rb",
    "chef/cookbooks/bosh/recipes/default.rb",
    "chef/cookbooks/build-essential/CHANGELOG.md",
    "chef/cookbooks/build-essential/CONTRIBUTING",
    "chef/cookbooks/build-essential/LICENSE",
    "chef/cookbooks/build-essential/README.md",
    "chef/cookbooks/build-essential/attributes/default.rb",
    "chef/cookbooks/build-essential/metadata.json",
    "chef/cookbooks/build-essential/metadata.rb",
    "chef/cookbooks/build-essential/recipes/default.rb",
    "chef/cookbooks/bundler/attributes/bundler.rb",
    "chef/cookbooks/bundler/metadata.json",
    "chef/cookbooks/bundler/readme.md",
    "chef/cookbooks/bundler/recipes/default.rb",
    "chef/cookbooks/bundler/recipes/install.rb",
    "chef/cookbooks/bundler/recipes/lock.rb",
    "chef/cookbooks/bundler/recipes/pack.rb",
    "chef/cookbooks/bundler/recipes/unlock.rb",
    "chef/cookbooks/collectd_proxy/attributes/default.rb",
    "chef/cookbooks/collectd_proxy/files/default/collect_proxy_binary",
    "chef/cookbooks/collectd_proxy/files/default/collectd_proxy_plugin_network.so",
    "chef/cookbooks/collectd_proxy/files/default/collectd_proxy_plugin_write_graphite.so",
    "chef/cookbooks/collectd_proxy/metadata.json",
    "chef/cookbooks/collectd_proxy/metadata.rb",
    "chef/cookbooks/collectd_proxy/recipes/default.rb",
    "chef/cookbooks/collectd_proxy/templates/default/config.erb",
    "chef/cookbooks/collectd_proxy/templates/default/init-script.erb",
    "chef/cookbooks/elasticsearch/.gitignore",
    "chef/cookbooks/elasticsearch/Berksfile",
    "chef/cookbooks/elasticsearch/Gemfile",
    "chef/cookbooks/elasticsearch/README.markdown",
    "chef/cookbooks/elasticsearch/Vagrantfile",
    "chef/cookbooks/elasticsearch/attributes/default.rb",
    "chef/cookbooks/elasticsearch/attributes/plugin_aws.rb",
    "chef/cookbooks/elasticsearch/attributes/proxy_nginx.rb",
    "chef/cookbooks/elasticsearch/chefignore",
    "chef/cookbooks/elasticsearch/definitions/install_plugin.rb",
    "chef/cookbooks/elasticsearch/files/default/tests/minitest/cluster_test.rb",
    "chef/cookbooks/elasticsearch/files/default/tests/minitest/installation_test.rb",
    "chef/cookbooks/elasticsearch/files/default/tests/minitest/plugin_aws_test.rb",
    "chef/cookbooks/elasticsearch/files/default/tests/minitest/proxy_nginx_test.rb",
    "chef/cookbooks/elasticsearch/files/default/tests/minitest/service_test.rb",
    "chef/cookbooks/elasticsearch/metadata.json",
    "chef/cookbooks/elasticsearch/metadata.rb",
    "chef/cookbooks/elasticsearch/recipes/curl.rb",
    "chef/cookbooks/elasticsearch/recipes/default.rb",
    "chef/cookbooks/elasticsearch/recipes/plugin_aws.rb",
    "chef/cookbooks/elasticsearch/recipes/proxy_nginx.rb",
    "chef/cookbooks/elasticsearch/templates/default/elasticsearch-env.sh.erb",
    "chef/cookbooks/elasticsearch/templates/default/elasticsearch.conf.erb",
    "chef/cookbooks/elasticsearch/templates/default/elasticsearch.init.erb",
    "chef/cookbooks/elasticsearch/templates/default/elasticsearch.yml.erb",
    "chef/cookbooks/elasticsearch/templates/default/elasticsearch_proxy_nginx.conf.erb",
    "chef/cookbooks/git/CHANGELOG.md",
    "chef/cookbooks/git/CONTRIBUTING",
    "chef/cookbooks/git/LICENSE",
    "chef/cookbooks/git/README.md",
    "chef/cookbooks/git/attributes/default.rb",
    "chef/cookbooks/git/metadata.json",
    "chef/cookbooks/git/metadata.rb",
    "chef/cookbooks/git/recipes/default.rb",
    "chef/cookbooks/git/recipes/server.rb",
    "chef/cookbooks/git/templates/default/sv-git-daemon-log-run.erb",
    "chef/cookbooks/git/templates/default/sv-git-daemon-run.erb",
    "chef/cookbooks/graphite/README.md",
    "chef/cookbooks/graphite/attributes/graphite.rb",
    "chef/cookbooks/graphite/files/default/graphite.db",
    "chef/cookbooks/graphite/files/default/set_admin_passwd.py",
    "chef/cookbooks/graphite/metadata.json",
    "chef/cookbooks/graphite/metadata.rb",
    "chef/cookbooks/graphite/recipes/carbon.rb",
    "chef/cookbooks/graphite/recipes/default.rb",
    "chef/cookbooks/graphite/recipes/web.rb",
    "chef/cookbooks/graphite/recipes/whisper.rb",
    "chef/cookbooks/graphite/templates/default/carbon.conf.erb",
    "chef/cookbooks/graphite/templates/default/graphite-vhost.conf.erb",
    "chef/cookbooks/graphite/templates/default/htpasswd.erb",
    "chef/cookbooks/graphite/templates/default/storage-schemas.conf.erb",
    "chef/cookbooks/graphite/templates/default/sv-carbon-cache-finish.erb",
    "chef/cookbooks/graphite/templates/default/sv-carbon-cache-log-run.erb",
    "chef/cookbooks/graphite/templates/default/sv-carbon-cache-run.erb",
    "chef/cookbooks/grinder/README.md",
    "chef/cookbooks/grinder/attributes/default.rb",
    "chef/cookbooks/grinder/metadata.json",
    "chef/cookbooks/grinder/metadata.rb",
    "chef/cookbooks/grinder/recipes/default.rb",
    "chef/cookbooks/haproxy/CHANGELOG.md",
    "chef/cookbooks/haproxy/CONTRIBUTING",
    "chef/cookbooks/haproxy/LICENSE",
    "chef/cookbooks/haproxy/README.md",
    "chef/cookbooks/haproxy/attributes/default.rb",
    "chef/cookbooks/haproxy/metadata.json",
    "chef/cookbooks/haproxy/metadata.rb",
    "chef/cookbooks/haproxy/recipes/app_lb.rb",
    "chef/cookbooks/haproxy/recipes/default.rb",
    "chef/cookbooks/haproxy/templates/default/haproxy-app_lb.cfg.erb",
    "chef/cookbooks/haproxy/templates/default/haproxy-default.erb",
    "chef/cookbooks/haproxy/templates/default/haproxy.cfg.erb",
    "chef/cookbooks/java/CHANGELOG.md",
    "chef/cookbooks/java/CONTRIBUTING",
    "chef/cookbooks/java/LICENSE",
    "chef/cookbooks/java/README.md",
    "chef/cookbooks/java/attributes/default.rb",
    "chef/cookbooks/java/metadata.json",
    "chef/cookbooks/java/metadata.rb",
    "chef/cookbooks/java/providers/ark.rb",
    "chef/cookbooks/java/recipes/default.rb",
    "chef/cookbooks/java/recipes/openjdk.rb",
    "chef/cookbooks/java/recipes/oracle.rb",
    "chef/cookbooks/java/recipes/oracle_i386.rb",
    "chef/cookbooks/java/resources/ark.rb",
    "chef/cookbooks/jenkins/.gitignore",
    "chef/cookbooks/jenkins/README.md",
    "chef/cookbooks/jenkins/attributes/default.rb",
    "chef/cookbooks/jenkins/files/default/node_info.groovy",
    "chef/cookbooks/jenkins/files/ubuntu/jenkins.list",
    "chef/cookbooks/jenkins/libraries/manage_node.rb",
    "chef/cookbooks/jenkins/metadata.rb",
    "chef/cookbooks/jenkins/providers/cli.rb",
    "chef/cookbooks/jenkins/providers/execute.rb",
    "chef/cookbooks/jenkins/providers/job.rb",
    "chef/cookbooks/jenkins/providers/node.rb",
    "chef/cookbooks/jenkins/recipes/default.rb",
    "chef/cookbooks/jenkins/recipes/git.rb",
    "chef/cookbooks/jenkins/recipes/headless.rb",
    "chef/cookbooks/jenkins/recipes/iptables.rb",
    "chef/cookbooks/jenkins/recipes/node_jnlp.rb",
    "chef/cookbooks/jenkins/recipes/node_ssh.rb",
    "chef/cookbooks/jenkins/recipes/node_windows.rb",
    "chef/cookbooks/jenkins/recipes/postgres.rb",
    "chef/cookbooks/jenkins/recipes/proxy_apache2.rb",
    "chef/cookbooks/jenkins/recipes/proxy_nginx.rb",
    "chef/cookbooks/jenkins/resources/cli.rb",
    "chef/cookbooks/jenkins/resources/execute.rb",
    "chef/cookbooks/jenkins/resources/job.rb",
    "chef/cookbooks/jenkins/resources/node.rb",
    "chef/cookbooks/jenkins/templates/default/apache_jenkins.erb",
    "chef/cookbooks/jenkins/templates/default/config.ssh.erb",
    "chef/cookbooks/jenkins/templates/default/htpasswd.erb",
    "chef/cookbooks/jenkins/templates/default/jenkins.erb",
    "chef/cookbooks/jenkins/templates/default/jenkins.id_rsa.erb",
    "chef/cookbooks/jenkins/templates/default/jenkins.id_rsa.pub.erb",
    "chef/cookbooks/jenkins/templates/default/nginx_jenkins.conf.erb",
    "chef/cookbooks/jenkins/templates/default/port_jenkins.erb",
    "chef/cookbooks/jenkins/templates/default/sv-hudson-slave-log-run.erb",
    "chef/cookbooks/jenkins/templates/default/sv-hudson-slave-run.erb",
    "chef/cookbooks/jenkins_backup/attributes/default.rb",
    "chef/cookbooks/jenkins_backup/metadata.json",
    "chef/cookbooks/jenkins_backup/metadata.rb",
    "chef/cookbooks/jenkins_backup/recipes/default.rb",
    "chef/cookbooks/jenkins_backup/templates/default/backup-jenkins.sh.erb",
    "chef/cookbooks/jenkins_backup/templates/default/s3curl.erb",
    "chef/cookbooks/logrotate/CHANGELOG.md",
    "chef/cookbooks/logrotate/CONTRIBUTING",
    "chef/cookbooks/logrotate/LICENSE",
    "chef/cookbooks/logrotate/README.md",
    "chef/cookbooks/logrotate/definitions/logrotate_app.rb",
    "chef/cookbooks/logrotate/metadata.json",
    "chef/cookbooks/logrotate/metadata.rb",
    "chef/cookbooks/logrotate/recipes/default.rb",
    "chef/cookbooks/logrotate/templates/default/logrotate.erb",
    "chef/cookbooks/logstash/README.md",
    "chef/cookbooks/logstash/attributes/agent.rb",
    "chef/cookbooks/logstash/attributes/default.rb",
    "chef/cookbooks/logstash/attributes/kibana.rb",
    "chef/cookbooks/logstash/attributes/pyshipper.rb",
    "chef/cookbooks/logstash/attributes/server.rb",
    "chef/cookbooks/logstash/attributes/source.rb",
    "chef/cookbooks/logstash/files/cron.d/logstash",
    "chef/cookbooks/logstash/metadata.json",
    "chef/cookbooks/logstash/metadata.rb",
    "chef/cookbooks/logstash/recipes/agent.rb",
    "chef/cookbooks/logstash/recipes/curl.rb",
    "chef/cookbooks/logstash/recipes/default.rb",
    "chef/cookbooks/logstash/recipes/kibana.rb",
    "chef/cookbooks/logstash/recipes/optimise.rb",
    "chef/cookbooks/logstash/recipes/pyshipper.rb",
    "chef/cookbooks/logstash/recipes/server.rb",
    "chef/cookbooks/logstash/recipes/source.rb",
    "chef/cookbooks/logstash/templates/default/agent.conf.erb",
    "chef/cookbooks/logstash/templates/default/cron.d/logstash.erb",
    "chef/cookbooks/logstash/templates/default/htpasswd.erb",
    "chef/cookbooks/logstash/templates/default/kibana-config.php.erb",
    "chef/cookbooks/logstash/templates/default/kibana.conf.erb",
    "chef/cookbooks/logstash/templates/default/logstash-index-optimise.sh.erb",
    "chef/cookbooks/logstash/templates/default/logstash_indices.json",
    "chef/cookbooks/logstash/templates/default/server.conf.erb",
    "chef/cookbooks/logstash/templates/default/sv-logstash_agent-log-run.erb",
    "chef/cookbooks/logstash/templates/default/sv-logstash_agent-run.erb",
    "chef/cookbooks/logstash/templates/default/sv-logstash_server-log-run.erb",
    "chef/cookbooks/logstash/templates/default/sv-logstash_server-run.erb",
    "chef/cookbooks/monit/LICENSE",
    "chef/cookbooks/monit/README.md",
    "chef/cookbooks/monit/README.rdoc",
    "chef/cookbooks/monit/attributes/default.rb",
    "chef/cookbooks/monit/files/ubuntu/monit.default",
    "chef/cookbooks/monit/libraries/monitrc.rb",
    "chef/cookbooks/monit/metadata.json",
    "chef/cookbooks/monit/metadata.rb",
    "chef/cookbooks/monit/recipes/default.rb",
    "chef/cookbooks/monit/recipes/postfix.rb",
    "chef/cookbooks/monit/recipes/ssh.rb",
    "chef/cookbooks/monit/templates/default/monitrc.erb",
    "chef/cookbooks/monit/templates/default/postfix.conf.erb",
    "chef/cookbooks/monit/templates/default/ssh.conf.erb",
    "chef/cookbooks/nagios/CHANGELOG.md",
    "chef/cookbooks/nagios/CONTRIBUTING",
    "chef/cookbooks/nagios/LICENSE",
    "chef/cookbooks/nagios/README.md",
    "chef/cookbooks/nagios/attributes/client.rb",
    "chef/cookbooks/nagios/attributes/cucumber.rb",
    "chef/cookbooks/nagios/attributes/default.rb",
    "chef/cookbooks/nagios/attributes/server.rb",
    "chef/cookbooks/nagios/definitions/nagios_conf.rb",
    "chef/cookbooks/nagios/files/default/nagios",
    "chef/cookbooks/nagios/files/default/plugins/check-mysql-slave.pl",
    "chef/cookbooks/nagios/files/default/plugins/check_mem.sh",
    "chef/cookbooks/nagios/files/default/plugins/check_mysqlhealth.pl",
    "chef/cookbooks/nagios/files/default/plugins/check_solr.rb",
    "chef/cookbooks/nagios/files/default/plugins/db_queues.rb",
    "chef/cookbooks/nagios/files/default/plugins/file_queues.rb",
    "chef/cookbooks/nagios/files/default/plugins/nagios_helper.rb",
    "chef/cookbooks/nagios/libraries/default.rb",
    "chef/cookbooks/nagios/metadata.json",
    "chef/cookbooks/nagios/metadata.rb",
    "chef/cookbooks/nagios/providers/nrpecheck.rb",
    "chef/cookbooks/nagios/recipes/client.rb",
    "chef/cookbooks/nagios/recipes/client_package.rb",
    "chef/cookbooks/nagios/recipes/client_source.rb",
    "chef/cookbooks/nagios/recipes/cucumber.rb",
    "chef/cookbooks/nagios/recipes/default.rb",
    "chef/cookbooks/nagios/recipes/pagerduty.rb",
    "chef/cookbooks/nagios/recipes/server.rb",
    "chef/cookbooks/nagios/recipes/server_package.rb",
    "chef/cookbooks/nagios/recipes/server_source.rb",
    "chef/cookbooks/nagios/resources/nrpecheck.rb",
    "chef/cookbooks/nagios/templates/default/apache2.conf.erb",
    "chef/cookbooks/nagios/templates/default/cgi.cfg.erb",
    "chef/cookbooks/nagios/templates/default/commands.cfg.erb",
    "chef/cookbooks/nagios/templates/default/contacts.cfg.erb",
    "chef/cookbooks/nagios/templates/default/cucumber-fetch-features.sh.erb",
    "chef/cookbooks/nagios/templates/default/cucumber-systest.sh.erb",
    "chef/cookbooks/nagios/templates/default/hostgroups.cfg.erb",
    "chef/cookbooks/nagios/templates/default/hosts.cfg.erb",
    "chef/cookbooks/nagios/templates/default/htpasswd.users.erb",
    "chef/cookbooks/nagios/templates/default/nagios-nrpe-server.erb",
    "chef/cookbooks/nagios/templates/default/nagios.cfg.erb",
    "chef/cookbooks/nagios/templates/default/nrpe.cfg.erb",
    "chef/cookbooks/nagios/templates/default/pagerduty_nagios.cfg.erb",
    "chef/cookbooks/nagios/templates/default/services.cfg.erb",
    "chef/cookbooks/nagios/templates/default/templates.cfg.erb",
    "chef/cookbooks/nagios/templates/default/timeperiods.cfg.erb",
    "chef/cookbooks/nodejs/README.rdoc",
    "chef/cookbooks/nodejs/attributes/default.rb",
    "chef/cookbooks/nodejs/metadata.json",
    "chef/cookbooks/nodejs/metadata.rb",
    "chef/cookbooks/nodejs/recipes/default.rb",
    "chef/cookbooks/nodejs/recipes/npm.rb",
    "chef/cookbooks/openshift/README.md",
    "chef/cookbooks/openshift/attributes/default.rb",
    "chef/cookbooks/openshift/metadata.json",
    "chef/cookbooks/openshift/metadata.rb",
    "chef/cookbooks/openshift/recipes/broker.rb",
    "chef/cookbooks/openshift/recipes/common.rb",
    "chef/cookbooks/openshift/recipes/node.rb",
    "chef/cookbooks/openshift/recipes/rhc.rb",
    "chef/cookbooks/openshift/recipes/selinux_hack.rb",
    "chef/cookbooks/openshift/specs/broker_spec.rb",
    "chef/cookbooks/openshift/specs/node_spec.rb",
    "chef/cookbooks/php/README.md",
    "chef/cookbooks/php/attributes/default.rb",
    "chef/cookbooks/php/metadata.json",
    "chef/cookbooks/php/metadata.rb",
    "chef/cookbooks/php/providers/pear.rb",
    "chef/cookbooks/php/providers/pear_channel.rb",
    "chef/cookbooks/php/recipes/default.rb",
    "chef/cookbooks/php/recipes/module_apc.rb",
    "chef/cookbooks/php/recipes/module_curl.rb",
    "chef/cookbooks/php/recipes/module_fileinfo.rb",
    "chef/cookbooks/php/recipes/module_fpdf.rb",
    "chef/cookbooks/php/recipes/module_gd.rb",
    "chef/cookbooks/php/recipes/module_ldap.rb",
    "chef/cookbooks/php/recipes/module_memcache.rb",
    "chef/cookbooks/php/recipes/module_mysql.rb",
    "chef/cookbooks/php/recipes/module_pgsql.rb",
    "chef/cookbooks/php/recipes/module_sqlite3.rb",
    "chef/cookbooks/php/recipes/package.rb",
    "chef/cookbooks/php/recipes/source.rb",
    "chef/cookbooks/php/resources/pear.rb",
    "chef/cookbooks/php/resources/pear_channel.rb",
    "chef/cookbooks/php/templates/centos/php.ini.erb",
    "chef/cookbooks/php/templates/debian/php.ini.erb",
    "chef/cookbooks/php/templates/default/extension.ini.erb",
    "chef/cookbooks/php/templates/default/php.ini.erb",
    "chef/cookbooks/php/templates/redhat/php.ini.erb",
    "chef/cookbooks/php/templates/ubuntu/php.ini.erb",
    "chef/cookbooks/python/CHANGELOG.md",
    "chef/cookbooks/python/CONTRIBUTING",
    "chef/cookbooks/python/LICENSE",
    "chef/cookbooks/python/README.md",
    "chef/cookbooks/python/attributes/default.rb",
    "chef/cookbooks/python/metadata.json",
    "chef/cookbooks/python/metadata.rb",
    "chef/cookbooks/python/providers/pip.rb",
    "chef/cookbooks/python/providers/virtualenv.rb",
    "chef/cookbooks/python/recipes/default.rb",
    "chef/cookbooks/python/recipes/package.rb",
    "chef/cookbooks/python/recipes/pip.rb",
    "chef/cookbooks/python/recipes/source.rb",
    "chef/cookbooks/python/recipes/virtualenv.rb",
    "chef/cookbooks/python/resources/pip.rb",
    "chef/cookbooks/python/resources/virtualenv.rb",
    "chef/cookbooks/rbenv/.gitignore",
    "chef/cookbooks/rbenv/.travis.yml",
    "chef/cookbooks/rbenv/CHANGELOG.md",
    "chef/cookbooks/rbenv/README.md",
    "chef/cookbooks/rbenv/Rakefile",
    "chef/cookbooks/rbenv/attributes/default.rb",
    "chef/cookbooks/rbenv/libraries/chef_provider_package_rbenvrubygems.rb",
    "chef/cookbooks/rbenv/libraries/chef_rbenv_mixin.rb",
    "chef/cookbooks/rbenv/libraries/chef_rbenv_recipe_helpers.rb",
    "chef/cookbooks/rbenv/libraries/chef_rbenv_script_helpers.rb",
    "chef/cookbooks/rbenv/metadata.json",
    "chef/cookbooks/rbenv/metadata.rb",
    "chef/cookbooks/rbenv/providers/global.rb",
    "chef/cookbooks/rbenv/providers/rehash.rb",
    "chef/cookbooks/rbenv/providers/ruby.rb",
    "chef/cookbooks/rbenv/providers/script.rb",
    "chef/cookbooks/rbenv/recipes/default.rb",
    "chef/cookbooks/rbenv/recipes/system.rb",
    "chef/cookbooks/rbenv/recipes/system_install.rb",
    "chef/cookbooks/rbenv/recipes/user.rb",
    "chef/cookbooks/rbenv/recipes/user_install.rb",
    "chef/cookbooks/rbenv/recipes/vagrant.rb",
    "chef/cookbooks/rbenv/resources/gem.rb",
    "chef/cookbooks/rbenv/resources/global.rb",
    "chef/cookbooks/rbenv/resources/rehash.rb",
    "chef/cookbooks/rbenv/resources/ruby.rb",
    "chef/cookbooks/rbenv/resources/script.rb",
    "chef/cookbooks/rbenv/templates/default/rbenv.sh.erb",
    "chef/cookbooks/rbenv/test/support/Gemfile",
    "chef/cookbooks/ruby_build/.gitignore",
    "chef/cookbooks/ruby_build/.travis.yml",
    "chef/cookbooks/ruby_build/CHANGELOG.md",
    "chef/cookbooks/ruby_build/README.md",
    "chef/cookbooks/ruby_build/Rakefile",
    "chef/cookbooks/ruby_build/attributes/default.rb",
    "chef/cookbooks/ruby_build/libraries/ruby_build_recipe_helpers.rb",
    "chef/cookbooks/ruby_build/metadata.json",
    "chef/cookbooks/ruby_build/metadata.rb",
    "chef/cookbooks/ruby_build/providers/ruby.rb",
    "chef/cookbooks/ruby_build/recipes/default.rb",
    "chef/cookbooks/ruby_build/resources/ruby.rb",
    "chef/cookbooks/runit/CHANGELOG.md",
    "chef/cookbooks/runit/CONTRIBUTING",
    "chef/cookbooks/runit/LICENSE",
    "chef/cookbooks/runit/README.md",
    "chef/cookbooks/runit/attributes/default.rb",
    "chef/cookbooks/runit/definitions/runit_service.rb",
    "chef/cookbooks/runit/files/default/runit.seed",
    "chef/cookbooks/runit/files/default/runsvdir",
    "chef/cookbooks/runit/files/ubuntu-6.10/runsvdir",
    "chef/cookbooks/runit/files/ubuntu-7.04/runsvdir",
    "chef/cookbooks/runit/files/ubuntu-7.10/runsvdir",
    "chef/cookbooks/runit/files/ubuntu-8.04/runsvdir",
    "chef/cookbooks/runit/metadata.json",
    "chef/cookbooks/runit/metadata.rb",
    "chef/cookbooks/runit/recipes/default.rb",
    "chef/cookbooks/runit/templates/gentoo/runit-start.sh.erb",
    "chef/cookbooks/statsd/.gitignore",
    "chef/cookbooks/statsd/README.md",
    "chef/cookbooks/statsd/attributes/default.rb",
    "chef/cookbooks/statsd/files/default/upstart.conf",
    "chef/cookbooks/statsd/metadata.rb",
    "chef/cookbooks/statsd/recipes/default.rb",
    "chef/cookbooks/statsd/templates/default/config.js.erb",
    "chef/cookbooks/statsd/templates/default/upstart.start.erb",
    "chef/cookbooks/sudo/README.md",
    "chef/cookbooks/sudo/attributes/default.rb",
    "chef/cookbooks/sudo/files/default/README.sudoers",
    "chef/cookbooks/sudo/metadata.json",
    "chef/cookbooks/sudo/metadata.rb",
    "chef/cookbooks/sudo/providers/default.rb",
    "chef/cookbooks/sudo/recipes/default.rb",
    "chef/cookbooks/sudo/resources/default.rb",
    "chef/cookbooks/sudo/templates/default/sudoers.erb",
    "chef/cookbooks/zaproxy/attributes/default.rb",
    "chef/cookbooks/zaproxy/metadata.json",
    "chef/cookbooks/zaproxy/metadata.rb",
    "chef/cookbooks/zaproxy/recipes/default.rb",
    "chef/cookbooks/zaproxy/templates/default/config.xml.erb",
    "chef/cookbooks/zaproxy/templates/default/zaproxy.erb",
    "chef/data_bags/README",
    "chef/nodes/README",
    "chef/nodes/ec2-54-217-29-239.eu-west-1.compute.amazonaws.com.json",
    "chef/roles/README.md",
    "chef/roles/comicrelief.json",
    "chef/roles/load_test_agent.json",
    "chef/roles/load_test_console.json",
    "chef/site-cookbooks/README",
    "gloader.gemspec",
    "grinder/GrinderAnalyzer/analyzer.py",
    "grinder/GrinderAnalyzer/classpathtool.py",
    "grinder/GrinderAnalyzer/conf/analyzer.properties",
    "grinder/GrinderAnalyzer/extra/README.txt",
    "grinder/GrinderAnalyzer/extra/glf/.project",
    "grinder/GrinderAnalyzer/extra/glf/.pydevproject",
    "grinder/GrinderAnalyzer/extra/glf/README.txt",
    "grinder/GrinderAnalyzer/extra/glf/release.sh",
    "grinder/GrinderAnalyzer/extra/glf/src/feeder/__init__.py",
    "grinder/GrinderAnalyzer/extra/glf/src/feeder/aggregator.py",
    "grinder/GrinderAnalyzer/extra/glf/src/feeder/fileutils.py",
    "grinder/GrinderAnalyzer/extra/glf/src/feeder/line.py",
    "grinder/GrinderAnalyzer/extra/glf/src/foo.py",
    "grinder/GrinderAnalyzer/extra/glf/src/graphite_log_feeder.py",
    "grinder/GrinderAnalyzer/extra/glf/src/settings.py",
    "grinder/GrinderAnalyzer/extra/logster/GrinderLogster.py",
    "grinder/GrinderAnalyzer/ga/__init__.py",
    "grinder/GrinderAnalyzer/ga/bucket.py",
    "grinder/GrinderAnalyzer/ga/constants.py",
    "grinder/GrinderAnalyzer/ga/fileutils.py",
    "grinder/GrinderAnalyzer/ga/graph.py",
    "grinder/GrinderAnalyzer/ga/report.py",
    "grinder/GrinderAnalyzer/ga/summary.py",
    "grinder/GrinderAnalyzer/lib/GrinderAnalyzer.V2.b19.jar",
    "grinder/GrinderAnalyzer/lib/commons-collections-3.2.jar",
    "grinder/GrinderAnalyzer/lib/commons-lang-2.3.jar",
    "grinder/GrinderAnalyzer/lib/htmllexer.jar",
    "grinder/GrinderAnalyzer/lib/htmlparser.jar",
    "grinder/GrinderAnalyzer/lib/jcommon-1.0.12.jar",
    "grinder/GrinderAnalyzer/lib/jfreechart-1.0.9.jar",
    "grinder/GrinderAnalyzer/lib/log4j.jar",
    "grinder/GrinderAnalyzer/lib/velocity-1.5.jar",
    "grinder/GrinderAnalyzer/templates/agent.vm",
    "grinder/GrinderAnalyzer/templates/analyzer.css",
    "grinder/GrinderAnalyzer/templates/csshover3.htc",
    "grinder/GrinderAnalyzer/templates/sorttable.js",
    "grinder/GrinderAnalyzer/templates/wz_tooltip.js",
    "lib/gloader.rb",
    "lib/gloader/cli.rb",
    "lib/gloader/core.rb",
    "lib/gloader/version.rb",
    "spec/unit/fixtures/.gitignore",
    "spec/unit/gloader/cli_spec.rb",
    "spec/unit/gloader/core_spec.rb",
    "spec/unit/spec_helper.rb"
  ]
  s.homepage = "http://github.com/bendodd/gloader"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.23"
  s.summary = "Grinder Load Tester"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<fog>, [">= 0"])
      s.add_runtime_dependency(%q<httparty>, [">= 0"])
      s.add_runtime_dependency(%q<yajl-ruby>, [">= 0"])
      s.add_runtime_dependency(%q<net-ssh>, [">= 0"])
      s.add_runtime_dependency(%q<thor>, [">= 0"])
      s.add_runtime_dependency(%q<log4r>, [">= 0"])
      s.add_development_dependency(%q<coveralls>, [">= 0"])
      s.add_development_dependency(%q<simplecov>, [">= 0"])
      s.add_development_dependency(%q<pry>, ["~> 0.9.12.2"])
      s.add_development_dependency(%q<minitest>, ["~> 5.0.3"])
      s.add_development_dependency(%q<guard>, [">= 0"])
      s.add_development_dependency(%q<guard-rake>, [">= 0"])
      s.add_development_dependency(%q<guard-rubocop>, [">= 0"])
      s.add_development_dependency(%q<growl>, ["~> 1.0.3"])
      s.add_development_dependency(%q<rb-inotify>, ["~> 0.9"])
      s.add_development_dependency(%q<rb-fsevent>, ["~> 0.9"])
      s.add_development_dependency(%q<webmock>, ["~> 1.13.0"])
      s.add_development_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.8.7"])
      s.add_development_dependency(%q<rubocop>, [">= 0"])
      s.add_development_dependency(%q<guard-rubocop>, [">= 0"])
    else
      s.add_dependency(%q<fog>, [">= 0"])
      s.add_dependency(%q<httparty>, [">= 0"])
      s.add_dependency(%q<yajl-ruby>, [">= 0"])
      s.add_dependency(%q<net-ssh>, [">= 0"])
      s.add_dependency(%q<thor>, [">= 0"])
      s.add_dependency(%q<log4r>, [">= 0"])
      s.add_dependency(%q<coveralls>, [">= 0"])
      s.add_dependency(%q<simplecov>, [">= 0"])
      s.add_dependency(%q<pry>, ["~> 0.9.12.2"])
      s.add_dependency(%q<minitest>, ["~> 5.0.3"])
      s.add_dependency(%q<guard>, [">= 0"])
      s.add_dependency(%q<guard-rake>, [">= 0"])
      s.add_dependency(%q<guard-rubocop>, [">= 0"])
      s.add_dependency(%q<growl>, ["~> 1.0.3"])
      s.add_dependency(%q<rb-inotify>, ["~> 0.9"])
      s.add_dependency(%q<rb-fsevent>, ["~> 0.9"])
      s.add_dependency(%q<webmock>, ["~> 1.13.0"])
      s.add_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_dependency(%q<bundler>, ["~> 1.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.8.7"])
      s.add_dependency(%q<rubocop>, [">= 0"])
      s.add_dependency(%q<guard-rubocop>, [">= 0"])
    end
  else
    s.add_dependency(%q<fog>, [">= 0"])
    s.add_dependency(%q<httparty>, [">= 0"])
    s.add_dependency(%q<yajl-ruby>, [">= 0"])
    s.add_dependency(%q<net-ssh>, [">= 0"])
    s.add_dependency(%q<thor>, [">= 0"])
    s.add_dependency(%q<log4r>, [">= 0"])
    s.add_dependency(%q<coveralls>, [">= 0"])
    s.add_dependency(%q<simplecov>, [">= 0"])
    s.add_dependency(%q<pry>, ["~> 0.9.12.2"])
    s.add_dependency(%q<minitest>, ["~> 5.0.3"])
    s.add_dependency(%q<guard>, [">= 0"])
    s.add_dependency(%q<guard-rake>, [">= 0"])
    s.add_dependency(%q<guard-rubocop>, [">= 0"])
    s.add_dependency(%q<growl>, ["~> 1.0.3"])
    s.add_dependency(%q<rb-inotify>, ["~> 0.9"])
    s.add_dependency(%q<rb-fsevent>, ["~> 0.9"])
    s.add_dependency(%q<webmock>, ["~> 1.13.0"])
    s.add_dependency(%q<rdoc>, ["~> 3.12"])
    s.add_dependency(%q<bundler>, ["~> 1.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.8.7"])
    s.add_dependency(%q<rubocop>, [">= 0"])
    s.add_dependency(%q<guard-rubocop>, [">= 0"])
  end
end

