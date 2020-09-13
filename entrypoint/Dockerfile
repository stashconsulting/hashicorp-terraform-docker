FROM gcr.io/cloud-builders/docker:19.03.8

WORKDIR /workspace/

RUN  apt-get update \
  && apt-get install -y wget unzip \
  && rm -rf /var/lib/apt/lists/*

RUN wget -q  https://releases.hashicorp.com/terraform/0.13.0/terraform_0.13.0_linux_amd64.zip -O terraform.zip

RUN unzip terraform.zip

RUN mv terraform /usr/local/bin

ENTRYPOINT [ "terraform" ]
