FROM jenkins/jenkins:jdk11
LABEL Paulo Roberto Mesquita da Silva <nagpaulo@gmail.com>

USER root
RUN apt-get update && apt-get install -y apt-transport-https \
       ca-certificates curl gnupg2 \
       software-properties-common
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN apt-key fingerprint 0EBFCD88
RUN add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/debian \
       $(lsb_release -cs) stable"
RUN apt-get update && apt-get install -y docker-ce-cli
# RUN mkdir /srv/backup && 
RUN chown jenkins:jenkins /srv/backup
RUN apt-get update
RUN apt-get install -y python

USER jenkins

# test
RUN python --version

#JAVA_HOME = /opt/java/openjdk

# install Jenkins plugins from file
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
