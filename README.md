# terraform-docker
Integration between Terraform and Docker.

This project is intended for people who want to build their docker images from terraform.

## Some advise
Now the latest version images will come by default with Terraform v0.13.0 or higher for the correct operation of the command `terraform login`.

Some previous versions of the images remain available on Docker Hub with their respective tags.
> Terraform v0.12.18
* [terraform-docker:entrypoint](https://hub.docker.com/layers/stashconsulting/terraform-docker/entrypoint-d279264/images/sha256-6b677b94011b75c7442ce7b96650c1553fe15fef766f0ca09011a33dcca2fe39?context=repo), released on 18 August 2020.
* [terraform-docker:standard](https://hub.docker.com/layers/stashconsulting/terraform-docker/standard-d279264/images/sha256-7a7cc0d703bdfdbc29444befe8e4083c5578f9ce2d5740e51705a87c9db3cbe1?context=repo), released on 18 August 2020.
* [terraform-docker:gcloud](https://hub.docker.com/layers/stashconsulting/terraform-docker/gcloud-d279264/images/sha256-189ffac5d02f0780936371680bdf3bfe4b5de08b9c04c7eb4fe6790ae2592d75?context=repo), released on 18 August 2020.


## Getting Started

### Usage

Here is a simple example of `main.tf` file that build an image named `test:latest` 
based on the Dockerfile specification. 

```
locals {
  region  = "my-region"
  zone    = "my-zone"
  project  = var.project
}

# Specify the GCP Provider
provider "google" {
  project  = local.project
  region   = local.region
  zone     = local.zone
}

# local-exec for building the docker image
resource "null_resource" "building_docker_image" {
  triggers = {
    image_id = var.image_id
  }
  provisioner "local-exec" {
    command = <<EOF
      docker build -t test:latest .
    EOF
  }
}
```

> When you use `null_resource` changing something to the command does not trigger the re-execution if the command worked and the first place. To solve this problem we have to change the identifier or change the image value.

```
# local-exec for building the docker image
resource "null_resource" "building_docker_image" {
  triggers = {
    image_id = var.image_id
  }
  provisioner "local-exec" {
    command = <<EOF
      docker build -t test:latest .
    EOF
  }
}
```


Here is a simple example of variables.tf file, you can specify another image value changing the default value or running the following command `terraform apply -auto-approve -var image_id=kong_dbless`

```
variable "image_id" {
    type = string
    default = "test"
}
```

### Steps to use the entrypoint version
> Only accepts terraform commands

You have to create a [Docker volume](https://docs.docker.com/engine/reference/commandline/volume_create/) to store the files that we will use to build the container. Let run init for terraform first.

```
docker run -it -v $(pwd)/:/workpace -w /workpace stashconsulting/terraform-docker:entrypoint-latest init
```

Then we have to mount [docker socket](https://stackoverflow.com/questions/36185035/how-to-mount-docker-socket-as-volume-in-docker-container-with-correct-group) as volume in docker container. 

```
docker run -it -v $(pwd)/:/workpace -w /workpace -v /var/run/docker.sock:/var/run/docker.sock 
 stashconsulting/terraform-docker:entrypoint-latest apply -auto-approve
```

### Steps to use the standard version
> You can run bash based in ubuntu and terraform commands

Run init

```
docker run -it -v $(pwd)/:/workpace -w /workpace stashconsulting/terraform-docker:standard-latest "terraform init"
```

Run apply

```
docker run -it -v $(pwd)/:/workpace -w /workpace -v /var/run/docker.sock:/var/run/docker.sock 
 stashconsulting/terraform-docker:standard-latest "terraform apply -auto-approve"
```
Another  example
```
docker run -it -v $(pwd)/:/workpace -w /workpace stashconsulting/terraform-docker:standard-latest "ls"
```

### Steps to use the gcloud version
> You can run bash based in ubuntu, terraform and gcloud commands.

Example
```
docker run -it -v $(pwd)/:/workpace -w /workpace stashconsulting/terraform-docker:gcloud-latest "gcloud init"
```

### Cloud Build

Here is a simple example of `cloudbuil.yaml` file that invokes the `terraform-docker` image to execute your tasks.

```
- name: 'gcr.io/project-test-270001/terraform-docker:entrypoint-latest'
  id: init
  args: ['init']
```

## Built With 🛠️

* [Docker 19.03.8](https://docs.docker.com/engine/release-notes/)

## Contributing 🖇️

There are a few ways to contribute to the `terraform-docker` repo. Please read [CONTRIBUTING.md](https://github.com/stashconsulting/terraform-docker/blob/master/CONTRIBUTING.md) for additional information.

## Versioning. 📌

For the versions available, see the [tags on this repository](https://github.com/stashconsulting/terraform-docker/tags).

## Authors ✒️

* **Genesis Alvarez** - *Initial work* - [stashconsulting](https://github.com/stashconsulting)

* **Shailyn Ortiz** - *Maintainer* - [stashconsulting](https://github.com/stashconsulting)

## License 📄

First-class integrations between Terraform and Docker licensed under the Server Side Public License (SSPL). 
Please read the [LICENSE](https://github.com/stashconsulting/terraform-docker/blob/master/LICENSE) file.

## Acknowledgments
This image was born when we wanted to manage the infrastructure with terraform and we required 
to build a docker image for a project but it was not possible because the terraform image does not have docker.

Please tell others about this project. 📢


---

* *The [`gcr.io/cloud-builders/docker`](https://github.com/GoogleCloudPlatform/cloud-builders/tree/master/docker) image that we used as base to create the `terraform-docker` image is maintained by 
the Cloud Build team.*

---
⌨️ with ❤️ by [Alvarez](https://github.com/UsernameAlvarez)
