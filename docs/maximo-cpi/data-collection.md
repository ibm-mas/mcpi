**Maximo-CPI Harmony Checker** is a new utility that use short and long term snapshots to address specific best practices for deployment of Maximo App Suite. It can assist in pinpointing areas that need improvement and provide actionable insights for optimizing the MAS deployment. 

### Harmony Checker Data Collection

- Enter into **Maximo-CPI** Container
    - in **docker**: `docker exec -it --user root mcpi bash`
    - in **openshift**: go to **maximo-cpi** project -> **mcpi-deployment-xxx** pod -> **Terminal** tab
- OC login on the target cluster: `oc login https://<openshift-master-url>:<port> -u <username> -p <password>` or `oc login https://<openshift-master-url>:<port> --token=<token>`
    - **note:** If **Maximo-CPI** is depolyed by using [mcpi-deployment-full.yaml](../download/deployment/mcpi-deployment-full.yaml), it does **NOT** require oc authentication for the local cluster
- Execute data collection command: `collect-metric.sh`. The script accepts the following environment variables. **Note:**  Environment variables are **Case-Sensitive**.
    - | Env   Variable Name        | Description                                        | Default Value                                                                 |
|----------------------------|----------------------------------------------------|-------------------------------------------------------------------------------|
|        MHCJSON             | Maximo Haromony   Checker JSON File                |        export MHCJSON="${TMPDIR}/mhc-$(date   +"%Y-%m-%d-%H-%M").json"        |
|        INTERVALLIST        | Default intervallist                               |        export INTERVALLIST="5m   15m 1h 3h 1d 3d 5d"                          |
| NSLIST                     | Namespace list   related to MAS apps               |        export NSLIST="mas-.*\|db2u\|.*mongo.*\|.*-sls\|kmodels.*\|aibroker.*" |
| EXPIREDINDAYS              | Check the certficate   expiration in how many days |        export EXPIREDINDAYS=10                                                |
|        SKIP_PIDLIMIT_CHECK | SKIP PIDLIMIT Check                                |        export SKIP_PIDLIMIT_CHECK="false"                                     |
|        COLLECT_DATA_ONLY   | Collect Data Only                                  |        export COLLECT_DATA_ONLY="false"                                       |
- When the command finishes executing, it returns the path to the MHC JSON file. Use the path for [Data Review](./data-review.md) Below is a sample of the returning. In this case, the path to the MHC JSON file is **/tmp/mhc-2024-08-01-19-36.json**
![alt text](data-collection.png)
