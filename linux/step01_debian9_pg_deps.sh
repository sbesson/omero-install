#!/bin/bash

PGVER=${PGVER:-pg96}

# Postgres installation: version installed will be 9.6
#start-recommended
apt-get -y install postgresql
#end-recommended
service postgresql start