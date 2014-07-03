FROM ubuntu:13.10
MAINTAINER Torkale <torkale [at] gmail.com>

RUN apt-get update
RUN apt-get -y install wget git curl git-core openssh-server ruby ruby-dev ruby-bundler

RUN apt-get install -q -y openjdk-7-jre-headless

RUN echo "deb http://pkg.jenkins-ci.org/debian binary/" > /etc/apt/sources.list.d/jenkins.list
RUN wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | apt-key add -
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y jenkins

RUN apt-get clean -y

VOLUME /var/lib/jenkins
ENV JENKINS_HOME /var/lib/jenkins

# Use bash, not dash
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN gem install bundler rake
RUN gem install capistrano -v 3.2.1

RUN mkdir /var/run/sshd

RUN echo " ForwardAgent yes" >> /etc/ssh/ssh_config
RUN echo " IdentityFile /var/lib/jenkins/.ssh/id_rsa" >> /etc/ssh/ssh_config
RUN echo " StrictHostKeyChecking no" >> /etc/ssh/ssh_config

EXPOSE 8080

ADD run /usr/local/bin/run
RUN chmod +x /usr/local/bin/run

CMD ["/usr/local/bin/run"]

