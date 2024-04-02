FROM ubuntu:18.04

ARG user=c9user
ARG group=c9user

ARG uid=1000
ARG gid=1000

# Update the package list, install sudo, create a non-root user, and grant password-less sudo permissions
RUN set -eux && \
    apt update -y && \
    apt install -y sudo wget curl apt-utils xz-utils wget curl git python2.7 make gcc locales && \
    locale-gen en_US.UTF-8 && \
    addgroup --gid $gid $group && \
    adduser --uid $uid --gid $gid --home /home/$user --disabled-password --gecos "" $user && \
    echo $user' ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers && \
    mkdir /workspace && \
    chown $user:$group /workspace

VOLUME /workspace

USER $user
WORKDIR /home/$user

RUN cd /home/$user; \
    wget https://nodejs.org/dist/v12.18.4/node-v12.18.4-linux-x64.tar.xz; \
    xz -d node-v12.18.4-linux-x64.tar.xz; \
    tar -xvf node-v12.18.4-linux-x64.tar; \
    rm node-v12.18.4-linux-x64.tar; \
    git clone https://github.com/c9/core.git c9sdk; \
    cd c9sdk; \
    PATH=$PATH:/home/$user/node-v12.18.4-linux-x64/bin bash ./scripts/install-sdk.sh

# RUN ssh-keygen -f $HOME/.ssh/id_rsa -t rsa -N ''

WORKDIR /home/$user/c9sdk

ENV BUILD_USER=$user

#ENTRYPOINT ["tail", "-f", "/dev/null"]
ENTRYPOINT ["/bin/sh", "-c", "PATH=$PATH:/workspace/scripts:/home/$BUILD_USER/node-v12.18.4-linux-x64/bin; node server.js -p 8080 -w /workspace -l 0.0.0.0 -a $C9USER:$C9PASSWORD"]
