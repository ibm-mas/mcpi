# Welcome to Maximo CPI (Cluster Performance Insights) Playbook

!!!info
    This site will serve as the primary resource for the Maximo-CPI Playbook, providing a centralized platform for guidance, issue discussions, new feature exploration, diagnostic methods, and essential tooling introduction.


!!! danger "Critical Note"
    **IBM Maximo Cluster Performance Insights is offered "AS IS", WITH NO WARRANTY OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING THE WARRANTY OF TITLE, NON-INFRINGEMENT OR NON-INTERFERENCE AND THE IMPLIED WARRANTIES AND CONDITIONS OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.**

    The IBM Product Support you have purchased with your IBM Maximo Application Suite Product does not cover this Application extension. **Do not attempt to submit an IBM support ticket.**

    The IBM TechXChange Maximo Community discussions can be leveraged to crowd-source assistance from Maximo Experts.



### What is IBM Maximo Cluster Performance Insights

**IBM Maximo Cluster Performance Insights (Maximo CPI)**, is a performance and observability solution that use short and long term snapshots to addresses specific best practices for deployment of Maximo App Suite and pinpointing areas that need improvement and provide actionable insights for optimizing the MAS deployment. 

Maximo Clients can conduct a self-assessment to ensure adherence to best practices, optimize resource use, and diagnose performance issues. This process helps in evaluating current practices, identifying areas for improvement, and enhancing overall efficiency and effectiveness.

The utility gathers only metrics data, excluding any sensitive information. It is containerized for ease of use.

### IBM Maximo Cluster Performance Insights Main Features

- Identify any missing or incorrect settings that not follows [MAS Best Practice](https://ibm-mas.github.io/mas-performance/mas/ocp/bestpractice/)
- Offer an in-depth evaluation of the deployed MAS system's performance
- Provide recommendations for minimizing the size of the MAS deployment to reduce infrastructure costs
- Identify certificates that have expired or are about to expire
- Provide suggestion for rebalancing the node resource utilization to optimize the workload
- Capacity to send a notification via slack
- Offer a platform for customized MAS Manage schedule scaling
- Offer Custom Prometheus Metrics Collection that enables dynamic metric collection for improved monitoring and troubleshooting.
- Support Rsyslogd Service to centralizes log collection, making log analysis more efficient.
- Support Cronie Service
- Support Supervisor Service to allows dynamic configuration changes, giving clients the flexibility to customize services on the fly
- Maximo-CPI Prometheus Exporter and Dashboard (upcoming feature in 2.1)
- Maximo-CPI DB Utility (upcoming feature in 2.1)


