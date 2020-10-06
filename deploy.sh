docker build -t anavarron/multi-client:latest -t anavarron/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t anavarron/multi-server:latest -t anavarron/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t anavarron/multi-worker:latest -t anavarron/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push anavarron/multi-client:latest
docker push anavarron/multi-server:latest
docker push anavarron/multi-worker:latest

docker push anavarron/multi-client:$SHA
docker push anavarron/multi-server:$SHA
docker push anavarron/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=anavarron/multi-server:$SHA
kubectl set image deployments/client-deployment client=anavarron/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=anavarron/multi-worker:$SHA


