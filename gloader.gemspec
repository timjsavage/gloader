# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "gloader"
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Benedict Dodd"]
  s.date = "2013-10-16"
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
    "gloader.gemspec",
    "lib/gloader.rb",
    "lib/gloader/chef.rb",
    "lib/gloader/cli.rb",
    "lib/gloader/config.rb",
    "lib/gloader/console.rb",
    "lib/gloader/core.rb",
    "lib/gloader/iaas.rb",
    "lib/gloader/iaas/aws.rb",
    "lib/gloader/iaas/rackspace.rb",
    "lib/gloader/logger.rb",
    "lib/gloader/platform.rb",
    "lib/gloader/test_run.rb",
    "lib/gloader/version.rb",
    "spec/integration/gloader/build_spec.rb",
    "spec/integration/gloader/cli_spec.rb",
    "spec/integration/gloader/test_run_spec.rb",
    "spec/integration/spec_helper.rb",
    "spec/unit/fixtures/.gitignore",
    "spec/unit/fixtures/config_gloader_default.yml",
    "spec/unit/fixtures/config_gloader_state.yml",
    "spec/unit/gloader/chef_spec.rb",
    "spec/unit/gloader/cli_spec.rb",
    "spec/unit/gloader/config_spec.rb",
    "spec/unit/gloader/console_spec.rb",
    "spec/unit/gloader/core_spec.rb",
    "spec/unit/gloader/iaas/aws_spec.rb",
    "spec/unit/gloader/iaas/rackspace_spec.rb",
    "spec/unit/gloader/iaas_spec.rb",
    "spec/unit/gloader/logger_spec.rb",
    "spec/unit/gloader/platform_spec.rb",
    "spec/unit/gloader/test_run_spec.rb",
    "spec/unit/spec_helper.rb",
    "tools/GrinderAnalyzer/analyzer.py",
    "tools/GrinderAnalyzer/classpathtool.py",
    "tools/GrinderAnalyzer/conf/analyzer.properties",
    "tools/GrinderAnalyzer/extra/README.txt",
    "tools/GrinderAnalyzer/extra/glf/.project",
    "tools/GrinderAnalyzer/extra/glf/.pydevproject",
    "tools/GrinderAnalyzer/extra/glf/README.txt",
    "tools/GrinderAnalyzer/extra/glf/release.sh",
    "tools/GrinderAnalyzer/extra/glf/src/feeder/__init__.py",
    "tools/GrinderAnalyzer/extra/glf/src/feeder/aggregator.py",
    "tools/GrinderAnalyzer/extra/glf/src/feeder/fileutils.py",
    "tools/GrinderAnalyzer/extra/glf/src/feeder/line.py",
    "tools/GrinderAnalyzer/extra/glf/src/foo.py",
    "tools/GrinderAnalyzer/extra/glf/src/graphite_log_feeder.py",
    "tools/GrinderAnalyzer/extra/glf/src/settings.py",
    "tools/GrinderAnalyzer/extra/logster/GrinderLogster.py",
    "tools/GrinderAnalyzer/ga/__init__.py",
    "tools/GrinderAnalyzer/ga/bucket.py",
    "tools/GrinderAnalyzer/ga/constants.py",
    "tools/GrinderAnalyzer/ga/fileutils.py",
    "tools/GrinderAnalyzer/ga/graph.py",
    "tools/GrinderAnalyzer/ga/report.py",
    "tools/GrinderAnalyzer/ga/summary.py",
    "tools/GrinderAnalyzer/lib/GrinderAnalyzer.V2.b19.jar",
    "tools/GrinderAnalyzer/lib/commons-collections-3.2.jar",
    "tools/GrinderAnalyzer/lib/commons-lang-2.3.jar",
    "tools/GrinderAnalyzer/lib/htmllexer.jar",
    "tools/GrinderAnalyzer/lib/htmlparser.jar",
    "tools/GrinderAnalyzer/lib/jcommon-1.0.12.jar",
    "tools/GrinderAnalyzer/lib/jfreechart-1.0.9.jar",
    "tools/GrinderAnalyzer/lib/log4j.jar",
    "tools/GrinderAnalyzer/lib/velocity-1.5.jar",
    "tools/GrinderAnalyzer/templates/agent.vm",
    "tools/GrinderAnalyzer/templates/analyzer.css",
    "tools/GrinderAnalyzer/templates/csshover3.htc",
    "tools/GrinderAnalyzer/templates/sorttable.js",
    "tools/GrinderAnalyzer/templates/wz_tooltip.js",
    "tools/chef/cookbooks/apache2/CHANGELOG.md",
    "tools/chef/cookbooks/apache2/CONTRIBUTING",
    "tools/chef/cookbooks/apache2/LICENSE",
    "tools/chef/cookbooks/apache2/README.md",
    "tools/chef/cookbooks/apache2/attributes/default.rb",
    "tools/chef/cookbooks/apache2/attributes/mod_auth_openid.rb",
    "tools/chef/cookbooks/apache2/definitions/apache_conf.rb",
    "tools/chef/cookbooks/apache2/definitions/apache_module.rb",
    "tools/chef/cookbooks/apache2/definitions/apache_site.rb",
    "tools/chef/cookbooks/apache2/definitions/web_app.rb",
    "tools/chef/cookbooks/apache2/files/default/apache2_module_conf_generate.pl",
    "tools/chef/cookbooks/apache2/metadata.json",
    "tools/chef/cookbooks/apache2/metadata.rb",
    "tools/chef/cookbooks/apache2/recipes/default.rb",
    "tools/chef/cookbooks/apache2/recipes/god_monitor.rb",
    "tools/chef/cookbooks/apache2/recipes/mod_alias.rb",
    "tools/chef/cookbooks/apache2/recipes/mod_apreq2.rb",
    "tools/chef/cookbooks/apache2/recipes/mod_auth_basic.rb",
    "tools/chef/cookbooks/apache2/recipes/mod_auth_digest.rb",
    "tools/chef/cookbooks/apache2/recipes/mod_auth_openid.rb",
    "tools/chef/cookbooks/apache2/recipes/mod_authn_file.rb",
    "tools/chef/cookbooks/apache2/recipes/mod_authnz_ldap.rb",
    "tools/chef/cookbooks/apache2/recipes/mod_authz_default.rb",
    "tools/chef/cookbooks/apache2/recipes/mod_authz_groupfile.rb",
    "tools/chef/cookbooks/apache2/recipes/mod_authz_host.rb",
    "tools/chef/cookbooks/apache2/recipes/mod_authz_user.rb",
    "tools/chef/cookbooks/apache2/recipes/mod_autoindex.rb",
    "tools/chef/cookbooks/apache2/recipes/mod_cgi.rb",
    "tools/chef/cookbooks/apache2/recipes/mod_dav.rb",
    "tools/chef/cookbooks/apache2/recipes/mod_dav_fs.rb",
    "tools/chef/cookbooks/apache2/recipes/mod_dav_svn.rb",
    "tools/chef/cookbooks/apache2/recipes/mod_deflate.rb",
    "tools/chef/cookbooks/apache2/recipes/mod_dir.rb",
    "tools/chef/cookbooks/apache2/recipes/mod_env.rb",
    "tools/chef/cookbooks/apache2/recipes/mod_expires.rb",
    "tools/chef/cookbooks/apache2/recipes/mod_fcgid.rb",
    "tools/chef/cookbooks/apache2/recipes/mod_headers.rb",
    "tools/chef/cookbooks/apache2/recipes/mod_ldap.rb",
    "tools/chef/cookbooks/apache2/recipes/mod_log_config.rb",
    "tools/chef/cookbooks/apache2/recipes/mod_logio.rb",
    "tools/chef/cookbooks/apache2/recipes/mod_mime.rb",
    "tools/chef/cookbooks/apache2/recipes/mod_negotiation.rb",
    "tools/chef/cookbooks/apache2/recipes/mod_perl.rb",
    "tools/chef/cookbooks/apache2/recipes/mod_php5.rb",
    "tools/chef/cookbooks/apache2/recipes/mod_proxy.rb",
    "tools/chef/cookbooks/apache2/recipes/mod_proxy_ajp.rb",
    "tools/chef/cookbooks/apache2/recipes/mod_proxy_balancer.rb",
    "tools/chef/cookbooks/apache2/recipes/mod_proxy_connect.rb",
    "tools/chef/cookbooks/apache2/recipes/mod_proxy_http.rb",
    "tools/chef/cookbooks/apache2/recipes/mod_python.rb",
    "tools/chef/cookbooks/apache2/recipes/mod_rewrite.rb",
    "tools/chef/cookbooks/apache2/recipes/mod_setenvif.rb",
    "tools/chef/cookbooks/apache2/recipes/mod_ssl.rb",
    "tools/chef/cookbooks/apache2/recipes/mod_status.rb",
    "tools/chef/cookbooks/apache2/recipes/mod_wsgi.rb",
    "tools/chef/cookbooks/apache2/recipes/mod_xsendfile.rb",
    "tools/chef/cookbooks/apache2/templates/default/a2dismod.erb",
    "tools/chef/cookbooks/apache2/templates/default/a2dissite.erb",
    "tools/chef/cookbooks/apache2/templates/default/a2enmod.erb",
    "tools/chef/cookbooks/apache2/templates/default/a2ensite.erb",
    "tools/chef/cookbooks/apache2/templates/default/apache2.conf.erb",
    "tools/chef/cookbooks/apache2/templates/default/apache2.god.erb",
    "tools/chef/cookbooks/apache2/templates/default/charset.erb",
    "tools/chef/cookbooks/apache2/templates/default/default-site.erb",
    "tools/chef/cookbooks/apache2/templates/default/mods/README",
    "tools/chef/cookbooks/apache2/templates/default/mods/alias.conf.erb",
    "tools/chef/cookbooks/apache2/templates/default/mods/authopenid.load.erb",
    "tools/chef/cookbooks/apache2/templates/default/mods/autoindex.conf.erb",
    "tools/chef/cookbooks/apache2/templates/default/mods/deflate.conf.erb",
    "tools/chef/cookbooks/apache2/templates/default/mods/dir.conf.erb",
    "tools/chef/cookbooks/apache2/templates/default/mods/fcgid.conf.erb",
    "tools/chef/cookbooks/apache2/templates/default/mods/mime.conf.erb",
    "tools/chef/cookbooks/apache2/templates/default/mods/negotiation.conf.erb",
    "tools/chef/cookbooks/apache2/templates/default/mods/php5.conf.erb",
    "tools/chef/cookbooks/apache2/templates/default/mods/proxy.conf.erb",
    "tools/chef/cookbooks/apache2/templates/default/mods/setenvif.conf.erb",
    "tools/chef/cookbooks/apache2/templates/default/mods/ssl.conf.erb",
    "tools/chef/cookbooks/apache2/templates/default/mods/status.conf.erb",
    "tools/chef/cookbooks/apache2/templates/default/port_apache.erb",
    "tools/chef/cookbooks/apache2/templates/default/ports.conf.erb",
    "tools/chef/cookbooks/apache2/templates/default/security.erb",
    "tools/chef/cookbooks/apache2/templates/default/web_app.conf.erb",
    "tools/chef/cookbooks/apt/CHANGELOG.md",
    "tools/chef/cookbooks/apt/CONTRIBUTING",
    "tools/chef/cookbooks/apt/LICENSE",
    "tools/chef/cookbooks/apt/README.md",
    "tools/chef/cookbooks/apt/files/default/apt-proxy-v2.conf",
    "tools/chef/cookbooks/apt/metadata.json",
    "tools/chef/cookbooks/apt/metadata.rb",
    "tools/chef/cookbooks/apt/providers/preference.rb",
    "tools/chef/cookbooks/apt/providers/repository.rb",
    "tools/chef/cookbooks/apt/recipes/cacher-client.rb",
    "tools/chef/cookbooks/apt/recipes/cacher-ng.rb",
    "tools/chef/cookbooks/apt/recipes/default.rb",
    "tools/chef/cookbooks/apt/resources/preference.rb",
    "tools/chef/cookbooks/apt/resources/repository.rb",
    "tools/chef/cookbooks/ark/.gitignore",
    "tools/chef/cookbooks/ark/.travis.yml",
    "tools/chef/cookbooks/ark/CHANGELOG.md",
    "tools/chef/cookbooks/ark/README.md",
    "tools/chef/cookbooks/ark/Rakefile",
    "tools/chef/cookbooks/ark/Toftfile",
    "tools/chef/cookbooks/ark/Vagrantfile",
    "tools/chef/cookbooks/ark/attributes/default.rb",
    "tools/chef/cookbooks/ark/files/default/foo.tar.gz",
    "tools/chef/cookbooks/ark/files/default/foo.tbz",
    "tools/chef/cookbooks/ark/files/default/foo.tgz",
    "tools/chef/cookbooks/ark/files/default/foo.zip",
    "tools/chef/cookbooks/ark/files/default/tests/minitest/test_test.rb",
    "tools/chef/cookbooks/ark/libraries/provider_ark.rb",
    "tools/chef/cookbooks/ark/libraries/resource_ark.rb",
    "tools/chef/cookbooks/ark/metadata.json",
    "tools/chef/cookbooks/ark/metadata.rb",
    "tools/chef/cookbooks/ark/recipes/default.rb",
    "tools/chef/cookbooks/ark/recipes/test.rb",
    "tools/chef/cookbooks/bosh/attributes/default.rb",
    "tools/chef/cookbooks/bosh/files/default/ca-bundle.crt",
    "tools/chef/cookbooks/bosh/metadata.json",
    "tools/chef/cookbooks/bosh/metadata.rb",
    "tools/chef/cookbooks/bosh/recipes/default.rb",
    "tools/chef/cookbooks/build-essential/CHANGELOG.md",
    "tools/chef/cookbooks/build-essential/CONTRIBUTING",
    "tools/chef/cookbooks/build-essential/LICENSE",
    "tools/chef/cookbooks/build-essential/README.md",
    "tools/chef/cookbooks/build-essential/attributes/default.rb",
    "tools/chef/cookbooks/build-essential/metadata.json",
    "tools/chef/cookbooks/build-essential/metadata.rb",
    "tools/chef/cookbooks/build-essential/recipes/default.rb",
    "tools/chef/cookbooks/bundler/attributes/bundler.rb",
    "tools/chef/cookbooks/bundler/metadata.json",
    "tools/chef/cookbooks/bundler/readme.md",
    "tools/chef/cookbooks/bundler/recipes/default.rb",
    "tools/chef/cookbooks/bundler/recipes/install.rb",
    "tools/chef/cookbooks/bundler/recipes/lock.rb",
    "tools/chef/cookbooks/bundler/recipes/pack.rb",
    "tools/chef/cookbooks/bundler/recipes/unlock.rb",
    "tools/chef/cookbooks/collectd_proxy/attributes/default.rb",
    "tools/chef/cookbooks/collectd_proxy/files/default/collect_proxy_binary",
    "tools/chef/cookbooks/collectd_proxy/files/default/collectd_proxy_plugin_network.so",
    "tools/chef/cookbooks/collectd_proxy/files/default/collectd_proxy_plugin_write_graphite.so",
    "tools/chef/cookbooks/collectd_proxy/metadata.json",
    "tools/chef/cookbooks/collectd_proxy/metadata.rb",
    "tools/chef/cookbooks/collectd_proxy/recipes/default.rb",
    "tools/chef/cookbooks/collectd_proxy/templates/default/config.erb",
    "tools/chef/cookbooks/collectd_proxy/templates/default/init-script.erb",
    "tools/chef/cookbooks/elasticsearch/.gitignore",
    "tools/chef/cookbooks/elasticsearch/Berksfile",
    "tools/chef/cookbooks/elasticsearch/Gemfile",
    "tools/chef/cookbooks/elasticsearch/README.markdown",
    "tools/chef/cookbooks/elasticsearch/Vagrantfile",
    "tools/chef/cookbooks/elasticsearch/attributes/default.rb",
    "tools/chef/cookbooks/elasticsearch/attributes/plugin_aws.rb",
    "tools/chef/cookbooks/elasticsearch/attributes/proxy_nginx.rb",
    "tools/chef/cookbooks/elasticsearch/chefignore",
    "tools/chef/cookbooks/elasticsearch/definitions/install_plugin.rb",
    "tools/chef/cookbooks/elasticsearch/files/default/tests/minitest/cluster_test.rb",
    "tools/chef/cookbooks/elasticsearch/files/default/tests/minitest/installation_test.rb",
    "tools/chef/cookbooks/elasticsearch/files/default/tests/minitest/plugin_aws_test.rb",
    "tools/chef/cookbooks/elasticsearch/files/default/tests/minitest/proxy_nginx_test.rb",
    "tools/chef/cookbooks/elasticsearch/files/default/tests/minitest/service_test.rb",
    "tools/chef/cookbooks/elasticsearch/metadata.json",
    "tools/chef/cookbooks/elasticsearch/metadata.rb",
    "tools/chef/cookbooks/elasticsearch/recipes/curl.rb",
    "tools/chef/cookbooks/elasticsearch/recipes/default.rb",
    "tools/chef/cookbooks/elasticsearch/recipes/plugin_aws.rb",
    "tools/chef/cookbooks/elasticsearch/recipes/proxy_nginx.rb",
    "tools/chef/cookbooks/elasticsearch/templates/default/elasticsearch-env.sh.erb",
    "tools/chef/cookbooks/elasticsearch/templates/default/elasticsearch.conf.erb",
    "tools/chef/cookbooks/elasticsearch/templates/default/elasticsearch.init.erb",
    "tools/chef/cookbooks/elasticsearch/templates/default/elasticsearch.yml.erb",
    "tools/chef/cookbooks/elasticsearch/templates/default/elasticsearch_proxy_nginx.conf.erb",
    "tools/chef/cookbooks/git/CHANGELOG.md",
    "tools/chef/cookbooks/git/CONTRIBUTING",
    "tools/chef/cookbooks/git/LICENSE",
    "tools/chef/cookbooks/git/README.md",
    "tools/chef/cookbooks/git/attributes/default.rb",
    "tools/chef/cookbooks/git/metadata.json",
    "tools/chef/cookbooks/git/metadata.rb",
    "tools/chef/cookbooks/git/recipes/default.rb",
    "tools/chef/cookbooks/git/recipes/server.rb",
    "tools/chef/cookbooks/git/templates/default/sv-git-daemon-log-run.erb",
    "tools/chef/cookbooks/git/templates/default/sv-git-daemon-run.erb",
    "tools/chef/cookbooks/graphite/README.md",
    "tools/chef/cookbooks/graphite/attributes/graphite.rb",
    "tools/chef/cookbooks/graphite/files/default/graphite.db",
    "tools/chef/cookbooks/graphite/files/default/set_admin_passwd.py",
    "tools/chef/cookbooks/graphite/metadata.json",
    "tools/chef/cookbooks/graphite/metadata.rb",
    "tools/chef/cookbooks/graphite/recipes/carbon.rb",
    "tools/chef/cookbooks/graphite/recipes/default.rb",
    "tools/chef/cookbooks/graphite/recipes/web.rb",
    "tools/chef/cookbooks/graphite/recipes/whisper.rb",
    "tools/chef/cookbooks/graphite/templates/default/carbon.conf.erb",
    "tools/chef/cookbooks/graphite/templates/default/graphite-vhost.conf.erb",
    "tools/chef/cookbooks/graphite/templates/default/htpasswd.erb",
    "tools/chef/cookbooks/graphite/templates/default/storage-schemas.conf.erb",
    "tools/chef/cookbooks/graphite/templates/default/sv-carbon-cache-finish.erb",
    "tools/chef/cookbooks/graphite/templates/default/sv-carbon-cache-log-run.erb",
    "tools/chef/cookbooks/graphite/templates/default/sv-carbon-cache-run.erb",
    "tools/chef/cookbooks/grinder/README.md",
    "tools/chef/cookbooks/grinder/attributes/default.rb",
    "tools/chef/cookbooks/grinder/metadata.json",
    "tools/chef/cookbooks/grinder/metadata.rb",
    "tools/chef/cookbooks/grinder/recipes/default.rb",
    "tools/chef/cookbooks/haproxy/CHANGELOG.md",
    "tools/chef/cookbooks/haproxy/CONTRIBUTING",
    "tools/chef/cookbooks/haproxy/LICENSE",
    "tools/chef/cookbooks/haproxy/README.md",
    "tools/chef/cookbooks/haproxy/attributes/default.rb",
    "tools/chef/cookbooks/haproxy/metadata.json",
    "tools/chef/cookbooks/haproxy/metadata.rb",
    "tools/chef/cookbooks/haproxy/recipes/app_lb.rb",
    "tools/chef/cookbooks/haproxy/recipes/default.rb",
    "tools/chef/cookbooks/haproxy/templates/default/haproxy-app_lb.cfg.erb",
    "tools/chef/cookbooks/haproxy/templates/default/haproxy-default.erb",
    "tools/chef/cookbooks/haproxy/templates/default/haproxy.cfg.erb",
    "tools/chef/cookbooks/java/CHANGELOG.md",
    "tools/chef/cookbooks/java/CONTRIBUTING",
    "tools/chef/cookbooks/java/LICENSE",
    "tools/chef/cookbooks/java/README.md",
    "tools/chef/cookbooks/java/attributes/default.rb",
    "tools/chef/cookbooks/java/metadata.json",
    "tools/chef/cookbooks/java/metadata.rb",
    "tools/chef/cookbooks/java/providers/ark.rb",
    "tools/chef/cookbooks/java/recipes/default.rb",
    "tools/chef/cookbooks/java/recipes/openjdk.rb",
    "tools/chef/cookbooks/java/recipes/oracle.rb",
    "tools/chef/cookbooks/java/recipes/oracle_i386.rb",
    "tools/chef/cookbooks/java/resources/ark.rb",
    "tools/chef/cookbooks/jenkins/.gitignore",
    "tools/chef/cookbooks/jenkins/README.md",
    "tools/chef/cookbooks/jenkins/attributes/default.rb",
    "tools/chef/cookbooks/jenkins/files/default/node_info.groovy",
    "tools/chef/cookbooks/jenkins/files/ubuntu/jenkins.list",
    "tools/chef/cookbooks/jenkins/libraries/manage_node.rb",
    "tools/chef/cookbooks/jenkins/metadata.rb",
    "tools/chef/cookbooks/jenkins/providers/cli.rb",
    "tools/chef/cookbooks/jenkins/providers/execute.rb",
    "tools/chef/cookbooks/jenkins/providers/job.rb",
    "tools/chef/cookbooks/jenkins/providers/node.rb",
    "tools/chef/cookbooks/jenkins/recipes/default.rb",
    "tools/chef/cookbooks/jenkins/recipes/git.rb",
    "tools/chef/cookbooks/jenkins/recipes/headless.rb",
    "tools/chef/cookbooks/jenkins/recipes/iptables.rb",
    "tools/chef/cookbooks/jenkins/recipes/node_jnlp.rb",
    "tools/chef/cookbooks/jenkins/recipes/node_ssh.rb",
    "tools/chef/cookbooks/jenkins/recipes/node_windows.rb",
    "tools/chef/cookbooks/jenkins/recipes/postgres.rb",
    "tools/chef/cookbooks/jenkins/recipes/proxy_apache2.rb",
    "tools/chef/cookbooks/jenkins/recipes/proxy_nginx.rb",
    "tools/chef/cookbooks/jenkins/resources/cli.rb",
    "tools/chef/cookbooks/jenkins/resources/execute.rb",
    "tools/chef/cookbooks/jenkins/resources/job.rb",
    "tools/chef/cookbooks/jenkins/resources/node.rb",
    "tools/chef/cookbooks/jenkins/templates/default/apache_jenkins.erb",
    "tools/chef/cookbooks/jenkins/templates/default/config.ssh.erb",
    "tools/chef/cookbooks/jenkins/templates/default/htpasswd.erb",
    "tools/chef/cookbooks/jenkins/templates/default/jenkins.erb",
    "tools/chef/cookbooks/jenkins/templates/default/jenkins.id_rsa.erb",
    "tools/chef/cookbooks/jenkins/templates/default/jenkins.id_rsa.pub.erb",
    "tools/chef/cookbooks/jenkins/templates/default/nginx_jenkins.conf.erb",
    "tools/chef/cookbooks/jenkins/templates/default/port_jenkins.erb",
    "tools/chef/cookbooks/jenkins/templates/default/sv-hudson-slave-log-run.erb",
    "tools/chef/cookbooks/jenkins/templates/default/sv-hudson-slave-run.erb",
    "tools/chef/cookbooks/jenkins_backup/attributes/default.rb",
    "tools/chef/cookbooks/jenkins_backup/metadata.json",
    "tools/chef/cookbooks/jenkins_backup/metadata.rb",
    "tools/chef/cookbooks/jenkins_backup/recipes/default.rb",
    "tools/chef/cookbooks/jenkins_backup/templates/default/backup-jenkins.sh.erb",
    "tools/chef/cookbooks/jenkins_backup/templates/default/s3curl.erb",
    "tools/chef/cookbooks/logrotate/CHANGELOG.md",
    "tools/chef/cookbooks/logrotate/CONTRIBUTING",
    "tools/chef/cookbooks/logrotate/LICENSE",
    "tools/chef/cookbooks/logrotate/README.md",
    "tools/chef/cookbooks/logrotate/definitions/logrotate_app.rb",
    "tools/chef/cookbooks/logrotate/metadata.json",
    "tools/chef/cookbooks/logrotate/metadata.rb",
    "tools/chef/cookbooks/logrotate/recipes/default.rb",
    "tools/chef/cookbooks/logrotate/templates/default/logrotate.erb",
    "tools/chef/cookbooks/logstash/README.md",
    "tools/chef/cookbooks/logstash/attributes/agent.rb",
    "tools/chef/cookbooks/logstash/attributes/default.rb",
    "tools/chef/cookbooks/logstash/attributes/kibana.rb",
    "tools/chef/cookbooks/logstash/attributes/pyshipper.rb",
    "tools/chef/cookbooks/logstash/attributes/server.rb",
    "tools/chef/cookbooks/logstash/attributes/source.rb",
    "tools/chef/cookbooks/logstash/files/cron.d/logstash",
    "tools/chef/cookbooks/logstash/metadata.json",
    "tools/chef/cookbooks/logstash/metadata.rb",
    "tools/chef/cookbooks/logstash/recipes/agent.rb",
    "tools/chef/cookbooks/logstash/recipes/curl.rb",
    "tools/chef/cookbooks/logstash/recipes/default.rb",
    "tools/chef/cookbooks/logstash/recipes/kibana.rb",
    "tools/chef/cookbooks/logstash/recipes/optimise.rb",
    "tools/chef/cookbooks/logstash/recipes/pyshipper.rb",
    "tools/chef/cookbooks/logstash/recipes/server.rb",
    "tools/chef/cookbooks/logstash/recipes/source.rb",
    "tools/chef/cookbooks/logstash/templates/default/agent.conf.erb",
    "tools/chef/cookbooks/logstash/templates/default/cron.d/logstash.erb",
    "tools/chef/cookbooks/logstash/templates/default/htpasswd.erb",
    "tools/chef/cookbooks/logstash/templates/default/kibana-config.php.erb",
    "tools/chef/cookbooks/logstash/templates/default/kibana.conf.erb",
    "tools/chef/cookbooks/logstash/templates/default/logstash-index-optimise.sh.erb",
    "tools/chef/cookbooks/logstash/templates/default/logstash_indices.json",
    "tools/chef/cookbooks/logstash/templates/default/server.conf.erb",
    "tools/chef/cookbooks/logstash/templates/default/sv-logstash_agent-log-run.erb",
    "tools/chef/cookbooks/logstash/templates/default/sv-logstash_agent-run.erb",
    "tools/chef/cookbooks/logstash/templates/default/sv-logstash_server-log-run.erb",
    "tools/chef/cookbooks/logstash/templates/default/sv-logstash_server-run.erb",
    "tools/chef/cookbooks/monit/LICENSE",
    "tools/chef/cookbooks/monit/README.md",
    "tools/chef/cookbooks/monit/README.rdoc",
    "tools/chef/cookbooks/monit/attributes/default.rb",
    "tools/chef/cookbooks/monit/files/ubuntu/monit.default",
    "tools/chef/cookbooks/monit/libraries/monitrc.rb",
    "tools/chef/cookbooks/monit/metadata.json",
    "tools/chef/cookbooks/monit/metadata.rb",
    "tools/chef/cookbooks/monit/recipes/default.rb",
    "tools/chef/cookbooks/monit/recipes/postfix.rb",
    "tools/chef/cookbooks/monit/recipes/ssh.rb",
    "tools/chef/cookbooks/monit/templates/default/monitrc.erb",
    "tools/chef/cookbooks/monit/templates/default/postfix.conf.erb",
    "tools/chef/cookbooks/monit/templates/default/ssh.conf.erb",
    "tools/chef/cookbooks/nagios/CHANGELOG.md",
    "tools/chef/cookbooks/nagios/CONTRIBUTING",
    "tools/chef/cookbooks/nagios/LICENSE",
    "tools/chef/cookbooks/nagios/README.md",
    "tools/chef/cookbooks/nagios/attributes/client.rb",
    "tools/chef/cookbooks/nagios/attributes/cucumber.rb",
    "tools/chef/cookbooks/nagios/attributes/default.rb",
    "tools/chef/cookbooks/nagios/attributes/server.rb",
    "tools/chef/cookbooks/nagios/definitions/nagios_conf.rb",
    "tools/chef/cookbooks/nagios/files/default/nagios",
    "tools/chef/cookbooks/nagios/files/default/plugins/check-mysql-slave.pl",
    "tools/chef/cookbooks/nagios/files/default/plugins/check_mem.sh",
    "tools/chef/cookbooks/nagios/files/default/plugins/check_mysqlhealth.pl",
    "tools/chef/cookbooks/nagios/files/default/plugins/check_solr.rb",
    "tools/chef/cookbooks/nagios/files/default/plugins/db_queues.rb",
    "tools/chef/cookbooks/nagios/files/default/plugins/file_queues.rb",
    "tools/chef/cookbooks/nagios/files/default/plugins/nagios_helper.rb",
    "tools/chef/cookbooks/nagios/libraries/default.rb",
    "tools/chef/cookbooks/nagios/metadata.json",
    "tools/chef/cookbooks/nagios/metadata.rb",
    "tools/chef/cookbooks/nagios/providers/nrpecheck.rb",
    "tools/chef/cookbooks/nagios/recipes/client.rb",
    "tools/chef/cookbooks/nagios/recipes/client_package.rb",
    "tools/chef/cookbooks/nagios/recipes/client_source.rb",
    "tools/chef/cookbooks/nagios/recipes/cucumber.rb",
    "tools/chef/cookbooks/nagios/recipes/default.rb",
    "tools/chef/cookbooks/nagios/recipes/pagerduty.rb",
    "tools/chef/cookbooks/nagios/recipes/server.rb",
    "tools/chef/cookbooks/nagios/recipes/server_package.rb",
    "tools/chef/cookbooks/nagios/recipes/server_source.rb",
    "tools/chef/cookbooks/nagios/resources/nrpecheck.rb",
    "tools/chef/cookbooks/nagios/templates/default/apache2.conf.erb",
    "tools/chef/cookbooks/nagios/templates/default/cgi.cfg.erb",
    "tools/chef/cookbooks/nagios/templates/default/commands.cfg.erb",
    "tools/chef/cookbooks/nagios/templates/default/contacts.cfg.erb",
    "tools/chef/cookbooks/nagios/templates/default/cucumber-fetch-features.sh.erb",
    "tools/chef/cookbooks/nagios/templates/default/cucumber-systest.sh.erb",
    "tools/chef/cookbooks/nagios/templates/default/hostgroups.cfg.erb",
    "tools/chef/cookbooks/nagios/templates/default/hosts.cfg.erb",
    "tools/chef/cookbooks/nagios/templates/default/htpasswd.users.erb",
    "tools/chef/cookbooks/nagios/templates/default/nagios-nrpe-server.erb",
    "tools/chef/cookbooks/nagios/templates/default/nagios.cfg.erb",
    "tools/chef/cookbooks/nagios/templates/default/nrpe.cfg.erb",
    "tools/chef/cookbooks/nagios/templates/default/pagerduty_nagios.cfg.erb",
    "tools/chef/cookbooks/nagios/templates/default/services.cfg.erb",
    "tools/chef/cookbooks/nagios/templates/default/templates.cfg.erb",
    "tools/chef/cookbooks/nagios/templates/default/timeperiods.cfg.erb",
    "tools/chef/cookbooks/nodejs/README.rdoc",
    "tools/chef/cookbooks/nodejs/attributes/default.rb",
    "tools/chef/cookbooks/nodejs/metadata.json",
    "tools/chef/cookbooks/nodejs/metadata.rb",
    "tools/chef/cookbooks/nodejs/recipes/default.rb",
    "tools/chef/cookbooks/nodejs/recipes/npm.rb",
    "tools/chef/cookbooks/openshift/README.md",
    "tools/chef/cookbooks/openshift/attributes/default.rb",
    "tools/chef/cookbooks/openshift/metadata.json",
    "tools/chef/cookbooks/openshift/metadata.rb",
    "tools/chef/cookbooks/openshift/recipes/broker.rb",
    "tools/chef/cookbooks/openshift/recipes/common.rb",
    "tools/chef/cookbooks/openshift/recipes/node.rb",
    "tools/chef/cookbooks/openshift/recipes/rhc.rb",
    "tools/chef/cookbooks/openshift/recipes/selinux_hack.rb",
    "tools/chef/cookbooks/openshift/specs/broker_spec.rb",
    "tools/chef/cookbooks/openshift/specs/node_spec.rb",
    "tools/chef/cookbooks/php/README.md",
    "tools/chef/cookbooks/php/attributes/default.rb",
    "tools/chef/cookbooks/php/metadata.json",
    "tools/chef/cookbooks/php/metadata.rb",
    "tools/chef/cookbooks/php/providers/pear.rb",
    "tools/chef/cookbooks/php/providers/pear_channel.rb",
    "tools/chef/cookbooks/php/recipes/default.rb",
    "tools/chef/cookbooks/php/recipes/module_apc.rb",
    "tools/chef/cookbooks/php/recipes/module_curl.rb",
    "tools/chef/cookbooks/php/recipes/module_fileinfo.rb",
    "tools/chef/cookbooks/php/recipes/module_fpdf.rb",
    "tools/chef/cookbooks/php/recipes/module_gd.rb",
    "tools/chef/cookbooks/php/recipes/module_ldap.rb",
    "tools/chef/cookbooks/php/recipes/module_memcache.rb",
    "tools/chef/cookbooks/php/recipes/module_mysql.rb",
    "tools/chef/cookbooks/php/recipes/module_pgsql.rb",
    "tools/chef/cookbooks/php/recipes/module_sqlite3.rb",
    "tools/chef/cookbooks/php/recipes/package.rb",
    "tools/chef/cookbooks/php/recipes/source.rb",
    "tools/chef/cookbooks/php/resources/pear.rb",
    "tools/chef/cookbooks/php/resources/pear_channel.rb",
    "tools/chef/cookbooks/php/templates/centos/php.ini.erb",
    "tools/chef/cookbooks/php/templates/debian/php.ini.erb",
    "tools/chef/cookbooks/php/templates/default/extension.ini.erb",
    "tools/chef/cookbooks/php/templates/default/php.ini.erb",
    "tools/chef/cookbooks/php/templates/redhat/php.ini.erb",
    "tools/chef/cookbooks/php/templates/ubuntu/php.ini.erb",
    "tools/chef/cookbooks/python/CHANGELOG.md",
    "tools/chef/cookbooks/python/CONTRIBUTING",
    "tools/chef/cookbooks/python/LICENSE",
    "tools/chef/cookbooks/python/README.md",
    "tools/chef/cookbooks/python/attributes/default.rb",
    "tools/chef/cookbooks/python/metadata.json",
    "tools/chef/cookbooks/python/metadata.rb",
    "tools/chef/cookbooks/python/providers/pip.rb",
    "tools/chef/cookbooks/python/providers/virtualenv.rb",
    "tools/chef/cookbooks/python/recipes/default.rb",
    "tools/chef/cookbooks/python/recipes/package.rb",
    "tools/chef/cookbooks/python/recipes/pip.rb",
    "tools/chef/cookbooks/python/recipes/source.rb",
    "tools/chef/cookbooks/python/recipes/virtualenv.rb",
    "tools/chef/cookbooks/python/resources/pip.rb",
    "tools/chef/cookbooks/python/resources/virtualenv.rb",
    "tools/chef/cookbooks/rbenv/.gitignore",
    "tools/chef/cookbooks/rbenv/.travis.yml",
    "tools/chef/cookbooks/rbenv/CHANGELOG.md",
    "tools/chef/cookbooks/rbenv/README.md",
    "tools/chef/cookbooks/rbenv/Rakefile",
    "tools/chef/cookbooks/rbenv/attributes/default.rb",
    "tools/chef/cookbooks/rbenv/libraries/chef_provider_package_rbenvrubygems.rb",
    "tools/chef/cookbooks/rbenv/libraries/chef_rbenv_mixin.rb",
    "tools/chef/cookbooks/rbenv/libraries/chef_rbenv_recipe_helpers.rb",
    "tools/chef/cookbooks/rbenv/libraries/chef_rbenv_script_helpers.rb",
    "tools/chef/cookbooks/rbenv/metadata.json",
    "tools/chef/cookbooks/rbenv/metadata.rb",
    "tools/chef/cookbooks/rbenv/providers/global.rb",
    "tools/chef/cookbooks/rbenv/providers/rehash.rb",
    "tools/chef/cookbooks/rbenv/providers/ruby.rb",
    "tools/chef/cookbooks/rbenv/providers/script.rb",
    "tools/chef/cookbooks/rbenv/recipes/default.rb",
    "tools/chef/cookbooks/rbenv/recipes/system.rb",
    "tools/chef/cookbooks/rbenv/recipes/system_install.rb",
    "tools/chef/cookbooks/rbenv/recipes/user.rb",
    "tools/chef/cookbooks/rbenv/recipes/user_install.rb",
    "tools/chef/cookbooks/rbenv/recipes/vagrant.rb",
    "tools/chef/cookbooks/rbenv/resources/gem.rb",
    "tools/chef/cookbooks/rbenv/resources/global.rb",
    "tools/chef/cookbooks/rbenv/resources/rehash.rb",
    "tools/chef/cookbooks/rbenv/resources/ruby.rb",
    "tools/chef/cookbooks/rbenv/resources/script.rb",
    "tools/chef/cookbooks/rbenv/templates/default/rbenv.sh.erb",
    "tools/chef/cookbooks/rbenv/test/support/Gemfile",
    "tools/chef/cookbooks/ruby_build/.gitignore",
    "tools/chef/cookbooks/ruby_build/.travis.yml",
    "tools/chef/cookbooks/ruby_build/CHANGELOG.md",
    "tools/chef/cookbooks/ruby_build/README.md",
    "tools/chef/cookbooks/ruby_build/Rakefile",
    "tools/chef/cookbooks/ruby_build/attributes/default.rb",
    "tools/chef/cookbooks/ruby_build/libraries/ruby_build_recipe_helpers.rb",
    "tools/chef/cookbooks/ruby_build/metadata.json",
    "tools/chef/cookbooks/ruby_build/metadata.rb",
    "tools/chef/cookbooks/ruby_build/providers/ruby.rb",
    "tools/chef/cookbooks/ruby_build/recipes/default.rb",
    "tools/chef/cookbooks/ruby_build/resources/ruby.rb",
    "tools/chef/cookbooks/runit/CHANGELOG.md",
    "tools/chef/cookbooks/runit/CONTRIBUTING",
    "tools/chef/cookbooks/runit/LICENSE",
    "tools/chef/cookbooks/runit/README.md",
    "tools/chef/cookbooks/runit/attributes/default.rb",
    "tools/chef/cookbooks/runit/definitions/runit_service.rb",
    "tools/chef/cookbooks/runit/files/default/runit.seed",
    "tools/chef/cookbooks/runit/files/default/runsvdir",
    "tools/chef/cookbooks/runit/files/ubuntu-6.10/runsvdir",
    "tools/chef/cookbooks/runit/files/ubuntu-7.04/runsvdir",
    "tools/chef/cookbooks/runit/files/ubuntu-7.10/runsvdir",
    "tools/chef/cookbooks/runit/files/ubuntu-8.04/runsvdir",
    "tools/chef/cookbooks/runit/metadata.json",
    "tools/chef/cookbooks/runit/metadata.rb",
    "tools/chef/cookbooks/runit/recipes/default.rb",
    "tools/chef/cookbooks/runit/templates/gentoo/runit-start.sh.erb",
    "tools/chef/cookbooks/statsd/.gitignore",
    "tools/chef/cookbooks/statsd/README.md",
    "tools/chef/cookbooks/statsd/attributes/default.rb",
    "tools/chef/cookbooks/statsd/files/default/upstart.conf",
    "tools/chef/cookbooks/statsd/metadata.rb",
    "tools/chef/cookbooks/statsd/recipes/default.rb",
    "tools/chef/cookbooks/statsd/templates/default/config.js.erb",
    "tools/chef/cookbooks/statsd/templates/default/upstart.start.erb",
    "tools/chef/cookbooks/sudo/README.md",
    "tools/chef/cookbooks/sudo/attributes/default.rb",
    "tools/chef/cookbooks/sudo/files/default/README.sudoers",
    "tools/chef/cookbooks/sudo/metadata.json",
    "tools/chef/cookbooks/sudo/metadata.rb",
    "tools/chef/cookbooks/sudo/providers/default.rb",
    "tools/chef/cookbooks/sudo/recipes/default.rb",
    "tools/chef/cookbooks/sudo/resources/default.rb",
    "tools/chef/cookbooks/sudo/templates/default/sudoers.erb",
    "tools/chef/cookbooks/zaproxy/attributes/default.rb",
    "tools/chef/cookbooks/zaproxy/metadata.json",
    "tools/chef/cookbooks/zaproxy/metadata.rb",
    "tools/chef/cookbooks/zaproxy/recipes/default.rb",
    "tools/chef/cookbooks/zaproxy/templates/default/config.xml.erb",
    "tools/chef/cookbooks/zaproxy/templates/default/zaproxy.erb",
    "tools/chef/data_bags/README",
    "tools/chef/nodes/README",
    "tools/chef/nodes/ec2-54-217-29-239.eu-west-1.compute.amazonaws.com.json",
    "tools/chef/roles/README.md",
    "tools/chef/roles/comicrelief.json",
    "tools/chef/roles/load_test_agent.json",
    "tools/chef/roles/load_test_console.json",
    "tools/chef/site-cookbooks/README"
  ]
  s.homepage = "http://github.com/bendodd/gloader"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.23"
  s.summary = "Grinder Load Tester"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<fog>, ["~> 1.16.0"])
      s.add_runtime_dependency(%q<httparty>, ["~> 0.12.0"])
      s.add_runtime_dependency(%q<json>, ["~> 1.8.0"])
      s.add_runtime_dependency(%q<sshkey>, ["~> 1.6.0"])
      s.add_runtime_dependency(%q<net-ssh>, ["~> 2.7.0"])
      s.add_runtime_dependency(%q<thor>, ["~> 0.18.1"])
      s.add_runtime_dependency(%q<log4r>, ["~> 1.1.10"])
      s.add_runtime_dependency(%q<bundler>, ["~> 1.3.5"])
      s.add_runtime_dependency(%q<jeweler>, ["~> 1.8.7"])
      s.add_runtime_dependency(%q<slowweb>, ["~> 0.1.1"])
      s.add_runtime_dependency(%q<formatador>, ["~> 0.2.4"])
      s.add_runtime_dependency(%q<activesupport>, ["~> 3.2"])
      s.add_development_dependency(%q<pry>, [">= 0"])
      s.add_development_dependency(%q<guard>, [">= 0"])
      s.add_development_dependency(%q<guard-rake>, [">= 0"])
      s.add_development_dependency(%q<guard-rubocop>, [">= 0"])
      s.add_development_dependency(%q<guard-bundler>, [">= 0"])
      s.add_development_dependency(%q<growl>, ["~> 1.0.3"])
      s.add_development_dependency(%q<rb-inotify>, ["~> 0.9"])
      s.add_development_dependency(%q<rb-fsevent>, ["~> 0.9"])
      s.add_development_dependency(%q<rdoc>, [">= 0"])
    else
      s.add_dependency(%q<fog>, ["~> 1.16.0"])
      s.add_dependency(%q<httparty>, ["~> 0.12.0"])
      s.add_dependency(%q<json>, ["~> 1.8.0"])
      s.add_dependency(%q<sshkey>, ["~> 1.6.0"])
      s.add_dependency(%q<net-ssh>, ["~> 2.7.0"])
      s.add_dependency(%q<thor>, ["~> 0.18.1"])
      s.add_dependency(%q<log4r>, ["~> 1.1.10"])
      s.add_dependency(%q<bundler>, ["~> 1.3.5"])
      s.add_dependency(%q<jeweler>, ["~> 1.8.7"])
      s.add_dependency(%q<slowweb>, ["~> 0.1.1"])
      s.add_dependency(%q<formatador>, ["~> 0.2.4"])
      s.add_dependency(%q<activesupport>, ["~> 3.2"])
      s.add_dependency(%q<pry>, [">= 0"])
      s.add_dependency(%q<guard>, [">= 0"])
      s.add_dependency(%q<guard-rake>, [">= 0"])
      s.add_dependency(%q<guard-rubocop>, [">= 0"])
      s.add_dependency(%q<guard-bundler>, [">= 0"])
      s.add_dependency(%q<growl>, ["~> 1.0.3"])
      s.add_dependency(%q<rb-inotify>, ["~> 0.9"])
      s.add_dependency(%q<rb-fsevent>, ["~> 0.9"])
      s.add_dependency(%q<rdoc>, [">= 0"])
    end
  else
    s.add_dependency(%q<fog>, ["~> 1.16.0"])
    s.add_dependency(%q<httparty>, ["~> 0.12.0"])
    s.add_dependency(%q<json>, ["~> 1.8.0"])
    s.add_dependency(%q<sshkey>, ["~> 1.6.0"])
    s.add_dependency(%q<net-ssh>, ["~> 2.7.0"])
    s.add_dependency(%q<thor>, ["~> 0.18.1"])
    s.add_dependency(%q<log4r>, ["~> 1.1.10"])
    s.add_dependency(%q<bundler>, ["~> 1.3.5"])
    s.add_dependency(%q<jeweler>, ["~> 1.8.7"])
    s.add_dependency(%q<slowweb>, ["~> 0.1.1"])
    s.add_dependency(%q<formatador>, ["~> 0.2.4"])
    s.add_dependency(%q<activesupport>, ["~> 3.2"])
    s.add_dependency(%q<pry>, [">= 0"])
    s.add_dependency(%q<guard>, [">= 0"])
    s.add_dependency(%q<guard-rake>, [">= 0"])
    s.add_dependency(%q<guard-rubocop>, [">= 0"])
    s.add_dependency(%q<guard-bundler>, [">= 0"])
    s.add_dependency(%q<growl>, ["~> 1.0.3"])
    s.add_dependency(%q<rb-inotify>, ["~> 0.9"])
    s.add_dependency(%q<rb-fsevent>, ["~> 0.9"])
    s.add_dependency(%q<rdoc>, [">= 0"])
  end
end

