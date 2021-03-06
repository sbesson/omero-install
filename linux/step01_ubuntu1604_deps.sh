#!/bin/bash

apt-get update
apt-get -y install \
	unzip \
	wget \
	python-{pip,tables,virtualenv,yaml,jinja2}

# to be installed if recommended/suggested is false
apt-get -y install python-setuptools python-wheel virtualenv

pip install --upgrade pip

#start-web-dependencies
apt-get -y install zlib1g-dev
apt-get -y install python-{pillow,numpy}
#end-web-dependencies
