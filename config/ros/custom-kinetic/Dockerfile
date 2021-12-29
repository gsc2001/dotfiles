FROM nvidia/cudagl:9.0-base-ubuntu16.04

ENV UBUNTU_RELEASE=xenial
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $UBUNTU_RELEASE main" > /etc/apt/sources.list.d/ros-latest.list'
RUN apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

RUN apt-get update && apt-get install -y \
    ros-kinetic-desktop-full \
 && rm -rf /var/lib/apt/lists/*

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES=all
#    ${NVIDIA_DRIVER_CAPABILITIES:$NVIDIA_DRIVER_CAPABILITIES,}graphics

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y ssh zsh vim-gtk git \
    && apt-get clean


# Ceres install
# deps
RUN apt-get install -y cmake libgoogle-glog-dev libgflags-dev libatlas-base-dev libeigen3-dev libsuitesparse-dev

RUN useradd -m user && yes password | passwd user
RUN usermod -s /bin/zsh user
RUN usermod -aG sudo user

RUN mkdir -p /home/user/installations && cd /home/user/installations
WORKDIR /home/user/installations
COPY --chown=root:root ceres-solver-2.0.0.tar.gz .
#RUN tar zxf ceres-solver-2.0.0.tar.gz \
#    && mkdir ceres-bin \
#    && cd ceres-bin \
#    && cmake ../ceres-solver-2.0.0 -DBUILD_EXAMPLES=OFF\
#    && make -j6 \
#    && make test \
#    && make install

# Setup SSH for clion
RUN ( \
    echo 'LogLevel DEBUG2'; \
    echo 'PermitRootLogin yes'; \
    echo 'PasswordAuthentication yes'; \
    echo 'Subsystem sftp /usr/lib/openssh/sftp-server'; \
    echo 'X11Forwarding yes'; \
    echo 'AddressFamily inet'; \
  ) > /etc/ssh/sshd_config_test_clion \
  && mkdir /run/sshd


WORKDIR /home/user
COPY --chown=user:user .zshrc .
COPY --chown=user:user .aliases .
COPY --chown=user:user .oh-my-zsh/ .oh-my-zsh
COPY --chown=user:user .p10k.zsh .


CMD ["/usr/sbin/sshd", "-D", "-e", "-f", "/etc/ssh/sshd_config_test_clion"]

