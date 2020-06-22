# monitoring-operator

DockerHub cleaning-operator image url:

https://hub.docker.com/repository/docker/nlaaziz/monitoring-operator


Monitoring-operator helps create supervision stacks for multiple teams. Each team
will be able to monitor its own applications separately.

Each team will have its own monitoring namespace, in which, a prometheus and grafana operators
are deployed. Then instances of grafana and prometheus are created and can be exposed to access
team application metrics.

## Monitoring Custom Ressource Definition

The custom resource definition 'monitoring' helps give team specifications to the operator.
Such as, teamName, monitoringNamespace name ...

## USAGE

#### Create Monitoring resource for two teams:

###### team-business

```
apiVersion: monitoring.com/v1alpha1
kind: Monitoring
metadata:
  name: team-business-monitoring
spec:
  teamName: team-business
  monitoringNamespace: team-business-monitoring
  grafana:
    installType: operator
    exposeRoute: true
  prometheus:
    installType: operator
    exposeRoute: true

```

###### team-development

```
apiVersion: monitoring.com/v1alpha1
kind: Monitoring
metadata:
  name: team-development-monitoring
spec:
  teamName: team-development
  monitoringNamespace: team-development-monitoring
  grafana:
    installType: operator
    exposeRoute: true
  prometheus:
    installType: operator
    exposeRoute: true

```

```
$ oc create -f team_developement.yaml
monitoring.monitoring.com/team-development-monitoring created
$ oc create -f team_business.yaml
monitoring.monitoring.com/team-business-monitoring created
$ oc get monitorings.monitoring.com
NAME                          AGE
team-business-monitoring      4s
team-development-monitoring   21s
```

#### A monitoring namespaces associated to each team are created

```
$ oc get project team-business-monitoring
NAME                       DISPLAY NAME   STATUS
team-business-monitoring                  Active
$ oc get project team-development-monitoring
NAME                          DISPLAY NAME   STATUS
team-development-monitoring                  Active
```

#### In monitoring namespaces, grafana and prometheus are deployed separately

###### Team development:

operators:

![alt text](https://github.com/nlaaziz/monitoring-operator/tree/master/doc/images/team-dev-monitor.png?raw=true)

routes:

![alt text](https://github.com/nlaaziz/monitoring-operator/tree/master/doc/images/team-dev-routes.png?raw=true)

###### Team business:

operators:

![alt text](https://github.com/nlaaziz/monitoring-operator/tree/master/doc/images/team-business-monitor.png?raw=true)

routes:

![alt text](https://github.com/nlaaziz/monitoring-operator/tree/master/doc/images/team-business-routes.png?raw=true)


###### Accessible prometheus and grafana using routes:

![alt text](https://github.com/nlaaziz/monitoring-operator/tree/master/doc/images/prometheus.png?raw=true)

![alt text](https://github.com/nlaaziz/monitoring-operator/tree/master/doc/images/grafana.png?raw=true)


#### When deploying applications, each team should add these labels to their services:

Team-business for example, labels are:

```
monitoring: 'true'
teamName: team-business
```

```
apiVersion: v1
kind: Service
metadata:
  name: service-business-app
  labels:
    monitoring: 'true'
    teamName: team-business
spec:
  selector:
    app: business-app
  ports:
    - protocol: TCP
      port: 80
      targetPort: 9376
```
