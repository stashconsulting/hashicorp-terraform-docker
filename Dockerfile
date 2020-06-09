FROM gcr.io/cloud-builders/docker

WORKDIR /workspace/

RUN  apt-get update \
  && apt-get install -y wget unzip \
  && rm -rf /var/lib/apt/lists/*

RUN wget -q  https://releases.hashicorp.com/terraform/0.12.18/terraform_0.12.18_linux_amd64.zip -O terraform.zip

RUN unzip terraform.zip

RUN mv terraform /usr/local/bin

ENTRYPOINT [ "terraform" ]