FROM ubuntu:latest

ENV ATLASSIAN_HOME=/var/atlassian/application-data \
    BAMBOO_USER=bamboo \
    BAMBOO_GROUP=bamboo \
    BAMBOO_CHECKSUM=88e2463a775fe6078c6ccf5142117384beb0be4d73815ce2146e0f05cde771f5 \
    BAMBOO_BASENAME=atlassian-bamboo-5.8.0 \
    BAMBOO_INSTALL_DIR=/opt/atlassian/bamboo

ENV BAMBOO_HOME=${ATLASSIAN_HOME}/bamboo \
    BAMBOO_TARBALL=${BAMBOO_BASENAME}.tar.gz

ENV BAMBOO_URL=https://www.atlassian.com/software/bamboo/downloads/binary/${BAMBOO_TARBALL}

RUN apt-get update \
    && apt-get install -y \
    wget \
    openjdk-7-jre

RUN mkdir -p ${ATLASSIAN_HOME} \
    && groupadd -r ${BAMBOO_GROUP} \
    && useradd -r -m -g ${BAMBOO_GROUP} -d ${BAMBOO_HOME} ${BAMBOO_USER} \
    && mkdir -p ${BAMBOO_INSTALL_DIR}

WORKDIR ${BAMBOO_INSTALL_DIR}
RUN wget -q ${BAMBOO_URL} \
    && echo ${BAMBOO_CHECKSUM} ${BAMBOO_TARBALL} | sha256sum -c - \
    && tar zxf ${BAMBOO_TARBALL} \
    && rm ${BAMBOO_TARBALL} \
    && ln -s ${BAMBOO_BASENAME} current \
    && chown -R ${BAMBOO_USER}:${BAMBOO_GROUP} current/logs \
    && chown -R ${BAMBOO_USER}:${BAMBOO_GROUP} current/temp \
    && chown -R ${BAMBOO_USER}:${BAMBOO_GROUP} current/work

COPY bamboo-server.xml /
COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

WORKDIR ${BAMBOO_INSTALL_DIR}/current/bin
EXPOSE 8085
CMD ./start-bamboo.sh -fg
