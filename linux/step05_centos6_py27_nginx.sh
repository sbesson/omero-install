#!/bin/bash

OMEROVER=${OMEROVER:-latest}
ICEVER=${ICEVER:-ice36}

#start-copy
cp setup_omero_nginx.sh ~omero
#end-copy

cd ~omero

#start-nginx-install
cat << EOF > /etc/yum.repos.d/nginx.repo
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/\$releasever/\$basearch/
gpgcheck=0
enabled=1
EOF
yum -y install nginx
#end-nginx-install

#start-web-dependencies
set +u
source /opt/rh/python27/enable
set -u

if [ "$ICEVER" = "ice36" ]; then
#web-requirements-recommended-start
	pip install -r  OMERO.server/share/web/requirements-py27.txt
#web-requirements-recommended-end
else
#web-requirements-ice35-start
	pip install -r OMERO.server/share/web/requirements-py27-ice35.txt
#web-requirements-ice35-end
fi
#end-web-dependencies

# set up as the omero user.
su - omero -c "bash -eux setup_omero_nginx.sh nginx"

#start-nginx-admin
mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.disabled
cp ~omero/OMERO.server/nginx.conf.tmp /etc/nginx/conf.d/omero-web.conf

service nginx start
#end-nginx-admin
