FROM ubuntu:14.04
MAINTAINER Andrey Sizov, andrey.sizov@jetbrains.com

ENV TERM=xterm
RUN apt-get -y update && \
    apt-get install -y wget && \
    wget http://repo.zabbix.com/zabbix/3.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_3.0-1+trusty_all.deb && \
    dpkg -i zabbix-release_3.0-1+trusty_all.deb && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y zabbix-agent sysstat
    mkdir -p /usr/libexec/zabbix-extensions/scripts/
    wget https://raw.githubusercontent.com/da1ight/docker_zabbix-agent/master/iostat-collect.sh -O /usr/libexec/zabbix-extensions/scripts/iostat-collect.sh
    wget https://raw.githubusercontent.com/da1ight/docker_zabbix-agent/master/iostat-parse.sh -O /usr/libexec/zabbix-extensions/scripts/iostat-parse.sh
    curl https://raw.githubusercontent.com/da1ight/docker_zabbix-agent/master/iostat.conf >> /etc/zabbix/zabbix_agentd.conf 


ADD run-services.sh /
RUN chmod +x /run-services.sh

CMD /run-services.sh
