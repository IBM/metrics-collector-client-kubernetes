/kubectl get nodes -o yaml > nodeinfo.yaml
/kubectl get pods -n kube-system -o yaml > kube-system.yaml
/kubectl get cm -n kube-system cluster-info -o yaml > clusterinfo.yaml
clusterid=$(awk ' /cluster_id/ {print $2;exit}' clusterinfo.yaml | tr -d "\",")
customerid=$(awk ' /customer_id/ {print $2;exit}' clusterinfo.yaml | tr -d "\",")
machineid=$(awk ' /machineID/ {print $2;exit}' nodeinfo.yaml | tr -d "\",")
clusterinfo=$(awk ' /armada/ {print $2;exit}' kube-system.yaml)
kubeadm=$(awk ' /mirantis/ {print $2;exit}' kube-system.yaml)
nodeinfo=$(awk ' /minikube/ {print $1;exit}' nodeinfo.yaml)
DATE=$(date '+%Y-%m-%d %H:%M:%S')
if [ ${#clusterinfo} -ne 0 ]; then
	cluster='IBM'
elif [ ${#nodeinfo} -ne 0 ]; then
	cluster='Minikube'
elif [ ${#kubeadm} -ne 0 ]; then
	cluster='kubeadm'
else
	cluster='Others'
fi

if [ ${#clusterinfo} -ne 0 ]; then
	space_id=$clusterid
else
	space_id=$machineid
fi

data=$(
cat <<EOF
{
  "space_id": "$space_id",
  "provider": "$cluster",
  "date_sent":"$DATE",
  "clusterid": "$clusterid",
  "customerid": "$customerid",
  "runtime": "$language",
  "config": $config
}
EOF
)

curl -d "$data" -H "Content-Type: application/json" -X POST http://metrics-tracker.mybluemix.net/api/v1/track
