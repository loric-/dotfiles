FROM ubuntu:18.04

# Add install scripts
COPY provision/term_root.sh /tmp/term_root.sh
COPY provision/term_user.sh /tmp/term_user.sh
COPY provision/create_user.sh /tmp/create_user.sh
RUN chmod +x /tmp/term_root.sh /tmp/term_user.sh /tmp/create_user.sh

# Install apps
RUN /tmp/term_root.sh

# Create dev user
RUN /tmp/create_user.sh dev

# Add user to docker group
RUN usermod -aG docker dev

# Define current user
USER dev
ENV HOME=/home/dev
ENV USER=dev

# Run user script
RUN /tmp/term_user.sh

# Set zsh as default
ENV SHELL=/bin/zsh

# Set workdir
WORKDIR $HOME/Lab

# Start zsh by default
ENTRYPOINT ["/bin/zsh"]
