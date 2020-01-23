VERSION=0.0.20

$(aws ecr get-login --no-include-email --region us-east-1)

docker-compose  build dask-worker

docker tag dask:latest 111124628564.dkr.ecr.us-east-1.amazonaws.com/dask:$VERSION

# docker push 111124628564.dkr.ecr.us-east-1.amazonaws.com/dask:$VERSION
