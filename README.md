
# Introduction

The fleet-telemetry project hosts the application to demonstrate how a BCP
is executed in a highly automated way when a disaster occurs in a datacenter. It 
follows a SOP for failover or switchover depending on Active/Active (HA) or Active/Standby mode across 2 different GKE clusters in two different regions. Underlying capability to do this is delivered via Anthos Service Mesh (A Managed Istio implementation on GCP) which would help spawn a mesh across the regions. 
The exact capabilities are as follows. 

1.  TBD
1.  
1.  
1.  

## Credit    

The base version of the app _fleet-telemetry_ is credited to **Dick Chesterwood** and is a fork from the repo 
 
[Istio-Fleetman](https://github.com/DickChesterwood/istio-fleetman) 

A huge thanks for creating an amazing project to demonstrate Istio's capabilities.


## Installation Steps    

Steps to setup the _fleet-telemetry_ project

### Prerequisites

1. Any standard Kubernetes cluster. 
2. VSCode IDE for development purposes. 
3. Docker Daemon on your local environment.
4. A JDK > 8 (1.8.x) and Maven >= 3.x
5. NPM >= 7.x & Angular CLI (@angular/cli > 8.x)

### Recommeneded 

_Note - It's only recommended, not a requirement._

1. GKE Cluster 1.19 
2. VSCode IDE for development purposes with 
[Cloud Code](https://marketplace.visualstudio.com/items?itemName=GoogleCloudTools.cloudcode)
3. Docker Daemon >= 2.4 on your local environment 
4. A JDK > 8 (1.8.x) and Maven >= 3.x
5. NPM >= 7.x & Angular CLI (@angular/cli > 8.x)

### Step 1

Clone the repo in a local directory *<BASE_DIR>* and change the *deploy.sh* 
in the *fleet-telemetry* directory to suit your environment.

For example : 

```
export MVN_HOME=/opt/local/apache-maven-3.6.3/
export BASE_DIR=/Users/reju/code/
export GIT_REPO=fleet-telemetry/
export DOCKER_REGISTRY="docker.io"
export DOCKER_REPO="reju"
export IMAGE_TAG="d1"

export K8S_CTX="gke_awesome-anthos_us-central1_mci-us-central1-02"
export NAMESPACE="default"
export LB_CREATE_DELAY=30

```
Note - Uncomment #npm install ; to be done only once to avoid build delay subsequently

### Step 2

Change directory to *<GIT_REPO>* and execute

```
chmod +x deploy.sh
./deploy.sh

```

### Step 3

Grab the IP Address and hit the browser, if it doesn't automatically launch. And you are done ! 

![Fleet-Man](./truck-telemetry.gif)


# Development & Release

## Branching & Merging strategy
The project will follow below 

<img src="git-model@2x.png" alt="drawing" width="500" width="600"/>



