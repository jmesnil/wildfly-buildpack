docker build stacks/wildfly -t ${REGISTRY}wildfly/wildfly-build:latest --target build
docker build stacks/wildfly -t ${REGISTRY}wildfly/wildfly-run:latest --target run

cat >> ./builder.toml <<EOL
# This image is used at runtime
run-image = "${REGISTRY}wildfly/wildfly-run:latest"
# This image is used at build-time
build-image = "${REGISTRY}wildfly/wildfly-build:latest"
EOL

pack builder create ${REGISTRY}wildfly/wildfly-builder:latest --config ./builder.toml