## CLI Commands

**Maximo-CPI** offers a set of CLI commands to collect metrics across various categories, including node-level, cluster-level, certificate-related data, pod-level, application-level, performance alerts. The command set can be used for the real time diagnosis, alert/notification and more.

### Command output
Most commands support two output formats: standard screen column print (default) and JSON format.
JSON format requires an argument `json` (e.g., `get-node-cpu.sh json`).

### Acceptable Env Variables

**Note:**  Environment Variables are **Case-Sensitive**. Use `unset DTR` to remove the variables

| Env   Variable Name        | Description                                        | Default Value                                                                 |
|----------------------------|----------------------------------------------------|-------------------------------------------------------------------------------|
|        INTERVALLIST        | Default intervallist                               |        export INTERVALLIST="5m   15m 1h 3h 1d 3d 5d"                          |
| NSLIST                     | Namespace list   related to MAS apps               |        export NSLIST="mas-.*\|db2u\|.*mongo.*\|.*-sls\|kmodels.*\|aibroker.*" |
| EXPIREDINDAYS              | Check the certficate   expiration in how many days |        export EXPIREDINDAYS=10                                                |
|                DTR | Default Time Range <br>  **note:** If the command accepts both DTR and INTERVALLIST, it will ignore INTERVALLIST when DTR is set.                               | No default value. Sample command: `export DTR="1h"`                                      |
|                TP_DTR | Default Time Range for get_toppod.sh                            |export TP_DTR="1h"                                      |
|                TP_TOPK | The maximum number of records returned for the top pods.                            | export TP_TOPK="20"|

### Metric-Related Command List

| **CLI Name**             | **Description**                                                                                                                                          | **Acceptable Env Variable**         |
|--------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------|
| get-all-pod-info.sh      | get the pod info e.g. age,   status, restart, cpu request/limit, mem request/limit from all namespaces.                                                  | None                                |
| get-cert-info.sh         | get the expired certificate                                                                                                                              |        EXPIREDINDAYS                |
| get-cluster-info.sh      | get the info for clusterversion,   node count, podcount, cpuAlloc,cpuUtil ,cpuUtil_max_5d ,cpuRC,   cpuLC,memAlloc,memUtil ,memUtil_max_5d ,memRC, memLC | None                                |
| get-ephemeral-storage.sh | get the ephemeral storage info   e.g. instance, device,total_gb,avail_gb,used_gb  util_percentage                                                        | None                                |
| get-ingressor-info.sh    | get the maxconn value of the   ingressor controller                                                                                                      | None                                |
| get-mas-info.sh          | get mas deployment info                                                                                                                                  | None                                |
| get-node-cpu.sh          | get the node cpu metrcis                                                                                                                                 |        INTERVALLIST                 |
| get-node-info.sh         | get the node spec                                                                                                                                        |        INTERVALLIST                 |
| get-node-mem.sh          | get the node memory metrics                                                                                                                              |        INTERVALLIST                 |
| get-node-net.sh          | get the node network metrics                                                                                                                             |        INTERVALLIST                 |
| get-node-pidslimit.sh    | get the node pid limits per   container                                                                                                                  |        None                         |
| get-ns-info.sh           | get the namespace   cpu_request  mem_request  mem_limits    cpu_limits for all namespaces                                                                | None                                |
| get-ns-metric.sh         | get the resource metrics for mas   related namespaces                                                                                                    |        DTR (or INTERVALLIST), <br> NSLIST |
| get-pod-cpu.sh           | get the pod cpu metrics for mas   related namespaces                                                                                                     | DTR (or INTERVALLIST), <br> NSLIST        |
| get-pod-fs.sh            | get the pod filesystem metrics   for mas related namespaces                                                                                              | DTR (or INTERVALLIST), <br> NSLIST        |
| get-pod-info.sh          | get the pod spec info                                                                                                                                    | None                                |
| get-pod-mem.sh           | get the pod mem metrics for mas   related namespaces                                                                                                     | DTR (or INTERVALLIST), <br> NSLIST        |
| get-pod-net.sh           | get the pod network metrics for   mas related namespaces                                                                                                 | DTR (or INTERVALLIST), <br> NSLIST        |
| get-pod-restart.sh       | get the pod restart metrics for   mas related namespaces                                                                                                 | DTR (or INTERVALLIST), <br> NSLIST        |
| get-pvc-info.sh          | get all PVC info                                                                                                                                         | None                                |
| get-toppods.sh           | get the top pods fron                                                                                                                                    |        TP_DTR and TP_TOPK           |



### Filter the json output by JQ query

Consider to use the jq command to filter the output from the CLI. Here’s an example:

- list the nodes whose max_cpu_1h > 40: `get-node-cpu.sh json|jq '[.[] | select(.max_cpu_1h > 40)]'`
