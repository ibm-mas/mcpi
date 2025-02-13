**Maximo-CPI Harmony Checker** is a new utility that use short and long term snapshots to addresses specific best practices for deployment of Maximo App Suite. It can assist in pinpointing areas that need improvement and provide actionable insights for optimizing the MAS deployment. 

### Harmony Check Data Review

- Record or download the collection json file path. When [Data collection process](./data-collection.md) is completed, it returns the path to the MHC JSON file. 
  
- Review the json file:
    - **in docker**:
        - Launch the mcpi viewer url ([http://localhost:8888](http://localhost:8888)) in the browser
        - review the data: Under Load a MAS Harmony Checker JSON file from the server's path, enter the path to the MHC JSON file e.g. /tmp/mhc-2024-08-01-19-36.json Below is the sample snapshot 
    ![alt text](data-review.png)

    - **in openshift**:
        - go to maximo-cpi project -> Networking -> Routes
        - click on mcpi-viewer-route url
        - review the data: Under Load a MAS Harmony Checker JSON file from the server's path, enter the path to the MHC JSON file e.g. /tmp/mhc-2024-08-01-19-36.json.

### Tab Details

| Tab Name                |  Coverage                                                                                                    | Use Scenario                                                                         |
|-------------------------|--------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------|
| Cluster                 | Compute   Resources Statistics (e.g. over-commit ratio); best practice recommendations;   performance alerts | - Identify   any missing or incorrect settings that not follows MAS Best Practice <br> -  Verify the overall cluster resource allocation and justify if the cluster is over/under provisioned <br> - Identify performance alerts, configuration correction|
| Nodes                   | Node Status, Resource   Statistics                                                                           | - Identify performance   issues at the node level. <br> - Understand the resource usage trendency at the node level.                                |
| Namespaces   & Pod Spec | Aggregate resources   by namespace and pods.                                                                 | - Identify resource allocations by namespace or pod <br> - Used for prediction development|
| Certificate             | Identify certificates   that have expired or are about to expire                                             | Certificate renewal  configuration and alerts                                  |
| MAS Deployment          | Cluster-wide MAS   Deployment Status and Statistic                                                           | Identify the   deployment version and any failure status app at the cluster level. Suitable for multi-deployment environments.                |
| MAS Namespaces   & Pods | Aggregate resources   statistics by MAS-related namespace and pods only                                      | - Understand the resource usage trendency at the node level. <br> - Identify performance issues at the application/pod level by usage details. (**Second Step**)  |
| Performance   Analytics | Performance Alert   Heatmap; Performance Message Details                                                     | - Identify performance issues at the application/pod level (**First Step**)                   |
| Resource   Optimization | Pod Resource   Adjustment Recommendation to reduce footprint                                                 | Reducing   resource requests to minimize the overall deployment footprint.      |
| Storage                 | List the insights of   Ephemeral Storage and Persistent Volume Claims                                        | Identify the Storage usage, availability troubleshooting, analysis, and alerts.                   |
| About                   | List the current   version, Harmony Checker environment variables, and Node/Pod counts.                      | Environment variable   adjustment; Version verification                         |
