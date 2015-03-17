FROM ubuntu:latest

RUN apt-get update
RUN apt-get install -y wget
RUN apt-get install -y openjdk-7-jre
RUN mkdir -p /var/atlassian/application-data
RUN groupadd -r bamboo
RUN useradd -r -m -g bamboo -d /var/atlassian/application-data/bamboo bamboo
RUN mkdir -p /opt/atlassian/bamboo
RUN chown -R bamboo:bamboo /opt/atlassian/bamboo
WORKDIR /opt/atlassian/bamboo
USER bamboo
RUN wget -q https://www.atlassian.com/software/bamboo/downloads/binary/atlassian-bamboo-5.8.0.tar.gz \
  && echo 88e2463a775fe6078c6ccf5142117384beb0be4d73815ce2146e0f05cde771f5 atlassian-bamboo-5.8.0.tar.gz | sha256sum -c - \
  && tar zxf atlassian-bamboo-5.8.0.tar.gz \
  && rm atlassian-bamboo-5.8.0.tar.gz
RUN ln -s atlassian-bamboo-5.8.0 current
USER root
COPY bamboo-init.properties current/atlassian-bamboo/WEB-INF/classes/
RUN chown bamboo:bamboo current/atlassian-bamboo/WEB-INF/classes/bamboo-init.properties
COPY bamboo /etc/init.d/
RUN chmod a+x /etc/init.d/bamboo
EXPOSE 8085
USER bamboo
WORKDIR /opt/atlassian/bamboo/current
CMD bin/start-bamboo.sh -fg
