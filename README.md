# C9SDK with Docker

This repository contains a Dockerized version of the C9SDK, running on top of Ubuntu 18.04 base image. 


## Quick Start for Less Technical Users

For those who wish to use this fast, we already have an image built and deployed on AWS's Elastic Container Registry (ECR). You can use this directly with the following docker-compose setup:

```yaml
services:
  c9sdk:
    image: public.ecr.aws/f3w7h7x2/c9sdk
    container_name: c9sdk
    environment:
       C9USER:
       C9PASSWORD:
    ports:
      - 8002:8080
    volumes:
      - ./test:/workspace
```

Just fill up the `C9USER` and `C9PASSWORD` with your own credentials and run `docker-compose up` command.

## How to Use for Advanced Users

1. Clone the repository: `git clone https://github.com/aformusatii/docker-c9sdk.git c9sdk`
2. Move to the repository directory: `cd c9sdk`
3. Create your own `.env` file using `.env.example` as a template.
4. Build the docker image: `docker-compose build`
5. Start the service: `docker-compose up`

# Description (generated with AI...)
The Docker container is configured to create a `c9user` in a group also named as `c9user` with uid/gid of 1000. The user has password-less sudo permissions and is assigned a /home directory. 

Additionally, a workspace directory is created at path `/workspace` and the ownership is granted to `c9user`. This directory is also exposed as a volume from this Docker image.

Node.js v12.18.4 is installed in this Docker image and the C9SDK is cloned from github. The c9sdk is installed under the directory `/home/c9user/c9sdk`.

The Docker image's entrypoint is configured to use node to execute server.js script in c9sdk, using port 8080 and /workspace directory. The path also includes a scripts directory under /workspace and a bin directory in the node install.

This project includes Docker Compose for defining and running multi-container docker applications and also the `.env.example` file. Use this as a reference to create your own `.env` specifying your c9 username and password.

This repository includes the CI/CD pipelines using GitHub Actions for building the Docker image and pushing it to AWS ECR registry, tagging the next semver version, pushing docker image and then creating a GitHub release with this version.

## Contributing

We welcome your contributions! Please submit a pull request or create an issue if you want to contribute to this project.

## License

This project is open sourced under the MIT license.