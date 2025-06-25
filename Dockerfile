FROM jenkins/jenkins:latest

USER root



### Install lsb ###

RUN apt-get update && apt-get install -y lsb-release

### Install lsb ###



### Install dotnet ###

# Download the Microsoft keys
RUN apt-get install -y gpg wget
RUN wget https://packages.microsoft.com/keys/microsoft.asc
RUN cat microsoft.asc | gpg --dearmor -o microsoft.asc.gpg

# Add the Microsoft repository to the system's sources list
RUN wget https://packages.microsoft.com/config/debian/12/prod.list
RUN  mv prod.list /etc/apt/sources.list.d/microsoft-prod.list

# Move the key to the appropriate place
RUN  mv microsoft.asc.gpg $(cat /etc/apt/sources.list.d/microsoft-prod.list | grep -oP "(?<=signed-by=).*(?=\])")

RUN apt-get update && apt-get install -y dotnet-sdk-9.0

### Install dotnet ###



### Install docker ###

RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
    https://download.docker.com/linux/debian/gpg

RUN echo "deb [arch=$(dpkg --print-architecture) \
    signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
    https://download.docker.com/linux/debian \
    $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
RUN apt-get update && apt-get install -y docker-ce-cli

### Install docker ###



USER jenkins

RUN jenkins-plugin-cli --plugins "blueocean docker-workflow json-path-api"
