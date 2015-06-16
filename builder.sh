#!/usr/sbin/env bash
set -e

if [ ! -f activator ] ; then
	echo "No activator project found, add a volume containing a project in /opt/app"
	exit 1
fi
if [ ! -S /var/run/docker.sock ] ; then
	echo "Please attach a docker socket to /var/run/docker.sock ( add -v /var/run/docker.sock:/var/run/docker.sock )"
	exit 1
fi
if [ -z "${IMAGE_NAME}" ]; then 
	echo "Env var IMAGE_NAME not specified";
	exit 1
fi
if [ -f pre_dist.sh ] ; then
	echo "Running pre_dist.sh script"
	./pre_dist.sh
fi

echo "Creating distribution"
./activator dist
# Extract distrubution zip into /opt/target
echo "Staging into /opt/target"
find target -type f -name *.zip -exec unzip -d /opt/target {} \;
# Link current path to unzip directory
echo "Linking into /opt/target/current"
cd /opt/target
find . -maxdepth 1 -type d ! -name '.' -exec ln -s {} current \;
rm -Rf /opt/target/current/share
# Link /opt/target/current/bin/app to startup script
echo "Staging startup script"
cd /opt/target/current/bin
find . -type f ! -name '*.bat' -exec mv {} start \;
# Create dockerfile
echo "Writing Dockerfile"
cd /opt/target
cat > Dockerfile <<EOF
FROM brickx/activator

RUN mkdir /opt/play
ADD . /opt/play
ENV CONFIG_FILE application.conf
CMD /opt/play/current/bin/start -Dconfig.resource=\$CONFIG_FILE \$OPTIONS
EOF
echo "Building final docker image ${IMAGE_NAME} using Dockerfile"
echo "-----"
cat Dockerfile
echo "-----"  
docker build --rm=true $BUILD_OPTIONS -t $IMAGE_NAME . 
