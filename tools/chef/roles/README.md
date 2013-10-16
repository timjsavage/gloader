# Roles notes

## Logstash

View cluster health at: http://localhost:9200/_cluster/health

### Testing

* cd Vagrant
* vagrant up
* cd ..
* fix node:Logging-localhost
* TEST_USER=armakuni TEST_PASS=... be cucumber features/logging.feature
