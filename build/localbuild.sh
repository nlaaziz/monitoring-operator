docker build . --file ./build/Dockerfile --tag monitoring-operator:latest
docker tag monitoring-operator:latest nlaaziz/monitoring-operator:latest
docker push nlaaziz/monitoring-operator:latest
