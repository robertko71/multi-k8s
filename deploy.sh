docker build -t robertko71/multi-client:latest -t robertko71/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t robertko71/multi-server:latest -t robertko71/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t robertko71/multi-worker:latest -t robertko71/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push robertko71/multi-client:latest
docker push robertko71/multi-server:latest
docker push robertko71/multi-worker:latest

docker push robertko71/multi-client:$SHA
docker push robertko71/multi-server:$SHA
docker push robertko71/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=robertko71/multi-server:$SHA
kubectl set image deployments/client-deployment client=robertko71/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=robertko71/multi-worker:$SHA
