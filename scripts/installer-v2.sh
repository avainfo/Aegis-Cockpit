#!/usr/bin/env bash
set -euo pipefail

sudo apt-get update
sudo apt-get install -y \
  python3-pip python3-setuptools python3-wheel \
  build-essential cmake ninja-build ccache \
  libgl1-mesa-dev libegl1-mesa-dev libgles2-mesa-dev \
  libxcb1 libx11-xcb1 libxcb-shape0 libxcb-render0 libxcb-shm0 libxcb-randr0 libxcb-xfixes0

pip3 install --upgrade aqtinstall

aqt install-src linux 6.9.1 -O /opt/Qt
aqt install-tool linux desktop tools_ifw -O /opt/Qt

aqt install-qt linux desktop 6.9.1 linux_gcc_64 -O /opt/Qt \
  -m qtquick3d qtshadertools qtmultimedia qtserialbus qtimageformats qtwebsockets

echo "QT_ROOT_DIR=/opt/Qt/6.9.1/linux_gcc_64" >> "$GITHUB_ENV"
echo "CMAKE_PREFIX_PATH=/opt/Qt/6.9.1/linux_gcc_64" >> "$GITHUB_ENV"
echo "/opt/Qt/6.9.1/linux_gcc_64/bin" >> "$GITHUB_PATH"
echo "QT_QPA_PLATFORM=offscreen" >> "$GITHUB_ENV"
echo "LANG=C.UTF-8" >> "$GITHUB_ENV"
echo "LC_ALL=C.UTF-8" >> "$GITHUB_ENV"
