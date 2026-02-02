#!/bin/bash

source /opt/app-root/src/healthcheck/base.sh

# verify mas namespace 
if [ -z "$1" ]; then 
    echo "missing the namespace"
    exit
fi

# get mas instance name
get_mas_instance_name() {
  echo "$1" | sed -E 's/^mas-([^-]+)-(core|manage)$/\1/'
}

# retreive mas instance name
MAS_INSTANCE_NAME=$(get_mas_instance_name $1)
MAS_CORE_NS="mas-${MAS_INSTANCE_NAME}-core"
MAS_MANAGE_NS="mas-${MAS_INSTANCE_NAME}-manage"
log_info "target MAS_INSTANCE_NAME=${MAS_INSTANCE_NAME}"

# make the writable for file overwrite
chmod 700 /opt/app-root/src/server/metricscript/${MAS_CORE_NS}-exporter /opt/app-root/src/server/metricscript/${MAS_MANAGE_NS}-exporter /opt/app-root/src/server/metricscript/${MAS_MANAGE_NS}-lrq-exporter  >/dev/null 2>&1

# configure mascore-stats
log_info "configure mascore-stats"
wget https://ibm-mas.github.io/mcpi/download/mas-stats-exporter/mascore-stats.sample >/dev/null 2>&1
sed "s/MASINSTANCE=\"masinst1\"/MASINSTANCE=\"$MAS_INSTANCE_NAME\"/g" ./mascore-stats.sample > /opt/app-root/src/server/metricscript/${MAS_CORE_NS}-exporter

# configure masmanage-stats
log_info "configure masmanage-stats"
wget https://ibm-mas.github.io/mcpi/download/mas-stats-exporter/masmanage-stats.sample >/dev/null 2>&1
sed "s/MASINSTANCE=\"masinst1\"/MASINSTANCE=\"$MAS_INSTANCE_NAME\"/g" ./masmanage-stats.sample > /opt/app-root/src/server/metricscript/${MAS_MANAGE_NS}-exporter

# configure managelrq-stats
log_info "configure managelrq-stats"
wget https://ibm-mas.github.io/mcpi/download/mas-stats-exporter/managelrq-stats.sample >/dev/null 2>&1
sed "s/MASINSTANCE=\"masinst1\"/MASINSTANCE=\"$MAS_INSTANCE_NAME\"/g" ./managelrq-stats.sample > /opt/app-root/src/server/metricscript/${MAS_MANAGE_NS}-lrq-exporter

# configure the permission
log_info "configure the permission"
chmod 500  /opt/app-root/src/server/metricscript/${MAS_CORE_NS}-exporter /opt/app-root/src/server/metricscript/${MAS_MANAGE_NS}-exporter /opt/app-root/src/server/metricscript/${MAS_MANAGE_NS}-lrq-exporter

# create pod monitors
log_info "create pod monitors"

wget -O mascore-podmonitor.yaml https://ibm-mas.github.io/mcpi/download/mas-stats-exporter/mascore-podmonitor.yaml >/dev/null 2>&1
sed "s/mascore-stats/${MAS_CORE_NS}-exporter/g" ./mascore-podmonitor.yaml >${MAS_CORE_NS}-exporter-podmonitor.yaml
oc apply -f ./${MAS_CORE_NS}-exporter-podmonitor.yaml  >/dev/null 2>&1

wget -O masmanage-podmonitor.yaml https://ibm-mas.github.io/mcpi/download/mas-stats-exporter/masmanage-podmonitor.yaml >/dev/null 2>&1
sed "s/masmanage-stats/${MAS_MANAGE_NS}-exporter/g" ./masmanage-podmonitor.yaml >${MAS_MANAGE_NS}-exporter-podmonitor.yaml
oc apply -f ./${MAS_MANAGE_NS}-exporter-podmonitor.yaml  >/dev/null 2>&1

wget -O managelrq-podmonitor.yaml https://ibm-mas.github.io/mcpi/download/mas-stats-exporter/managelrq-podmonitor.yaml >/dev/null 2>&1
sed "s/managelrq-stats/${MAS_MANAGE_NS}-lrq-exporter/g" ./managelrq-podmonitor.yaml >${MAS_MANAGE_NS}-lrq-exporter-podmonitor.yaml
oc apply -f ./${MAS_MANAGE_NS}-lrq-exporter-podmonitor.yaml  >/dev/null 2>&1


# configure rsyslog
log_info "configure rsyslog"
wget https://ibm-mas.github.io/mcpi/download/mas-stats-exporter/rsyslog.conf.sample >/dev/null 2>&1
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
# log_info "enable mongo long run query"
# mongodb-lrquery-enable.sh "mongoce"

# enable daily cron
log_info "enable daily cron"
wget -O mas-stats-cron.sample https://ibm-mas.github.io/mcpi/download/mas-stats-exporter/mas-stats-cron.sample >/dev/null 2>&1
sed "s/MASINSTANCE=\"masinst1\"/MASINSTANCE=\"$MAS_INSTANCE_NAME\"/g" ./mas-stats-cron.sample > /etc/cron.daily/${MAS_INSTANCE_NAME}-stats-cron
chmod 550 /etc/cron.daily/${MAS_INSTANCE_NAME}-stats-cron