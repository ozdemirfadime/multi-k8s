docker build -t ozdemirfadime/multi-client:latest -f ./client/Dockerfile:$SHA ./client
docker build -t ozdemirfadime/multi-server:latest -f ./server/Dockerfile:$SHA ./server
docker build -t ozdemirfadime/multi-worker:latest -f ./worker/Dockerfile:$SHA ./worker
docker push ozdemirfadime/multi-client:$SHA
docker push ozdemirfadime/multi-server:$SHA
docker push ozdemirfadime/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ozdemirfadime/multi-server:$SHA
kubectl set image deployments/client-deployment client=ozdemirfadime/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=ozdemirfadime/multi-worker:$SHA