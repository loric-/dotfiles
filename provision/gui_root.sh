#/bin/sh
#
# this should be run as root

set -e

# rescan package index files
apt-get update

# Install i3 gaps dependencies
apt-get install -y \
    libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev \
    libxcb-util0-dev libxcb-icccm4-dev libyajl-dev \
    libstartup-notification0-dev libxcb-randr0-dev \
    libev-dev libxcb-cursor-dev libxcb-xinerama0-dev \
    libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev \
    autoconf libxcb-xrm0 libxcb-xrm-dev automake libxcb-shape0-dev

# Install i3
cd $HOME
rm -rf i3-gaps

# clone the repository
git clone https://www.github.com/Airblader/i3 i3-gaps
cd i3-gaps

# compile & install
autoreconf --force --install
rm -rf build/
mkdir -p build && cd build/

# Disabling sanitizers is important for release versions!
# The prefix and sysconfdir are, obviously, dependent on the distribution.
../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
make
make install
cd $HOME

# Install i3 python dependencies
pip install i3-py
pip2 install i3-py

# Install i3 status
apt-get install -y i3status

# Install i3 lock
apt-get install -y i3lock scrot imagemagick xautolock

# Install rofi
add-apt-repository -y ppa:jasonpleau/rofi
apt-get update
apt-get install -y rofi

# Install dunst
apt-get install -y dunst

# Install other tools
apt-get install -y \
    compton \
    lxappearance \
    nitrogen \
    feh \
    arandr \
    xclip \
    gsimplecal \
    pavucontrol \
    dconf-editor

# Install xflux
add-apt-repository -y ppa:nathan-renniewaldock/flux
apt-get update
apt-get install -y fluxgui

# Install greenclip
rm -rf /usr/local/bin/greenclip
wget https://github.com/erebe/greenclip/releases/download/3.0/greenclip
chmod +x greenclip
mv greenclip /usr/local/bin/greenclip

# Install playerctl
wget https://github.com/acrisci/playerctl/releases/download/v0.6.1/playerctl-0.6.1_amd64.deb
DEBIAN_FRONTEND=noninteractive dpkg -i playerctl-0.6.1_amd64.deb
rm -rf playerctl*

# Install arc-theme
add-apt-repository -y ppa:noobslab/themes
add-apt-repository -y ppa:noobslab/icons
apt-get update
apt-get install -y arc-theme arc-icons

# Install polybar
apt-get install -y \
    cmake \
    cmake-data \
    pkg-config \
    libcairo2-dev \
    libxcb1-dev \
    libxcb-util0-dev \
    libxcb-randr0-dev \
    libxcb-composite0-dev \
    python-xcbgen \
    xcb-proto \
    libxcb-image0-dev \
    libxcb-ewmh-dev \
    libxcb-icccm4-dev \
    libxcb-xkb-dev \
    libxcb-xrm-dev \
    libxcb-cursor-dev \
    libasound2-dev \
    libpulse-dev \
    libjsoncpp-dev \
    libmpdclient-dev \
    libcurl4-openssl-dev \
    libiw-dev \
    libnl-3-dev

cd $HOME
rm -rf polybar
git clone --recursive https://github.com/jaagr/polybar
mkdir polybar/build
cd polybar/build
cmake ..
make install
cd $HOME

# Install xcwd
cd $HOME
git clone https://github.com/schischi/xcwd.git
cd xcwd
make
make install
cd $HOME

# Install chrome
apt-get install -y xdg-utils fonts-liberation
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
DEBIAN_FRONTEND=noninteractive dpkg -i google-chrome-stable_current_amd64.deb
rm -rf google-chrome-stable*

# Install pantheon-files
add-apt-repository -y ppa:elementary-os/daily
apt-get update
apt-get install -y pantheon-files
ln -sf /usr/bin/io.elementary.files /usr/bin/pantheon-files

# Custom repos for apps
add-apt-repository -y ppa:peek-developers/stable
apt-get update

# Install debian apps
apt-get install -y \
    filezilla \
    firefox \
    gnome-control-center \
    kazam \
    libreoffice \
    meld \
    peek \
    pinta \
    remmina \
    rxvt-unicode-256color \
    shutter \
    snapd \
    wmctrl

# Delete apt cache
apt-get clean
rm -rf /var/crash/*
rm -rf /var/cache/*
