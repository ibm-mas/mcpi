#!/bin/bash

# verify if /tmp/db-export exists
if [ ! -d /tmp/db-export ]; then 
    mkdir /tmp/db-export; cd /tmp/db-export
else
    cd /tmp/db-export
fi

# verify if maximocpi-db.jar exists
if [ ! -f /tmp/db-export/maximocpi-db.jar ]; then 
    curl -L -v -o /tmp/db-export/maximocpi-db.jar https://ibm-mas.github.io/mas-performance/pd/download/maximocpi-db/maximocpi-db.jar > /dev/null 2>&1
fi

# prepare the execution 
IFS='=' read -r key value <<< $(cat /etc/database/operator/secret/maximo.properties |grep mxe.db.url=)
if [[ "${value}" == *"sslConnection=true"* ]]; then
    export DBURL="${value}sslTrustStoreLocation=${java_truststore};sslTrustStorePassword=${java_truststore_password};"
else
    export DBURL="${value}"
fi

IFS='=' read -r key value <<< $(cat /etc/database/operator/secret/maximo.properties |grep mxe.db.user=)
export DBUSERNAME="${value}"

IFS='=' read -r key value <<< $(cat /etc/database/operator/secret/maximo.properties |grep mxe.db.password=)
export DBPASSWORD="${value}"

IFS='=' read -r key value <<< $(cat /etc/database/operator/secret/maximo.properties |grep mxe.db.schemaowner=)
export DBSCHEMAOWNER="${value}"
if [ -z "$DBSCHEMAOWNER" ]; then
    export SQLQUERY="select * from maxattribute"
else
    export SQLQUERY="select * from ${DBSCHEMAOWNER}.maxattribute"
fi

export RESULTTYPE="json"

MDBJSON=/tmp/db-export/mcpi-db.json
cat <<EOF >"${MDBJSON}"
{
    "log": {
        "name": "MAS DB Harmony Log"
    }
}
EOF

tmpjson=$(mktemp)

# collect workload
export SQLQUERY="select * from TABLE(MON_GET_WORKLOAD(NULL, -2)) AS T where workload_name='SYSDEFAULTUSERWORKLOAD'"
java -classpath /tmp/db-export/maximocpi-db.jar:/opt/IBM/SMP/maximo/applications/maximo/lib/* "${JAVA_TOOL_OPTIONS}" com.ibm.maximo.mcpi.DBHarmony -es > ${tmpjson}
# merge into mcpi-db.json
cat <<< $(jq --argfile workload "${tmpjson}" '.log.workload += $workload' "${MDBJSON}") >"${MDBJSON}"


# collect env sys resource
export SQLQUERY="select * from SYSIBMADM.ENV_SYS_RESOURCES"
java -classpath /tmp/db-export/maximocpi-db.jar:/opt/IBM/SMP/maximo/applications/maximo/lib/* "${JAVA_TOOL_OPTIONS}" com.ibm.maximo.mcpi.DBHarmony -es > ${tmpjson}
# merge into mcpi-db.json
cat <<< $(jq --argfile envsysresource "${tmpjson}" '.log.envsysresource += $envsysresource' "${MDBJSON}") >"${MDBJSON}"

# clean up 
rm -rf ${tmpjson}



cat "${MDBJSON}"
