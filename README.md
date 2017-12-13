# Overview

Metrics Collector Service collects statistics for deployment of a github sample code on Cloud Foundry, Kubernetes, Data Science Experience, OpenWhisk etc. 

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
id: https://github.com/IBM/spring-boot-microservices-on-kubernetes
event_id: web
event_organizer: dev-journeys
runtimes: 
  - Kubernetes Cluster
  - OpenWhisk
services: 
  - Compose for MySQL
language: java
```

Required field:
1. id: Put your Github URL of your pattern/project.
   - Note: Please put down the Github URL if your pattern is not from **IBM** organization in Github.
2. runtimes: Put down all your platform runtime environments in a list.
3. services: Put down all the IBM Cloud services that are used in your journey in a list.
4. event_id: Put down where you will distribute your application. Default is **web**. 
5. event_organizer: Put down your event organizer if you have one. Default is **dev-journeys**
6. language: Please put down the application's main language in lower case if you have one.

# List of runtimes, services, and languages

Please go to the [service list page](https://github.com/IBM/metrics-collector-service/blob/master/docs/service_list.md) to get the list of official names for runtimes, services, and languages.

# Example app

To see how to include this into your app please visit [Java Spring Boot microservices on Kubernetes](https://github.com/IBM/spring-boot-microservices-on-kubernetes).  You will want to pay attention to one of its main [yaml files with the client job](https://github.com/IBM/spring-boot-microservices-on-kubernetes/blob/master/account-summary.yaml#L62).

# Privacy Notice

Sample Kubernetes Yaml file that includes this package may be configured to track deployments to [IBM Cloud](https://www.bluemix.net/) and other Kubernetes platforms. The following information is sent to a [Deployment Tracker](https://github.com/IBM/metrics-collector-service) service on each deployment:

* Kubernetes Cluster Provider(`IBM Cloud,Minikube,etc`)
* Kubernetes Cluster ID (Only from IBM Cloud's cluster)

This data is collected from the Kubernetes Job in the sample application's yaml file. This data is used by IBM to track metrics around deployments of sample applications to IBM Cloud to measure the usefulness of our examples so that we can continuously improve the content we offer to you. Only deployments of sample applications that include code to ping the Deployment Tracker service will be tracked.

## Disabling Deployment Tracking

Please comment out/remove the Metric Kubernetes Job portion in the Yaml file where you inserted this Kubernetes Job.

# License

[Apache 2.0](LICENSE)
