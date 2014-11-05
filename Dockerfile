FROM ubuntu:14.04
# Forked from MAINTAINER Torkale <torkale [at] gmail.com>
MAINTAINER Nicholas Iaquinto <nickiaq@gmail.com>

# In case someone loses the Dockerfile
RUN rm -rf /etc/Dockerfile
ADD Dockerfile /etc/Dockerfile

# Because Ubuntu/Debian
ENV DEBIAN_FRONTEND noninteractive 

# Install Depends
RUN apt-get update && \
    apt-get -y install wget git curl git-core openssh-server openjdk-7-jre-headless

# Install Jenkins and Clean up
RUN echo "deb http://pkg.jenkins-ci.org/debian binary/" > /etc/apt/sources.list.d/jenkins.list && \
    wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | apt-key add - && \
    apt-get update && \
    apt-get install -y jenkins && \
    apt-get clean -y && \
    rm /bin/sh && ln -s /bin/bash /bin/sh

# Need SSH
RUN mkdir /var/run/sshd && \
    echo " ForwardAgent yes" >> /etc/ssh/ssh_config && \
    echo " IdentityFile /var/lib/jenkins/.ssh/id_rsa" >> /etc/ssh/ssh_config && \
    echo " StrictHostKeyChecking no" >> /etc/ssh/ssh_config

# Expose volume and set jenkins-y things
VOLUME /var/lib/jenkins
ENV JENKINS_HOME /var/lib/jenkins

EXPOSE 8080

ADD run /usr/local/bin/run
RUN chmod +x /usr/local/bin/run

CMD ["/usr/local/bin/run"]
