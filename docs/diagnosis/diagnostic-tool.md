## Diagnostic Tool

### App Diagnostic Utilities

| **Name**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| **Description**| **Used For** |
|--------------|-------------------------------|----------------------------------------------------------|
| [Flame Graphs](https://pages.github.ibm.com/maximo/performance-wiki/misc/flamegraphs/manage-simple-profiling.html)| A simple profiling **(for IBM Internal Only)**. | app jvm/pod slowness and high cpu|
| [IBM Health Center](https://pages.github.ibm.com/maximo/performance-wiki/misc/ihc/manage-java-profiling-ihc.html)| A java profiling tool | app jvm/pod slowness and high cpu (offering more detailed insights beyond Flame Graphs)|
| [Maximo Perfmon](https://www.ibm.com/support/pages/enabling-and-disabling-maximo-activity-dashboard-maximo-75-and-maximo-76)| Maximo Activity Dashboard<br>**Note:** Enabling PerfMon may significantly degrade server performance <br> **Recommend** for a single user with Dev/Test env only | Maximo UI Activity Tracing |
| [MAT](https://wiki.eclipse.org/MemoryAnalyzer/)|  MemoryAnalyzer  | JVM Dump Analysis|
| [HTTP Archive Viewer ](https://chromewebstore.google.com/detail/http-archive-viewer/ebbdbdmhegaoooipfnjikefdpeoaidml?hl=en)|  HAR Analysis - for web page and client side (browser) performance  | Maximo API and UI Activity Tracing|
| [Maximo Ping Test Utility](https://ibm-mas.github.io/mas-performance/pd/pingtest/)| A maximo ping service to idenify the timeout limit. | Detect the transacton timeout limit E.g. external gateways|

### DB Diagnostic Utilities

| **Name**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| **Description**| **Used For** |
|--------------|-------------------------------|----------------------------------------------------------|
| [DBTest](https://ibm-mas.github.io/mas-performance/pd/dbtest/)| A simple utility that can run in the MAS Manage Pod for measuring SQL execution time, database network latency, and data fetching duration. | - identify the network issue between db and UI test <br> - execute the query|
| [maximocpi-db]() | An utility to collect db metrics, test network latency and execute sql | - collect db configurations and metrics <br> - identify the network issue between db and UI test <br> - execute the query|
| [IBM DSM ](https://ibm-mas.github.io/mas-performance/pd/db2-performance-diagnosis/#ibm-data-server-manager-ibm-dsm) | **DB2** Troublshooting tool | - Historical and Realtime Troubleshooting|
| [db2top and other cmds ](https://ibm-mas.github.io/mas-performance/pd/db2-performance-diagnosis/#db2top) | **DB2** Troublshooting commands | - Realtime Troubleshooting|
| AWR, StatsPack |**Oracle DB** Troublshooting | - collect db metrics and performance diagnosis|

### Misc

| **Name**&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| **Description**| **Used For** |
|--------------|-------------------------------|----------------------------------------------------------|
| [Poor SQL](http://poorsql.com/)| Online SQL Formatter | Format SQL with an elegant presentation.|
| [SSL Shopper](https://www.sslshopper.com/)| Online certificate decode tool | decode the certificate|
| [Squirrl](http://squirrel-sql.sourceforge.net/)| Universal SQL Client | SQL Execution, SQL Explain...|
| [mongotop, mongostat](https://ibm-mas.github.io/mas-performance/mas/mongodb/bestpractice/#mongodb-troubleshoot)| MongoDB Realtime Troubleshooting | troubleshoot mongodb performance e.g. slow queries |
| [sar](https://access.redhat.com/solutions/276533)| a system command be used to monitor system resources like cpu, memory, disk, network... | troubleshoot the storage class performance |

