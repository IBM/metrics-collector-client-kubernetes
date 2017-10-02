/kubectl get nodes -o yaml > nodeinfo.yaml
/kubectl get pods -n kube-system -o yaml > kube-system.yaml
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

data=$(
cat <<EOF
{
  "space_id": "$machineid",
  "provider": "$cluster",
  "date_sent":"$DATE",
  "config": $config
}
EOF
)

curl -d "$data" -H "Content-Type: application/json" -X POST http://metrics-tracker.mybluemix.net/api/v1/track
