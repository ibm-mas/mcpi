### Slack Notification Sample

**Maximo-CPI** offers a set of [CLI commands](./cli-commands.md) to collect metrics across various categories, including node-level, cluster-level, certificate-related data, pod-level, application-level, performance alerts.

Below is an example of how to utilize the output from `get-cert-info.sh` via Slack.

The sample source file is located inside the Maximo-CPI container at `/opt/app-root/src/cron/slack-cert.sh`. Below is the Code Snippet:
```bash
#!/bin/bash

if [ -z "${mhcslacklog}" ]; then
  mhcslacklog="${TMPDIR}/mhc-slack.log"
fi

# verify slack url
if [ -z $slackurl ]; then
    echo "$(date): Warning - slack url is missing." | tee -a "${mhcslacklog}"
    exit
fi

# verify slack channel
if [ -z $slackchannel ]; then
    echo "$(date): Warning - slack channel is missing." | tee -a "${mhcslacklog}"
    exit
fi

if [ -z "${clustername}" ]; then
  clustername="unknow cluster"
fi

slackmsg="$clustername: \n $(get-cert-info.sh)"

echo "$(date '+%Y-%m-%d %H:%M:%S') - info: detected expired certificates. Slack the details to channel ${slackchannel} "

curl -X POST --data-urlencode "payload={\"channel\": \"$slackchannel\", \"username\": \"mhcbot\", \"text\": \"$slackmsg\"}" $slackurl
```