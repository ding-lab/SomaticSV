
IMAGE="mwyczalkowski/somatic_sv_workflow:20200108"

cd ..
docker build -t $IMAGE -f docker/Dockerfile .
