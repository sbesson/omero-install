#!/bin/bash

ICEVER=${ICEVER:-ice36}

# Ice installation
if [[ "$ICEVER" =~ "ice35" ]]; then
	#start-supported
	curl -o /etc/yum.repos.d/zeroc-ice-el6.repo \
	http://download.zeroc.com/Ice/3.5/el6/zeroc-ice-el6.repo

	yum -y install db53 db53-utils mcpp
	mkdir /tmp/ice-download
	cd /tmp/ice-download

	wget https://downloads.openmicroscopy.org/ice/experimental/Ice-3.5.1-b1-centos6-iuspy27-x86_64.tar.gz

	tar -zxvf /tmp/ice-download/Ice-3.5.1-b1-centos6-iuspy27-x86_64.tar.gz

	# Install under /opt
	mv Ice-3.5.1-b1-centos6-iuspy27-x86_64 /opt/Ice-3.5.1

	# make path to Ice globally accessible
	# if globally set, there is no need to export LD_LIBRARY_PATH
	echo /opt/Ice-3.5.1/lib64 > /etc/ld.so.conf.d/ice-x86_64.conf
	ldconfig
	#end-supported
elif [ "$ICEVER" = "ice36" ]; then
	#start-recommended
    curl -sL https://zeroc.com/download/Ice/3.6/el6/zeroc-ice3.6.repo > \
    /etc/yum.repos.d/zeroc-ice3.6.repo

	yum -y install gcc-c++
	yum -y install db53 db53-utils
	yum -y install ice-all-runtime ice-all-devel

	yum -y install openssl-devel bzip2-devel expat-devel

	virtualenv -p /usr/bin/python2.7 /home/omero/omeroenv
	set +u
	source /home/omero/omeroenv/bin/activate
	set -u

	/home/omero/omeroenv/bin/pip2.7 install "zeroc-ice>3.5,<3.7"

	deactivate
	#end-recommended
fi