FROM registry.access.redhat.com/ubi8/ubi:8.3

RUN yum install -y hostname java-11-openjdk nc \
    && cd /tmp \
    && curl -O https://www.mirrorservice.org/sites/ftp.apache.org/zookeeper/zookeeper-3.6.2/apache-zookeeper-3.6.2-bin.tar.gz \
    && curl -O https://downloads.apache.org/zookeeper/zookeeper-3.6.2/apache-zookeeper-3.6.2-bin.tar.gz.asc \
    && curl -O https://downloads.apache.org/zookeeper/KEYS \
    && gpg --import KEYS \
    && gpg --verify apache-zookeeper-3.6.2-bin.tar.gz.asc apache-zookeeper-3.6.2-bin.tar.gz \
    && tar zxf apache-zookeeper-3.6.2-bin.tar.gz \
    && mv apache-zookeeper-3.6.2-bin /opt/zookeeper
# Delete KEYS, .asc and .tar.gz files; or multi-stage build more appropriately.

COPY docker-entrypoint.sh /docker-entrypoint.sh
COPY health.sh /opt/zookeeper/bin/health.sh

RUN chmod +x /docker-entrypoint.sh \
    && chmod +x /opt/zookeeper/bin/health.sh \
    && mkdir -p /tmp/zookeeper \
    && touch /tmp/zookeeper/initialize

WORKDIR /opt/zookeeper

ENTRYPOINT ["/docker-entrypoint.sh"]
