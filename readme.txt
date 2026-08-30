# helm chart install
helm install database ./database -n akkc

helm uninstall database -n akkc


----------------------------------------------
Set Current Context---
kubectl config set-context --current --namespace=akkc


----------------------------------------------
docker buildx build \
  --platform linux/amd64 \
  -t amitkkc01/axion-ingest:1.5 \
  --push .