FROM openjdk:8-alpine

RUN apk add --no-cache curl tar bash procps unzip

# install maven
ARG MAVEN_VERSION=3.6.3
ARG USER_HOME_DIR="/root"
ARG SHA=c35a1803a6e70a126e80b2b3ae33eed961f83ed74d18fcd16909b2d44d7dada3203f1ffe726c17ef8dcca2dcaa9fca676987befeadc9b9f759967a8cb77181c0
ARG BASE_URL=https://apache.osuosl.org/maven/maven-3/${MAVEN_VERSION}/binaries

RUN mkdir -p /usr/share/maven /usr/share/maven/ref \
  && curl -fsSL -o /tmp/apache-maven.tar.gz ${BASE_URL}/apache-maven-${MAVEN_VERSION}-bin.tar.gz \
  && echo "${SHA}  /tmp/apache-maven.tar.gz" | sha512sum -c - \
  && tar -xzf /tmp/apache-maven.tar.gz -C /usr/share/maven --strip-components=1 \
  && rm -f /tmp/apache-maven.tar.gz \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

# install gradle
ARG GRADLE_VERSION=4.8.1
ARG GRADLE_URL=https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip
ARG GRADLE_SHA=af334d994b5e69e439ab55b5d2b7d086da5ea6763d78054f49f147b06370ed71
RUN mkdir -p /usr/share/gradle \
  && curl -fsSL -o /tmp/gradle.zip ${GRADLE_URL} \
  && echo "${GRADLE_SHA}  /tmp/gradle.zip" | sha256sum -c - \
  && unzip -d /usr/share/gradle /tmp/gradle.zip \
  && rm -f /tmp/gradle.zip \
  && ln -s /usr/share/gradle/gradle-4.8.1/bin/gradle /usr/bin/gradle

ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"
ENV GRADLE_USER_HOME /usr/share/gradle

COPY mvn-entrypoint.sh /usr/local/bin/mvn-entrypoint.sh
COPY settings-docker.xml /usr/share/maven/ref/

# build actus-core
COPY ./actus-core /app/actus-core
WORKDIR /app/actus-core

RUN /usr/local/bin/mvn-entrypoint.sh \\
  && mvn clean install "-Dmaven.test.failure.ignore=true"

# build actus-webapp
COPY ./actus-webapp /app/actus-webapp
COPY application.properties /app/actus-webapp/src/main/resources/application.properties
WORKDIR /app/actus-webapp

RUN rm -rf ./src/main/resources/static && gradle build
