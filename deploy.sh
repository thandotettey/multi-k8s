docker build -t thandotettey/multi-client:latest -t thandotettey/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t thandotettey/multi-server:latest -t thandotettey/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t thandotettey/multi-worker:latest -t thandotettey/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push thandotettey/multi-client:latest
docker push thandotettey/multi-client:$SHA
docker push thandotettey/multi-server:latest
docker push thandotettey/multi-server:$SHA
docker push thandotettey/multi-worker:latest
docker push thandotettey/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=thandotettey/multi-server:$SHA
kubectl set image deployments/client-deployment client=thandotettey/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=thandotettey/multi-worker:$SHA
