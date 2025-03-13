## Supervisor Service

**Maximo-CPI** uses [Supervisor](https://supervisord.org/introduction.html) to manage the services running inside the container. The main services include `crond`, `rsyslogd` and `viewer-server`. The config file locates at`/etc/supervisor/cron.d/mcpi.conf`. <br><br>
Below is the Code Snippet for the current setting:

```
[program:crond]
command = crond
priority = 100
autostart = true
startsecs = 10
startretries = 100
autorestart = true
stopsignal = QUIT
stopwaitsecs = 30
stdout_logfile = /var/log/supervisor/%(program_name)s.log
stderr_logfile = /var/log/supervisor/%(program_name)s.log

[program:rsyslogd]
command = rsyslogd -n -i /var/log/rsyslog/rsyslogd.pid
priority = 100
autostart = true
startsecs = 10
startretries = 100
autorestart = true
stopsignal = QUIT
stopwaitsecs = 30
stdout_logfile = /var/log/supervisor/%(program_name)s.log
stderr_logfile = /var/log/supervisor/%(program_name)s.log


[program:viewer-server]
directory=/opt/app-root/src/server
command = python rca.py
priority = 100
autostart = true
startsecs = 10
startretries = 100
autorestart = true
stopsignal = QUIT
stopwaitsecs = 30
stdout_logfile = /var/log/supervisor/%(program_name)s.log
stderr_logfile = /var/log/supervisor/%(program_name)s.log
```

### Useful Commands

- `supervisorctl star/stop/restart <servicename>`: used to start/stop/restart the service after the configuration change. e.g. `supervisorctl restart rsyslogd`
- `supervisorctl reread`: used to reads new or updated program configurations from the Supervisor config files. 
- `supercisorctl update`: used to reloads and applies changes from updated configuration files.

### Add a new service

**Maximo-CPI** pre-installed filebeat. Below are the steps how to add filebeat into the supervisor service:

- update filebeat config file `/opt/app-root/src/conf/filebeat/filebeat.yml`, then copy it to `/etc/filebeat/filebeat.yml`
- update the filebeat-supervisor config file `/opt/app-root/src/conf/filebeat/filebeat.conf` if needed, then copy it to `/etc/supervisor/conf.d`
- re-read the supervisor service: `supervisorctl reread`
- reload the supervisor service: `supercisorctl update`
- start the filebeat service: `supercisorctl start filebeat`