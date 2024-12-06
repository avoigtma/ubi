# Sample UBI base image customization

Reference: https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/9/html-single/building_running_and_managing_containers/index#assembly_adding-software-to-a-ubi-container_building-running-and-managing-containers

## UBI9 Image

```shell
podman login registry.redhat.io
podman build -t myubi9 -f Containerfile.ubi9
```

## UBI9-Minimal Image

```shell
podman login registry.redhat.io
podman build -t myubi9mini -f Containerfile.ubi9mini
```

## UBI9-Micro Image

```shell
podman login registry.redhat.io
. ./Container.ubi9micro.build.sh
```


