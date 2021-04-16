docker build stacks/wildfly -t wildfly/wildfly-build:latest --target build
docker build stacks/wildfly -t wildfly/wildfly-run:latest --target run
pack builder create wildfly/wildfly:latest --config ./builder.toml