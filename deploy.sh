docker build -t vinbolisetti/multi-client-k8s:latest -t cygnetops/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t vinbolisetti/multi-server-k8s-pgfix:latest -t cygnetops/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t vinbolisetti/multi-worker-k8s:latest -t cygnetops/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push vinbolisetti/multi-client-k8s:latest
docker push vinbolisetti/multi-server-k8s-pgfix:latest
docker push vinbolisetti/multi-worker-k8s:latest

docker push vinbolisetti/multi-client-k8s:$SHA
docker push vinbolisetti/multi-server-k8s-pgfix:$SHA
docker push vinbolisetti/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=vinbolisetti/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=vinbolisetti/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=vinbolisetti/multi-worker-k8s:$SHA