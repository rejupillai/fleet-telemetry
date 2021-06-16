export CTX_1=gke_reju-asm-demos_us-east1_east
export CTX_2=gke_reju-asm-demos_us-west1_west
export COMMON_NS=fleet-manager

for CTX in ${CTX_1} ${CTX_2}
  do
    kubectl  --context=${CTX} delete deploy --all -n ${COMMON_NS}
    kubectl  --context=${CTX} create ns ${COMMON_NS}
    kubectl apply --context=${CTX}  -f deploy.yaml -n ${COMMON_NS}
  done

  # sleep 10
export PUBLIC_IP=`kubectl --context=${CTX_1} get svc -n ${COMMON_NS} | grep -i LoadBalancer | awk '{print $4}'`
chrome http:\/\/$\{PUBLIC_IP\}