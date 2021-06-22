#!/bin/bash
#
# @rejupillai
#
# This script will build project, create docker images and push to a DOCKER_REGISTRY
# This will also deploy to a single K8s Cluster with LoadBalancer endpoint.

# Parameters that needs changes
# Used by Sreeni
export MVN_HOME=/usr/local
export GCP_PROJECT=delhidc-ce-demo
export BASE_DIR=/Users/sreemakam/Google-office-backup/google_personal/qwiklabs/fleet-telemetry/dev
export DOCKER_REPO="gcr.io/delhidc-ce-demo"
export K8S_CTX1="mci-us"
export K8S_CTX2="mci-eu"

# Used by Reju
# export MVN_HOME=/opt/local/apache-maven-3.6.3/
# export BASE_DIR=/Users/reju/code/delhi-launch/
# export DOCKER_REPO="reju"
# export K8S_CTX="gke_awesome-anthos_us-central1-c_delhi-demo"

# Constant parameters 

export GIT_REPO=fleet-telemetry/
export WEBAPP="fleetman-webapp"
export IMAGE_TAG="d1"

export NAMESPACE="default"
export LB_CREATE_DELAY=30

export MS_1="position-simulator"
export MS_2="photo-service"
export MS_3="position-tracker"
export MS_4="staff-service"
export MS_5="api-gateway"
export MS_6="vehicle-telemetry"
export MS_7="webapp-angular"

export DB="postgres-db"


cd ${BASE_DIR}/${GIT_REPO}

# Build  & Push to Docker Registry all SpringBoot microservoces
for MS in ${MS_1} ${MS_2} ${MS_3} ${MS_4} ${MS_5} ${MS_6}
  do
    "${MVN_HOME}/bin/mvn" clean install -f "${BASE_DIR}/${GIT_REPO}/${MS}/pom.xml"
     docker build -t ${DOCKER_REPO}/${MS}:${IMAGE_TAG} -f ${MS}/Dockerfile ${MS}
     docker push ${DOCKER_REPO}/${MS}:${IMAGE_TAG} 
  done

# Build & Push to Docker Registry Angular frontend microservice
cd ${BASE_DIR}/${GIT_REPO}/$MS_7
#npm install  #Uncomment this only once to avoid install of node packages.
ng build --prod
cd ${BASE_DIR}/${GIT_REPO}
docker build -t ${DOCKER_REPO}/${MS_7}:${IMAGE_TAG} -f ${MS_7}/Dockerfile ${MS_7}
docker push ${DOCKER_REPO}/${MS_7}:${IMAGE_TAG} 

cd ${BASE_DIR}/${GIT_REPO}

#Install seeded postgres database
docker build -t ${DOCKER_REPO}/${DB}:${IMAGE_TAG} -f ${DB}/Dockerfile ${DB}
docker push ${DOCKER_REPO}/${DB}:${IMAGE_TAG} 

cd ${BASE_DIR}/${GIT_REPO}
# Create k8s configurations
# cluster 1, config cluster is cluster 1, so MCI applies only to cluster 1
kubectl --context ${K8S_CTX1} delete -f k8s/ -n ${NAMESPACE}
kubectl --context ${K8S_CTX1} delete -f mesh/
kubectl --context ${K8S_CTX1} delete -f mci/ -n ${NAMESPACE}
kubectl --context ${K8S_CTX1} delete -f destinationrules/ -n ${NAMESPACE}

kubectl --context ${K8S_CTX1} apply -f k8s/ -n ${NAMESPACE}
kubectl --context ${K8S_CTX1} apply -f mesh/
kubectl --context ${K8S_CTX1} apply -f mci/ -n ${NAMESPACE}
kubectl --context ${K8S_CTX1} apply -f destinationrules/us-rule.yaml -n ${NAMESPACE}

# cluster 2
kubectl --context ${K8S_CTX2} delete -f k8s/ -n ${NAMESPACE}
kubectl --context ${K8S_CTX2} delete -f mesh/
kubectl --context ${K8S_CTX2} delete -f destinationrules/ -n ${NAMESPACE}

kubectl --context ${K8S_CTX2} apply -f k8s/ -n ${NAMESPACE}
kubectl --context ${K8S_CTX2} apply -f mesh/
kubectl --context ${K8S_CTX2} apply -f destinationrules/eu-rule.yaml -n ${NAMESPACE}

# Goto URL
open -a "Google Chrome" https://frontend.endpoints.delhidc-ce-demo.cloud.goog/