FROM ubuntu:18.04

# Install sudo
RUN apt-get update \
  && apt-get install -y sudo \
  && echo "%sudo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Create user
ENV HOME /home/dev
RUN useradd --create-home --home-dir $HOME dev \
  && chown -R dev:dev $HOME
RUN echo "dev:dev" | chpasswd
RUN usermod -aG sudo dev

# Define current user
USER dev

# Add and run install script
COPY --chown=dev:dev terminal.sh /tmp/terminal.sh
RUN chmod +x /tmp/terminal.sh && ./tmp/terminal.sh && rm /tmp/terminal.sh

# Install docker client
ENV DOCKER_VERSION "18.09.5"
RUN curl -L -o /tmp/docker-$DOCKER_VERSION.tgz https://download.docker.com/linux/static/stable/x86_64/docker-$DOCKER_VERSION.tgz \
    && tar -xz -C /tmp -f /tmp/docker-$DOCKER_VERSION.tgz \
    && chmod +x /tmp/docker/docker \
    && sudo mv /tmp/docker/docker /usr/local/bin \
    && rm -rf /tmp/docker-$DOCKER_VERSION /tmp/docker

# Install docker-compose client
ENV DOCKER_COMPOSE_VERSION "1.22.0"
RUN curl -L -o /tmp/docker-compose https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m) \
    && chmod +x /tmp/docker-compose \
    && sudo mv /tmp/docker-compose /usr/local/bin

# Add user to docker group
RUN sudo groupadd -g 999 docker && sudo usermod -aG docker dev

# Set zsh as default
ENV SHELL=/bin/zsh

# Run dotfiles
RUN mkdir $HOME/.config \
  && git clone https://github.com/loric-/dotfiles.git $HOME/.config/dotfiles
RUN cd $HOME/.config/dotfiles && python3 link.py --only-terminal

# Apply less layout
RUN lesskey

# Install vim plugins
RUN vim +'GoUpdateBinaries' +qa

# Set workdir
WORKDIR $HOME/Lab

# Start zsh by default
ENTRYPOINT ["/bin/zsh"]
