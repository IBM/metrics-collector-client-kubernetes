machineid=$(/kubectl cluster-info dump | awk ' /MachineID/ {print $2;exit}' | tr -d "\",")
clusterinfo=$(/kubectl get pods -n kube-system -o yaml | awk ' /armada/ {print $2;exit}')
nodeinfo=$(/kubectl get nodes | awk ' /minikube/ {print $1;exit}')
DATE=$(date '+%Y-%m-%d %H:%M:%S')
if [ ${#clusterinfo} -ne 0 ]; then
	cluster='IBM'
elif [ ${#nodeinfo} -ne 0 ]; then
	cluster='Minikube'
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
