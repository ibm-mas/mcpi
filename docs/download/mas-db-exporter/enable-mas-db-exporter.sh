#!/bin/bash

source /opt/app-root/src/healthcheck/base.sh

# verify mas namespace 
if [ -z "$1" ]; then 
    echo "missing the namespace"
    exit
fi

# get mas instance name
get_mas_instance_name() {
  echo "$1" | sed -E 's/^mas-([^-]+)-manage$/\1/'
}

# retreive mas instance name
MAS_MANAGE_NS=$1

if [ ! -d /opt/app-root/src/db-exporter ]; then 
  mkdir /opt/app-root/src/db-exporter
fi

# configure mas-db-exporter
log_info "configure mas-db-exporter"
wget -O /opt/app-root/src/db-exporter/mas-db-exporter.sh https://ibm-mas.github.io/mcpi/download/mas-db-exporter/mas-db-exporter.sh >/dev/null 2>&1
wget -O /opt/app-root/src/db-exporter/mas-db-exporter.sample https://ibm-mas.github.io/mcpi/download/mas-db-exporter/mas-db-exporter.sample >/dev/null 2>&1
sed "s/MAS_MANAGE_NS=\"mas-masinst1-manage\"/MAS_MANAGE_NS=\"$MAS_MANAGE_NS\"/g" /opt/app-root/src/db-exporter/mas-db-exporter.sample > /opt/app-root/src/server/metricscript/${MAS_MANAGE_NS}-db-exporter

# configure mas-db-expoert-podmonitor
wget -O /opt/app-root/src/db-exporter/mas-db-exporter-podmonitor.yaml https://ibm-mas.github.io/mcpi/download/mas-db-exporter/mas-db-exporter-podmonitor.yaml >/dev/null 2>&1
sed "s/mas-manage-db-exporter/${MAS_MANAGE_NS}-db-exporter/g" /opt/app-root/src/db-exporter/mas-db-exporter-podmonitor.yaml >${MAS_MANAGE_NS}-mas-db-exporter-podmonitor.yaml
oc apply -f /opt/app-root/src/db-exporter/${MAS_MANAGE_NS}-mas-db-exporter-podmonitor.yaml  >/dev/null 2>&1

# change the permission
chmod 700 /opt/app-root/src/server/metricscript/${MAS_MANAGE_NS}-db-exporter
