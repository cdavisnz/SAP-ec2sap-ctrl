## ec2sap-ctrl

A python script that allows for the start and stop of Amazon Web Services EC2 instances, SAP HANA, Sybase RDBMS and SAP Application components. SAP application components can be anything that can be called via the 'sapcontrol' process, such as a SAP Web Dispatcher, Central Services, Application Server.

The 'ec2sap-ctrl' script is built around a `'solution'` a solution can comprise on multiple EC2 instances, database's and SAP components and uses the 'sapcontrol' process via SSH remote commands for operations. An `'operation'` can be start/stop or status. 

Begin a python script, it can easily be scheduled within cron to preform operations at set times. 

###### Directory Structure

/opt/ec2sap-ctrl/cfg/
/opt/ec2sap-ctrl/bin/
/opt/ec2sap-ctrl/log/

###### Configuration File

```
git status
git add
git commit
```
