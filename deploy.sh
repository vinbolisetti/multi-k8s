docker build -t vinbolisetti/multi-client:latest -t vinbolisetti/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t vinbolisetti/multi-server:latest -t vinbolisetti/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t vinbolisetti/multi-worker:latest -t vinbolisetti/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push vinbolisetti/multi-client:latest
docker push vinbolisetti/multi-server:latest
docker push vinbolisetti/multi-worker:latest
docker push vinbolisetti/multi-client:$SHA
docker push vinbolisetti/multi-server:$SHA
docker push vinbolisetti/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=vinbolisetti/multi-server:$SHA
kubectl set image deployments/client-deployment server=vinbolisetti/multi-client:$SHA
kubectl set image deployments/worker-deployment server=vinbolisetti/multi-worker:$SHA
