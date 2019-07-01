#!/bin/bash
set -e

# Install ppa
sudo apt-get update \
    && sudo DEBIAN_FRONTEND=noninteractive apt-get install -y software-properties-common \
    && sudo add-apt-repository -y ppa:jonathonf/vim \
    && sudo add-apt-repository -y ppa:git-core/ppa

# Install packages
sudo apt-get update \
    && sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
      acpi \
      ansible \
      autojump \
      ctags \
      curl \
      dos2unix \
      git \
      glances \
      graphviz \
      htop \
      httpie \
      iftop \
      iotop \
      iputils-ping \
      jq \
      man-db \
      mercurial \
      moreutils \
      ncdu \
      net-tools \
      netcat \
      nethogs \
      nload \
      openvpn \
      pv \
      python \
      python-pip \
      python3 \
      python3-pip \
      ranger \
      ssh \
      stress \
      tcpdump \
      telnet \
      tmux \
      traceroute \
      tree \
      tty-clock \
      vim-gtk3 \
      wget \
      wordnet \
      zsh

# Install golang
sudo rm -rf /usr/local/go*
sudo wget https://dl.google.com/go/go1.12.6.linux-amd64.tar.gz \
    && sudo tar -xvf go1.12.6.linux-amd64.tar.gz \
    && sudo mv go /usr/local \
    && sudo rm go*

# Install python packages
sudo pip install \
  speedtest-cli \
  cheat \
  http-prompt \
  --upgrade

sudo pip3 install \
  bpython \
  ipython \
  asciinema \
  --upgrade

# Install shally
sudo rm -rf /usr/local/bin/shally
sudo wget https://raw.githubusercontent.com/lobre/shally/master/shally \
  && sudo chmod +x shally \
  && sudo mv shally /usr/local/bin

# Install Prezto
rm -rf $HOME/.zprezto $HOME/.zlogin $HOME/.zlogout $HOME/.zpreztorc $HOME/.zprofile $HOME/.zshenv $HOME/.zshrc
git clone --recursive https://github.com/sorin-ionescu/prezto.git $HOME/.zprezto \
  && ln -s $HOME/.zprezto/runcoms/zlogin $HOME/.zlogin \
  && ln -s $HOME/.zprezto/runcoms/zlogout $HOME/.zlogout \
  && ln -s $HOME/.zprezto/runcoms/zpreztorc $HOME/.zpreztorc \
  && ln -s $HOME/.zprezto/runcoms/zprofile $HOME/.zprofile \
  && ln -s $HOME/.zprezto/runcoms/zshenv $HOME/.zshenv \
  && ln -s $HOME/.zprezto/runcoms/zshrc $HOME/.zshrc

# Install fzf
rm -rf $HOME/.fzf
git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf \
  && $HOME/.fzf/install --bin

# Install vim-go
git clone https://github.com/fatih/vim-go.git $HOME/.vim/pack/plugins/start/vim-go

# Working dir
if [ ! -d "$HOME/Lab" ]; then
    mkdir $HOME/Lab

    # Create golang workspace paths
    mkdir -p $HOME/Lab/go \
        && mkdir $HOME/Lab/go/bin \
        && mkdir $HOME/Lab/go/pkg \
        && mkdir $HOME/Lab/go/src
fi

# Install golang apps
export GOROOT=/usr/local/go
export GOPATH="$HOME/Lab/go"
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

go get -u github.com/gokcehan/lf
go get -u github.com/sourcegraph/go-langserver
go get -u github.com/jesseduffield/lazygit
go get -u github.com/mkchoi212/fac
#go get -u github.com/wagoodman/dive
