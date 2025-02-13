## Scheduled Scaling

**Maximo-CPI** includes a scheduled scaling feature with two scripts: `scale-manage.sh` and `mas-manage-scheduled-scaling-sample.sh`.


**scale-manage.sh**: the script to change the replica value based on manage bundle name

- Command Syntax: `scale-manage.sh <namespace name> <manageworkspacecr name> <bundle name> <replica value>`. e.g. `scale-manage.sh mas-masinst1-manage masinst1-tenant1 ui 5`
- File located at `/opt/app-root/src/cron/scale-manage.sh`

**mas-manage-scheduled-scaling-sample.sh**: the cron script to call **scale-manage.sh**
  
- Sample file is located at `/opt/app-root/src/cron/hourly/mas-manage-scheduled-scaling-sample.sh`  
- Modify the file by updating the date, namespace name, managecr name, replica value to suit the needs. Sample Code Snippet
```bash
#!/bin/bash

current_hour=$(date +"%H")

# scale up manage ui bundle replica to 5 at 8am.
if [ "$current_hour" == "08" ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - info: scaling up manage ui pods from 2 to 5"
    scale-manage.sh mas-masinst1-manage masinst1-tenant1 ui 5
fi

# scale down manage ui bundle replica to 2 at 6pm. 
if [ "$current_hour" == "18" ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - info: scaling down manage ui pods from 5 to 2"
    scale-manage.sh mas-masinst1-manage masinst1-tenant1 ui 2
fi
```
- Copy the script to the cron hourly folder: `cp /opt/app-root/src/cron/hourly/mas-manage-scheduled-scaling-sample.sh /etc/cron.hourly`
- **Maximo-CPI** includes a Cronie service that runs the script every hour