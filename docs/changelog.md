# Changelog

### 2.0.2 
- Fix for Bug: the default logrotation daily cron stops a custom conf
- New Feature MASPERF-442: Support MAS-HTTP-LRQ-Exporter for mas core and manage app

### 2.0.1 (2025-04-10)
- Fix for Bug MASPERF-427: ingresslog-rsyslog.sh fails to use service ip if the current project is not `maximo-cpi` 

### 2.0.0 (2025-03-26)
-  Support custom Prometheus metrics collection.
-  Support the rsyslogd service for centralized log collection.
-  Support the Cronie service, replacing the cron script in v1.x with Cronie.
-  Support the Supervisor service for managing configuration changes in services.
-  Fix for [Issue #1](https://github.com/ibm-mas/mcpi/issues/1) - collect-metric.sh throws an error when no certificates are collected (header only). 
-  Set EXPIREDINDAYS=30. Previous default value was 10 days.
-  Story MASPERF-418: Update the log format for `collect-metric.sh`.

### 1.1.1 (2025-01-22)

-  Fix the bug where `util` is not a string in `pvcanalytics.py`.
-  Add `--container=router` in `get-ingressor-info.sh`.

### 1.1.0 (2025-01-14)

-  Release 1.1.0 with the hotfix for ephemeral storage usage by pod.

### 1.0.0 (2024-11-23)

- Release 1.0
