# Instal additional packages for zabbix checks
# Based on zabbix-agent:latest

FROM zabbix/zabbix-agent:alpine-4.0-latest
MAINTAINER Stanislav Osipov <stanislav.osipov@jetbrains.com>

RUN apk update && \
    apk add sysstat

ADD plugins/ /etc/zabbix/plugins/
RUN find /etc/zabbix/plugins/ -type f -name "*.sh" -exec chmod +x {} \; && \
	find /etc/zabbix/plugins/ -type f -name "*.conf" -exec mv -t /etc/zabbix/zabbix_agentd.conf.d/ {} \;
