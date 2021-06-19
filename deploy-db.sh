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

export K8S_CTX="gke_awesome-anthos_us-central1-c_delhi-demo"
export NAMESPACE="default"
export LB_CREATE_DELAY=30

export DB="postgres-db"

cd ${BASE_DIR}/${GIT_REPO}

#Install seeded postgres database
docker build -t ${DOCKER_REPO}/${DB}:${IMAGE_TAG} -f ${DB}/Dockerfile ${DB}
docker push ${DOCKER_REPO}/${DB}:${IMAGE_TAG} 

# Delete all deployments (not services) and re-deploy the containers
kubectl --context ${K8S_CTX} delete deploy postgres-db -n ${NAMESPACE}
kubectl apply -f deploy.yaml -n ${NAMESPACE}

# Wait for Loadbalancer to be created
sleep ${LB_CREATE_DELAY}
export PUBLIC_APP_IP=`kubectl --context=${K8S_CTX} get svc -n ${NAMESPACE} | grep -i LoadBalancer | awk '{print $4}'`
echo $PUBLIC_APP_IP

open -a "Google Chrome" http://$PUBLIC_APP_IP