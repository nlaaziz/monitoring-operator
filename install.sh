export NS_OPERATOR=monitoring-operator
echo "operator namespace is" $NS_OPERATOR
oc create namespace $NS_OPERATOR
oc create -f deploy/crds/monitoring.com_monitorings_crd.yaml -n $NS_OPERATOR
oc create -f deploy/crds/ephemeral-namespace-crd.yaml -n $NS_OPERATOR
oc create -f deploy/service_account.yaml -n $NS_OPERATOR
oc create -f deploy/clusterrole.yaml -n $NS_OPERATOR
oc create -f deploy/clusterrolebinding.yaml -n $NS_OPERATOR
oc create -f deploy/operator.yaml -n $NS_OPERATOR
