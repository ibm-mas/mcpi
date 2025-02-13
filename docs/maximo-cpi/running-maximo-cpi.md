# Running Maximo-CPI

Maximo-CPI can be run in either **Docker** or **an OpenShift cluster**. 



## Run in Docker
    
- Download the docker container: `docker pull quay.io/ibmmas/mcpi:latest`
- Run the docker container: `docker run -dit -p 8888:8888 --name mcpi quay.io/ibmmas/mcpi:latest`

## Run in OpenShift

**Note**: The [maximo-cpi-deployment-sa-v1.yaml](../download/deployment/maximo-cpi-deployment-sa-v1.yaml) file grants full access to the local cluster, allowing it to access local resources without requiring credentials. In contrast, [maximo-cpi-deployment-v1.yaml](../download/deployment/maximo-cpi-deployment-v1.yaml) has restricted access and requires OpenShift authentication each time it interacts with the local cluster.

- Download [maximo-cpi-deployment-v1.yaml](../download/deployment/maximo-cpi-deployment-v1.yaml) or 
  [maximo-cpi-deployment-sa-v1.yaml](../download/deployment/maximo-cpi-deployment-sa-v1.yaml)  
- login on OpenShift Cluster: `oc login https://<openshift-master-url>:<port> -u <username> -p <password>`
- Deploy Maximo-CPI: `oc apply -f maximo-cpi-deployment-v1.yaml` or  `oc apply -f maximo-cpi-deployment-sa-v1.yaml`

      
