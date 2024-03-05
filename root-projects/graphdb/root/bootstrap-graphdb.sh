Namespace=graphdbx
AppName=${Namespace}-app
IngressManifestFileName="ingress-${AppName}.yaml"
arpA="10.119.148.46"
graphdbClusterHost=${AppName}-cluster-proxy.${arpA}.nip.io

echo "Welcome to GraphDB platform As a Service."
echo "You ask for graphdb cluster bootstrap"
echo "Bootstrap Script started ... "
echo ""
echo "Potentiel existing graphdb resourses cleaning in the namespace ${Namespace} specified !"

kubectl delete ns ${Namespace}

echo "Clean namespace ended" 

echo "Start of the deployment of graphdb cluster ..."

kubectl create ns ${Namespace}

echo "Graphdb cluster need graphdb-license : secret creating"
kubectl create secret generic graphdb-license -n ${Namespace} --from-file graphdb.license
echo "secret created" 

kubectl get secret -n ${Namespace}

echo "Installation with Helm package"
helm install \
	--set deployment.host=${graphdbClusterHost} \
	--set createGraphdbCluster.securityContext.capabilities.drop=["ALL"] \
	--set createGraphdbCluster.securityContext.runAsNonRoot=true \
	--set createGraphdbCluster.securityContext.seccompProfile.type="RuntimeDefault" \
	--create-namespace --namespace ${Namespace} ${AppName} ./graphdb-helm --values=values-dev-tec.yaml \
	--debug --wait --timeout 40m

echo "Setting up Nginx Ingress Controller for the ${AppName} !"

cat > ${IngressManifestFileName} << EOF
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  labels:
    app: ${AppName}
  name: graphdb-cluster-proxy
  namespace: ${Namespace}
spec:
  ingressClassName: nginx
  rules:
  - host: ${graphdbClusterHost}
    http:
      paths:
      - backend:
          service:
            name: graphdb-cluster-proxy
            port:
              number: 7200
        pathType: ImplementationSpecific
status:
  loadBalancer:
    ingress:
    - hostname: localhost
EOF

kubectl -n ${Namespace} apply -f ./${IngressManifestFileName}

echo "Ingress installation done !"

echo "Succeed. Cluster deployed :) "
