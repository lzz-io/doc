#!/bin/bash
set -e

export JAVA_VERSION=8u152
export JAVA_HOME=/usr/java/default
export DOWNLOAD_URL="http://download.oracle.com/otn-pub/java/jdk/8u152-b16/aa0333dd3019491ca4f6ddbe78cdb6d0/jdk-8u152-linux-x64.rpm"

wget --no-check-certificate --no-cookies \
		--header "Cookie: oraclelicense=accept-securebackup-cookie" \
		-O /opt/jdk.rpm ${DOWNLOAD_URL}; \

export JIRA_VERSION=7.5.1
export DOWNLOAD_URL=https://www.atlassian.com/software/jira/downloads/binary/atlassian-jira-software-${JIRA_VERSION}.tar.gz

wget -O /opt/jira-software.tar.gz ${DOWNLOAD_URL}; \
