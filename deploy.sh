#!/bin/bash
#
# @rejupillai
#
# This script will build project, create docker images and push to a DOCKER_REGISTRY
# This will also deploy to a single K8s Cluster with LoadBalancer endpoint.

export MVN_HOME=/opt/local/apache-maven-3.6.3/
export BASE_DIR=/Users/reju/code/delhi-launch/
export GIT_REPO=fleet-telemetry/
export DOCKER_REGISTRY="docker.io"
export DOCKER_REPO="reju"
export IMAGE_TAG="d1"

export K8S_CTX="gke_awesome-anthos_us-central1_mci-us-central1-02"
export NAMESPACE="default"
export LB_CREATE_DELAY=30


export MS_1="position-simulator"
export MS_2="photo-service"
export MS_3="position-tracker"
export MS_4="staff-service"
export MS_5="api-gateway"
export MS_6="vehicle-telemetry"
export MS_7="webapp"


cd ${BASE_DIR}/${GIT_REPO}

# Build  & Push to Docker Registry all SpringBoot microservoces
for MS in ${MS_1} ${MS_2} ${MS_3} ${MS_4} ${MS_5} ${MS_6}
  do
    "${MVN_HOME}/bin/mvn" install -f "${BASE_DIR}/${GIT_REPO}/${MS}/pom.xml"
     docker build -t ${DOCKER_REPO}/${MS}:${IMAGE_TAG} -f ${MS}/Dockerfile ${MS}
     docker push ${DOCKER_REPO}/${MS}:${IMAGE_TAG} 
  done

# Build & Push to Docker Registry Angular frontend microservice
cd ${BASE_DIR}/${GIT_REPO}/$MS_7
#npm install  #Uncomment this only once to avoid install of node packages.
ng build --prod
docker build -t ${DOCKER_REPO}/${MS_7}:${IMAGE_TAG} -f ${MS_7}/Dockerfile ${MS_7}

cd ${BASE_DIR}/${GIT_REPO}


# Delete all deployments (not services) and re-deploy the containers
kubectl --context ${K8S_CTX} delete deploy --all -n ${NAMESPACE}
kubectl apply -f deploy.yaml -n ${NAMESPACE}

# Wait for Loadbalancer to be created
sleep ${LB_CREATE_DELAY}
export PUBLIC_APP_IP=`kubectl --context=${K8S_CTX} get svc -n ${NAMESPACE} | grep -i LoadBalancer | awk '{print $4}'`
echo $PUBLIC_APP_IP

open -a "Google Chrome" http://$PUBLIC_APP_IP