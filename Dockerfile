FROM ubuntu:latest

RUN apt-get update &&\
    apt-get install -y curl \
    lsb-release \
    gpg \
    unzip

## Install Terraform
# RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/terraform-archive-keyring.gpg &&\
#     echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/terraform-archive-keyring.gpg] https://apt.releases.hashicorp.com \
#     $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/terraform.list > /dev/null &&\
#     apt-get update && apt-get install -y terraform
RUN curl -o terraform_linux_arm64.zip https://releases.hashicorp.com/terraform/1.1.7/terraform_1.1.7_linux_arm64.zip &&\
    unzip terraform_linux_arm64.zip && chmod +x terraform && mv terraform /usr/local/bin/

# ## Install docker-ce-cli
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg &&\
    echo   "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null &&\
    apt-get update &&\
    apt-get install -y docker-ce-cli &&\
    mkdir /root/.docker &&\
    echo export DOCKER_CONFIG=$HOME/.docker > ~/.profile

ENV DOCKER_HOST=tcp://docker:2376 DOCKER_TLS_VERIFY=1 DOCKER_CERT_PATH=/certs/client

