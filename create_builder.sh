docker build stacks/wildfly -t ${REGISTRY}wildfly/wildfly-build:latest --target build
docker build stacks/wildfly -t ${REGISTRY}wildfly/wildfly-run:latest --target run
pack builder create ${REGISTRY}wildfly/wildfly-builder:latest --config ./builder.toml