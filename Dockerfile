FROM jenkins/jenkins:2.414.3-jdk11  
USER root

# Install necessary packages
RUN apt-get update && apt-get install -y lsb-release python3-pip

# Add Docker's official GPG key and repository
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
  https://download.docker.com/linux/debian/gpg

RUN echo "deb [arch=$(dpkg --print-architecture) \
  signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
  https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list

# Install Docker CLI
RUN apt-get update && apt-get install -y docker-ce-cli

# Switch back to Jenkins user to run Jenkins plugin installation
USER jenkins

# Install Blue Ocean and Docker Workflow plugins
RUN jenkins-plugin-cli --plugins "blueocean:1.25.3 docker-workflow:1.28"
