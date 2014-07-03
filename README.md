docker-jenkins
==============

Jenkins in a Docker container; based on Ubuntu 13.10.

Allows capistrano 3 deployment scripts.

It comes with the following plugins:

 * hipchat.hpi
 * greenballs.hpi
 * credentials.hpi
 * ssh-credentials.hpi
 * ssh-agent.hpi
 * git-client.hpi
 * git.hpi
 * github.hpi
 * github-api.hpi
 * ghprb.hpi
 * github-oauth.hpi
 * scm-api.hpi
 * postbuild-task.hpi

Usage
-----

    docker run -d -t torkale/jenkins

Building
--------

Grab Dockerfile from this repository on Github

    docker build github.com/torkale/docker-jenkins

Get a Docker image from Docker index

    docker pull torkale/jenkins


