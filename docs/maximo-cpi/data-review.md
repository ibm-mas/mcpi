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
