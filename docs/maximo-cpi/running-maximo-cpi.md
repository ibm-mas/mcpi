## Running Maximo-CPI

Maximo-CPI can be run in either **Docker** or **an OpenShift cluster**. 



### Run in Docker
    
- Download the docker container: `docker pull quay.io/ibmmas/mcpi:latest`
- Run the docker container: `docker run -dit -p 8888:8888 -p 10514:10514 --name mcpi quay.io/ibmmas/mcpi:latest`

### Run in OpenShift

**Note**: The [mcpi-deployment-full.yaml](../download/deployment/mcpi-deployment-full.yaml) file grants full access to the local cluster, allowing it to access local resources without requiring credentials. In contrast, [mcpi-deployment.yaml](../download/deployment/mcpi-deployment.yaml) has restricted access and requires OpenShift authentication each time it interacts with the local cluster.

- Download [mcpi-deployment.yaml](../download/deployment/mcpi-deployment.yaml) or 
  [mcpi-deployment-full.yaml](../download/deployment/mcpi-deployment-full.yaml)  
- login on OpenShift Cluster: `oc login https://<openshift-master-url>:<port> -u <username> -p <password>`
- Deploy Maximo-CPI: `oc apply -f mcpi-deployment.yaml` or  `oc apply -f mcpi-deployment-full.yaml`

      
### Upgrade from V1 to V2 

- **in Docker**
    - remove the current container `docker rm -f mcpi; docker image rm quay.io/ibmmas/mcpi:latest` 
    - follow the steps in [Run in Docker](#run-in-docker) to re-deploy maximo-cpi

- **in OpenShift**
    - download [v1 deployment yaml](https://ibm-mas.github.io/mas-performance/pd/mcpi/maximo-cpi-deployment.yaml)
    - uninstall **maximo-cpi** by `oc delete -f maximo-cpi-deployment.yaml`
    - follow the steps in [Run in OpenShift](#run-in-openshift) to re-deploy maximo-cpi
  
### Apply the hotfix for v2.1.0 release

- go to the **maximo-cpi pod**, then run `curl -L -v -o /tmp/mcpi-2.1.0-hotfix.sh https://ibm-mas.github.io/mas-performance/pd/download/mcpi/mcpi-2.1.0-hotfix.sh > /dev/null 2>&1; bash /tmp/mcpi-2.1.0-hotfix.sh`

- check the [change log](../changelog.md/#210-hotfix-2025-11-23) for details