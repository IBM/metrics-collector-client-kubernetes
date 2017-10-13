# Overview

Metrics Collector Service collects statistics for dpelyoment of a github sample code on Cloud Foundry, Kubernetes, Data Science Experience, OpenWhisk etc. 

This Kubernetes Metrics client can send metrics related to workload deployments on Kubernetes. This is a Kubernetes Job that can track and report details of a demo/tutorial that has been deployed to Kubernetes.

# To Use

1. Clone and go into this repository
	```bash
	git clone https://github.com/IBM/metrics-collector-client-kubernetes.git
	cd metrics-collector-client-kubernetes
	```
2. Fill in the information in the repository.yaml file and save it in this repository. For more details, please go to [Example repository.yaml file](#example-repositoryyaml-file)

3. Use the following commands to install the necessary Python packages and run the Python Job to build your custom Kubernetes job. 
	```bash
	pip install -r requirement.txt
	python build.py
	```
	Now, a `metricjob.yaml` file should be created with all the information in your repository.yaml file.

4. Copy the job in `metricjob.yaml` and only paste it in one of your main Kubernetes yaml files.

5. Add a copy of the [Privacy Notice](#privacy-notice) to your README file. 

   **Note:** All apps that have deployment tracker must include the Privacy Notice.

# Example **repository.yaml** file
The repository.yaml need to be written in YAML format. Also, please put all your keys in lower case.

```
id: Kubernetes-container-service-GitLab-sample
event_id: web
event_organizer: dev-journeys
runtimes: 
  - Kubernetes Cluster
services: 
  - Compose for PostgreSQL
```

Required field:
1. id: Put your journey name/Github URL of your journey.
2. runtimes: Put down all your platform runtime environments in a list.
3. services: Put down all the bluemix services that are used in your journey in a list.
4. event_id: Put down where you will distribute your journey. The default value is **web**. 
5. event_organizer: Put down your event organizer if you have one.

# Privacy Notice

Sample Kubernetes Yaml file that includes this package may be configured to track deployments to [IBM Bluemix](https://www.bluemix.net/) and other Kubernetes platforms. The following information is sent to a [Deployment Tracker](https://github.com/IBM/metrics-collector-service) service on each deployment:

* Kubernetes Cluster Provider(`Bluemix,Minikube,etc`)
* Kubernetes Machine ID (`MachineID`)
* Environment variables in this Kubernetes Job.

This data is collected from the Kubernetes Job in the sample application's yaml file. This data is used by IBM to track metrics around deployments of sample applications to IBM Bluemix to measure the usefulness of our examples so that we can continuously improve the content we offer to you. Only deployments of sample applications that include code to ping the Deployment Tracker service will be tracked.

## Disabling Deployment Tracking

Please comment out/remove the Metric Kubernetes Job portion in the Yaml file where you inserted this Kubernetes Job.

# License

[Apache 2.0](LICENSE)
