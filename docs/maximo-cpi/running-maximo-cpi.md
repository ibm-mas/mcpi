# Running Maximo-CPI

Maximo-CPI can be run in either **Docker** or **an OpenShift cluster**. 



## Run in Docker
    
- Download the docker container: `docker pull quay.io/ibmmas/mcpi:latest`
- Run the docker container: `docker run -dit -p 8888:8888 --name mcpi quay.io/ibmmas/mcpi:latest`

## Run in OpenShift

**Note**: The [mcpi-deployment-full.yaml](../download/deployment/mcpi-deployment-full.yaml) file grants full access to the local cluster, allowing it to access local resources without requiring credentials. In contrast, [mcpi-deployment.yaml](../download/deployment/mcpi-deployment.yaml) has restricted access and requires OpenShift authentication each time it interacts with the local cluster.

- Download [mcpi-deployment.yaml](../download/deployment/mcpi-deployment.yaml) or 
  [mcpi-deployment-full.yaml](../download/deployment/mcpi-deployment-full.yaml)  
- login on OpenShift Cluster: `oc login https://<openshift-master-url>:<port> -u <username> -p <password>`
- Deploy Maximo-CPI: `oc apply -f mcpi-deployment.yaml` or  `oc apply -f mcpi-deployment-full.yaml`

      
