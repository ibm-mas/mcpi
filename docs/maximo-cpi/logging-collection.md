## Logging Collection

**Maximo-CPI** can be used as a **rsyslog** server. The default service port is `10514`. Also, it offers a few scripts that enable/disable ingressor log and manage pod log. 

### OpenShift Ingressor Log Collection

- Openshift uses haproxy as the ingressor controller. Use `ingresslog-rsyslog.sh` to forward haproxy access log to **Maximo-CPI** pod. Use `ingresslog-disable.sh` to disable the log forwarding or `ingresslog-container` to keep the log in the haproxy container only. 
- Modify `/etc/rsyslog.conf` for filtering and log redirection. Code Snippet for the current setting:

```bash
# Provides UDP syslog reception
module(load="imudp")     
input(type="imudp" port="10514")

# Provides TCP syslog reception
module(load="imtcp")
input(type="imtcp" port="10514")

# Send local log messages to a remote server 
# module(load="omfwd")
# *.*    @logserver.example.com:514  # UDP forwarding
# *.*    @@logserver.example.com:514 # TCP forwarding

#### GLOBAL DIRECTIVES ####

# Where to place auxiliary files
global(workDirectory="/var/log/rsyslog")


# haproxy access log
$template AccessLogs,"/var/log/rsyslog/haproxy-access.log"
$template msgOnly, "%msg%\n"

# manage ui access log
if ($hostname contains "router-default-" and $msg contains "masinst1-tenant1-ui") then {
    action(type="omfile" file="/var/log/rsyslog/ui-access.log" template="msgOnly")
}

# manage long runing query log
if ($syslogtag contains "manage-lrquery") then {
    action(type="omfile" file="/var/log/rsyslog/manage-lrquery.log" template="msgOnly")
}

# catch the rest
*.* ?AccessLogs
& ~
```
