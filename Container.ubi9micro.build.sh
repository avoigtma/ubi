
dnf install -y container-tools

podman pull registry.access.redhat.com/ubi9/ubi-micro
microcontainer=$(buildah from registry.access.redhat.com/ubi9/ubi-micro)
occlicontainer=$(buildah from registry.redhat.io/openshift4/ose-cli-rhel9:v4.17)
micromount=$(buildah mount $microcontainer)
occlimount=$(buildah mount $occlicontainer)

PACKAGES="git jq"

dnf --installroot $micromount --releasever 9 \
    --disablerepo="*" --enablerepo="ubi-9-baseos-rpms" --enablerepo="ubi-9-appstream-rpms" \
    --setopt=install_weak_deps=0 --setopt=tsflags=nodocs \
    install -y ${PACKAGES}

dnf --installroot $micromount --releasever 9 \
    --disablerepo="*" --enablerepo="ubi-9-baseos-rpms" --enablerepo="ubi-9-appstream-rpms" \
    --setopt=install_weak_deps=0 --setopt=tsflags=nodocs \
    upgrade -y

dnf clean all --installroot $micromount

cp $occlimount/usr/bin/oc $micromount/usr/bin/oc
for i in kubectl openshift-deploy openshift-docker-build openshift-sti-build openshift-git-clone openshift-manage-dockerfile openshift-extract-image-content openshift-recycle; do ln -sf $micromount/usr/bin/oc $micromount/usr/bin/$i; done

buildah umount $occlicontainer
buildah umount $microcontainer
buildah commit $microcontainer myubi9micro



