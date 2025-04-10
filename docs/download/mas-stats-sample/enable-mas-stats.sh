#!/bin/bash

source /opt/app-root/src/healthcheck/base.sh

# verify mas namespace 
if [ -z "$1" ]; then 
    echo "missing the namespace"
    exit
fi

get_mas_instance_name() {
  echo "$1" | sed -E 's/^mas-([^-]+)-(core|manage)$/\1/'
}

# retreive mas instance name
MAS_INSTANCE_NAME=$(get_mas_instance_name $1)
log_info "target MAS_INSTANCE_NAME=${MAS_INSTANCE_NAME}"

# make the writable for file overwrite
chmod 700  /opt/app-root/src/server/metricscript/mascore-stats /opt/app-root/src/server/metricscript/masmanage-stats /opt/app-root/src/server/metricscript/managelrq-stats  >/dev/null 2>&1

# configure mascore-stats
log_info "configure mascore-stats"
wget https://ibm-mas.github.io/mcpi/download/mas-stats-sample/mascore-stats.sample >/dev/null 2>&1
sed "s/MASINSTANCE=\"masinst1\"/MASINSTANCE=\"$MAS_INSTANCE_NAME\"/g" ./mascore-stats.sample > /opt/app-root/src/server/metricscript/mascore-stats

# configure masmanage-stats
log_info "configure masmanage-stats"
wget https://ibm-mas.github.io/mcpi/download/mas-stats-sample/masmanage-stats.sample >/dev/null 2>&1
sed "s/MASINSTANCE=\"masinst1\"/MASINSTANCE=\"$MAS_INSTANCE_NAME\"/g" ./masmanage-stats.sample > /opt/app-root/src/server/metricscript/masmanage-stats

# configure managelrq-stats
log_info "configure managelrq-stats"
wget https://ibm-mas.github.io/mcpi/download/mas-stats-sample/managelrq-stats.sample >/dev/null 2>&1
sed "s/MASINSTANCE=\"masinst1\"/MASINSTANCE=\"$MAS_INSTANCE_NAME\"/g" ./managelrq-stats.sample > /opt/app-root/src/server/metricscript/managelrq-stats

# configure the permission
log_info "configure the permission"
chmod 500  /opt/app-root/src/server/metricscript/mascore-stats /opt/app-root/src/server/metricscript/masmanage-stats /opt/app-root/src/server/metricscript/managelrq-stats

# create pod monitors
log_info "create pod monitors"
wget https://ibm-mas.github.io/mcpi/download/mas-stats-sample/mascore-podmonitor.yaml >/dev/null 2>&1
oc apply -f ./mascore-podmonitor.yaml  >/dev/null 2>&1
wget https://ibm-mas.github.io/mcpi/download/mas-stats-sample/masmanage-podmonitor.yaml >/dev/null 2>&1
oc apply -f ./masmanage-podmonitor.yaml  >/dev/null 2>&1
wget https://ibm-mas.github.io/mcpi/download/mas-stats-sample/managelrq-podmonitor.yaml >/dev/null 2>&1
oc apply -f ./managelrq-podmonitor.yaml  >/dev/null 2>&1


# configure rsyslog
log_info "configure rsyslog"
wget https://ibm-mas.github.io/mcpi/download/mas-stats-sample/rsyslog.conf.sample >/dev/null 2>&1
cp /etc/rsyslog.conf ./rsyslog.conf.bak
sed "s/\"masinst1\"/\"$MAS_INSTANCE_NAME\"/g" ./rsyslog.conf.sample > /etc/rsyslog.conf
supervisorctl restart rsyslogd 

# enable ingresslog
log_info "enable ingresslog"
ingresslog-rsyslog.sh

# enable manage long run query
log_info "enable manage long run query"
manage-lrquery-enable.sh "mas-${MAS_INSTANCE_NAME}-manage"

# enable mongo long run query
log_info "enable mongo long run query"
mongodb-lrquery-enable.sh "mongoce"

# enable daily cron
log_info "enable daily cron"
wget https://ibm-mas.github.io/mcpi/download/mas-stats-sample/mas-stats-cron.sample >/dev/null 2>&1
sed "s/MASINSTANCE=\"masinst1\"/MASINSTANCE=\"$MAS_INSTANCE_NAME\"/g" ./mas-stats-cron.sample > /etc/cron.daily/mas-stats-cron
chmod 550 /etc/cron.daily/mas-stats-cron