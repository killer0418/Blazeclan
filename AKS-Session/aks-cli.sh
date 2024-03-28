# Configure Cluster Creds (kube config) for Azure AKS Clusters
az aks get-credentials --resource-group sandbox --name az-k8s

#Get all worksloads deployed in AKS
kubectl get all --all-namespaces

#create
kubectl run <Name> --image=<Container-Image>
kubectl apply -f <path/*.yaml>

# Get Service Info
kubectl get service
kubectl get svc

# Connect to Nginx Container in a POD
kubectl exec -it <pod-name> -- /bin/bash
kubectl exec -i -t <pod-name> --container <cont-name> -- /bin/bash

#expose as service
kubectl expose pod/rs/deployment <Name>  --type=LoadBalancer --port=80 --target-port=5000 --name=<Service-Name>

#delete
kubectl delete pod/re/svc <Name>

################# PODS ####################
kubectl run <desired-pod-name> --image <Container-Image> 
kubectl get pods -o wide
# Describe the Pod
kubectl describe pod <Pod-Name>
# Dump Pod logs
kubectl logs <pod-name>
# Stream pod logs with -f option and access application to see logs
kubectl logs -f <pod-name>

############ Replicaset ###################
# Apply latest changes to ReplicaSet
kubectl replace -f replicaset-demo.yml

########### Deloyment ################
kubectl scale --replicas=10 deployment/<Deployment-Name>
kubectl get deploy
# Update Deployment 
kubectl set image deployment/<Deployment-Name> <Container-Name>=<Container-Image> --record=true
kubectl autoscale deployment/<Deployment-Name> --min=10 --max=15 --cpu-percent=80 # Auto scale up deployment
kubectl rollout pause/resume deployment/<Deployment-Name>
kubectl rollout history deployment/<Deployment-Name> 
kubectl rollout undo deployment/my-first-deployment --to-revision=1 # rollout to specific version