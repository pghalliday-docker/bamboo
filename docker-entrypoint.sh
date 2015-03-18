#!/bin/bash

set -e

SOURCE_SERVER_XML=/bamboo-server.xml
SERVER_XML=${BAMBOO_INSTALL_DIR}/current/conf/server.xml
if [ "${BAMBOO_PROXY_NAME}" != "" -a "${BAMBOO_PROXY_PORT}" != "" ]
then
  sed "s/PROXY_SETTINGS/proxyName=\"${BAMBOO_PROXY_NAME}\" proxyPort=\"${BAMBOO_PROXY_PORT}\"/g" <${SOURCE_SERVER_XML} >${SERVER_XML}
else
  sed 's/PROXY_SETTINGS//g' <${SOURCE_SERVER_XML} >${SERVER_XML}
fi

chown -R ${BAMBOO_USER}:${BAMBOO_GROUP} ${BAMBOO_HOME}
su ${BAMBOO_USER} -c "$@"
