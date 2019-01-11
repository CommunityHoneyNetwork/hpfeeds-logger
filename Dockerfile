FROM ubuntu:18.04

LABEL maintainer Alexander Merck <alexander.t.merck@gmail.com>
LABEL name "chn-hpfeeds-logger"
LABEL version "0.1"
LABEL release "1"
LABEL summary "Community Honey Network hpfeeds logger"
LABEL description "Small App for reading from MHN's hpfeeds broker and writing splunk logs"
LABEL authoritative-source-url "https://github.com/CommunityHoneyNetwork/hpfeeds-logger"
LABEL changelog-url "https://github.com/CommunityHoneyNetwork/hpfeeds-logger/commits/master"

ENV playbook "hpfeeds-logger.yml"

RUN apt-get update \
    && apt-get install -y ansible

RUN echo "localhost ansible_connection=local" >> /etc/ansible/hosts
ADD . /opt/
RUN ansible-playbook /opt/${playbook}

ENTRYPOINT ["/usr/bin/runsvdir", "-P", "/etc/service"]