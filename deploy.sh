docker build -t iovin/multi-client-k8s:latest -t iovin/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t iovin/multi-server-k8s-pgfix:latest -t iovin/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t iovin/multi-worker-k8s:latest -t iovin/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push iovin/multi-client-k8s:latest
docker push iovin/multi-server-k8s-pgfix:latest
docker push iovin/multi-worker-k8s:latest

docker push iovin/multi-client-k8s:$SHA
docker push iovin/multi-server-k8s-pgfix:$SHA
docker push iovin/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=iovin/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=iovin/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=iovin/multi-worker-k8s:$SHA