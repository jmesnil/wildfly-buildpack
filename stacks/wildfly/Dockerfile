FROM adoptopenjdk:11-jdk as base

ENV CNB_USER_ID=1000
ENV CNB_GROUP_ID=1000
ENV CNB_STACK_ID="org.wildfly.stacks.base"
LABEL io.buildpacks.stack.id="org.wildfly.stacks.base"

RUN groupadd -r jboss -g ${CNB_GROUP_ID} && useradd -u ${CNB_USER_ID} -r -g jboss -m -d /opt/jboss -s /sbin/nologin -c "JBoss user" jboss && \
    chmod 755 /opt/jboss

# Set the working directory to jboss' user home directory
WORKDIR /opt/jboss

FROM base as run

#ENV WILDFLY_VERSION 23.0.0.Final
#ENV WILDFLY_SHA1 b06fab856140226dc499855f324c3e134517455f
#ENV JBOSS_HOME /opt/jboss/wildfly

# Add the WildFly distribution to /opt, and make wildfly the owner of the extracted tar content
# Make sure the distribution is available from a well-known place
#RUN cd $HOME \
#    && curl -O https://download.jboss.org/wildfly/$WILDFLY_VERSION/wildfly-$WILDFLY_VERSION.tar.gz \
#    && sha1sum wildfly-$WILDFLY_VERSION.tar.gz | grep $WILDFLY_SHA1 \
#    && tar xf wildfly-$WILDFLY_VERSION.tar.gz \
#    && mv $HOME/wildfly-$WILDFLY_VERSION $JBOSS_HOME \
#    && rm wildfly-$WILDFLY_VERSION.tar.gz \
#    && chown -R jboss:0 ${JBOSS_HOME} \
#    && chmod -R g+rw ${JBOSS_HOME}

ENV LAUNCH_JBOSS_IN_BACKGROUND true

USER jboss

# Expose the ports we're interested in
EXPOSE 8080

FROM base as build

ENV BASE_URL=https://apache.osuosl.org/maven/maven-3/3.6.3/binaries
ENV MAVEN_VERSION=3.6.3
ENV SHA=26ad91d751b3a9a53087aefa743f4e16a17741d3915b219cf74112bf87a438c5

RUN mkdir -p /usr/share/maven \
    && curl -Lso  /tmp/maven.tar.gz ${BASE_URL}/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
    && echo "${SHA}  /tmp/maven.tar.gz" | sha256sum -c - \
    && tar -xzC /usr/share/maven --strip-components=1 -f /tmp/maven.tar.gz \
    && rm -v /tmp/maven.tar.gz \
    && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

RUN  apt-get -y update \
     && apt-get -y autoremove \
     && apt-get clean \
     && apt-get install -y unzip

ENV GALLEON_VERSION 4.2.8.Final
ENV GALLEON_HOME /opt/jboss/galleon

RUN cd $HOME \
    && curl -LsO https://github.com/wildfly/galleon/releases/download/${GALLEON_VERSION}/galleon-${GALLEON_VERSION}.zip \
    && unzip galleon-${GALLEON_VERSION}.zip \
    && mv $HOME/galleon-${GALLEON_VERSION} ${GALLEON_HOME} \
    && chown -R jboss:0 ${GALLEON_HOME} \
    && chmod -R g+rw ${GALLEON_HOME}

USER jboss