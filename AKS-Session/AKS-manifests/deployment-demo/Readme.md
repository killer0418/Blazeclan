# Kubectl cmds
- creates deployment & service in one go
    - kubectl apply -f AKS-manifests/deployment-demo
- create deployment & Service seperately
    - kubectl apply -f AKS-manifests/deployment-demo/aks-deploy.yaml
    - kubectl apply -f AKS-manifests/deployment-demo/aks-service-lb.yaml
- # get public IP of service created
    - kubectl get svc -n k8s-sandbox

# Browse and check the Application Deployed

# For Versioning on Deployment updates
- # Run following cmds to Update the image
  - kubectl set image deployment/bcapp-deploy bc-sandbox=msa1999/k8s-sandbox:2 --record=true -n k8s-sandbox
- # list the versions of deployments
  - kubectl rollout history deployment/bcapp-deploy -n k8s-sandbox

# Now Browse the application with Same IP assigned for Service you should find the change in Application

