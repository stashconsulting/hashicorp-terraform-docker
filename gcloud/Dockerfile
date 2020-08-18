FROM gcr.io/cloud-builders/docker:19.03.8

WORKDIR /workspace/

RUN  apt-get update \
  && apt-get install -y wget unzip\
  && rm -rf /var/lib/apt/lists/*

RUN wget -q https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-293.0.0-linux-x86_64.tar.gz \ 
   && tar -zxvf google-cloud-sdk-293.0.0-linux-x86_64.tar.gz \
   && ./google-cloud-sdk/install.sh --path-update=true

ENV PATH $PATH:/workspace/google-cloud-sdk/bin

RUN gcloud --quiet components update

RUN wget -q  https://releases.hashicorp.com/terraform/0.12.18/terraform_0.12.18_linux_amd64.zip -O terraform.zip \
   && unzip terraform.zip \
   && mv terraform /usr/local/bin

ENTRYPOINT ["/bin/bash", "-c"]
