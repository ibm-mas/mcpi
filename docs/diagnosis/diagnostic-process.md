
# Diagnostic Process and Check List

### First Steps for Performance Diagnosis

[This page](https://pages.github.ibm.com/maximoappsuite/masperf/support/manage-firststeps/) contains helpful links and procedures for the MAS Manage application and db performance troubleshoot


### Check List for Performance Issue

- check node status. e.g. any NOT Ready worker nodes
- verify if there is any pod or node cpu, memeory usage approaching to the limit?
- verify if there is any pod restarted many time recently?
- verify if there is any JVM Heapdump dump?
- verify if there is any JVM Hung Thread
- verify if there is any node or pod with a high system or IO wait (20%)?
- verify if there is any node memory, disk or pid pressure?
- verify if the response time is high (over 2 sec)?
- verify if any long running (over 2 sec) or high cpu cost query?
- verify if there is network bottleneck (e.g. load-balancer)
- identify if app server or db server is busy?
  - if app server is busy
    - check the request, limit value for cpu, memory
    - should replic memebers be increased?
  - if db server is busy
    - check cpu, memory, disk current usage and limit value
    - check any utility in the background. e.g. backup
    - check db lock
    - check if there is any high cost query
    - check disk performance

### Factors in system performance

System performance depends on more than the applications and the database. The network architecture affects performance. Application server configuration can hurt or improve performance. The way that you deploy Maximo across servers affects the way the products perform. Many other factors come into play in providing the end-user experience of system performance. Subsequent sections in this paper address the following topics:

- System architecture setup including OCP, Instance Type, Storage
- App and DB server configuration
- Network issues
- Bandwidth
- Load balancing
- Database tuning
- SQL tuning
- Scheduled tasks (cron tasks)
- Reporting
- Integration with other systems using the integration framework
- Troubleshooting