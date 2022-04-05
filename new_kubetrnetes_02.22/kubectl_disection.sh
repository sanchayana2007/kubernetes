 #name of the clustername
clustername="kind-app-1-cluster"
apiserver_url=$(kubectl config view -o jsonpath="{.clusters[?(@.name==\"$clustername\")].cluster.server}")
echo "$apiserver_url"
echo "***********AUTHORISATION AND AUTHENTICATION BY API SERVER ######################"
echo "Create a secret to hold a token for the default service account"

defaultSA_secret=$(kubectl get sa | awk  'NR==2 {print $2}')
#check the NUll Value
if [[ ! -z "$defaultSA_secret"  ]];
	then 
	defaultSA_secret_name=$(kubectl describe  sa default  | awk  'NR==7 {print $2}')
	TOKEN=$(kubectl get secret $defaultSA_secret_name  -o jsonpath='{.data.token}' | base64 --decode)
	curl -X GET  "$apiserver_url/api" --header "Authorization: Bearer $TOKEN" --insecure

else

	kubectl apply -f - <<EOF                                                  apiVersion: v1
kind: Secret
metadata:
  name: sanch-token
  annotations:
    kubernetes.io/service-account.name: default
type: kubernetes.io/service-account-token
EOF
defaultSA_secret_name=$(kubectl describe  sa default  | awk  'NR==7 {print $2}')
TOKEN=$(kubectl get secret $defaultSA_secret_name  -o jsonpath='{.data.token}' | base64 --decode)
curl -X GET  "$apiserver_url/api" --header "Authorization: Bearer $TOKEN" --insecure



fi
