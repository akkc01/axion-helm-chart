For default installation--
Need to port forward for your telemetry svc- "http://localhost:8085"


for dev installation-- using dev.values.yaml
Need to use your telemetry svc ingress- "http://dev.telemetry.theakkc.space"


for prod installation-- using dev.values.yaml
Need to use your telemetry svc ingress- "http://telemetry.theakkc.space"


parent values.yaml mein sirf woh values define karni hain jo tum override karna chahte ho.


helm dependency update
ls charts/
pwd
find charts -maxdepth 2 -type f | sort
cat Chart.yaml

helm lint .
helm template axion-app . \
  -n axion-dev


helm upgrade --install axion-app . \
  -n axion-dev \
  --create-namespace \
  -f values.yaml


