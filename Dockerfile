FROM ubuntu:16.04
MAINTAINER Sylvain <stherien@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV USER ubuntu
ENV HOME /home/$USER

# Create new user for vnc login.
RUN adduser $USER --disabled-password

# Install Ubuntu Unity.
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ubuntu-desktop \
        unity-lens-applications \
        gnome-panel \
        metacity \
        nautilus \
        gedit \
        xterm \
        putty \
        sudo

# Install dependency components.
RUN apt-get install -y \
        supervisor \
        net-tools \
        curl \
        git \
        pwgen \
        libtasn1-3-bin \
        libglu1-mesa

# Add various tools
RUN add-apt-repository ppa:webupd8team/atom \
    && apt-get update \ 
    && apt-get install -y \
        atom \
        libxss1 \
        terminator \
        vim \
        wget

# Copy Opera repository for apt-get
COPY opera.list /etc/apt/sources.list.d/

# Add Firefox and Opera
RUN wget -O - http://deb.opera.com/archive.key | apt-key add - \
    && apt-get update \
    && apt-get install -y \
        firefox \
        opera-stable

# Add Network-Automation Application part 1
RUN apt-get update \
    && apt-get install -y \
        build-essential \
        libssl-dev libffi-dev \
        python-pip \
    && apt-get autoclean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*

# Add Network-Automation Application part 1
RUN pip install  \
        cryptography

# Add Network-Automation Application part 2
RUN pip install --upgrade pip

# Add Network-Automation Application part 3
RUN pip install  \
        paramiko \
        netmiko \
        napalm \
        ansible

# Copy tigerVNC binaries
ADD tigervnc-1.8.0.x86_64 /

# Clone noVNC.
RUN git clone https://github.com/novnc/noVNC.git $HOME/noVNC

# Clone websockify for noVNC
Run git clone https://github.com/kanaka/websockify $HOME/noVNC/utils/websockify

# Copy supervisor config
COPY supervisor.conf /etc/supervisor/conf.d/

# Set xsession of Unity
COPY xsession $HOME/.xsession

# Copy startup script
COPY startup.sh $HOME

# Copy Unity background
COPY AUD.png $HOME

EXPOSE 6080 5901 4040
CMD ["/bin/bash", "/home/ubuntu/startup.sh"]
