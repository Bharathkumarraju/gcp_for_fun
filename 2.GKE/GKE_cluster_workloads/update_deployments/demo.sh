kubectl apply -f deployment.yml

kubectl set image deployment nginx-deployment

kubectl edit deployment/nginx-deployment