export DEBIAN_FRONTEND=noninteractive

sudo apt-get update
sudo apt-get install -y \
  curl \
  synaptic \
  libxcb-icccm4 \
  libxcb-image0 \
  libxcb-keysyms1 \
  libxcb-render-util0 \
  libxcb-xinerama0 \
  libxcb-xkb1 \
  libxkbcommon-x11-0 \
  build-essential cmake ninja-build pkg-config \
  libgl1-mesa-dev libglu1-mesa-dev \
  libegl1-mesa-dev libgles2-mesa-dev \
  libx11-dev libxext-dev libxrender-dev libxkbcommon-dev \
  locales \
  cppcheck

locale-gen C.UTF-8 || true
export LANG=C.UTF-8
export LC_ALL=C.UTF-8
export QT_QPA_PLATFORM=offscreen

curl -O https://download.qt.io/official_releases/online_installers/qt-online-installer-linux-x64-online.run
cat qt-online-installer-linux-x64-online.run | grep -oe "href=\".*\"" | awk -F\" '{system("curl -O " $2)}'

rm qt-online-installer-linux-x64-online.run

chmod +x qt-online-installer-linux*

: "${QT_EMAIL:?Set QT_EMAIL in env}"
: "${QT_PASSWORD:?Set QT_PASSWORD in env}"

./qt-online-installer-linux* \
  --email "$QT_EMAIL" \
  --pw "$QT_PASSWORD" \
  --accept-licenses \
  --accept-obligations \
  --default-answer \
  --confirm-command \
  install qt6.9.1-sdk

QT_PREFIX="$(dirname "$(dirname "$(find "$QT_BASE" -type f -name 'Qt6Config.cmake' -print -quit)")")"
[ -n "$QT_PREFIX" ] || QT_PREFIX="$QT_BASE/6.9.1/gcc_64"

export QT_QPA_PLATFORM=offscreen
export QT_ROOT_DIR="$QT_PREFIX"
export PATH="$QT_ROOT_DIR/bin:$PATH"
export CMAKE_PREFIX_PATH="$QT_ROOT_DIR:${CMAKE_PREFIX_PATH:-}"

"$QT_ROOT_DIR/bin/qmake6" -v || "$QT_ROOT_DIR/bin/qmake" -v || true
echo "Qt prefix: $QT_ROOT_DIR"

echo "QT_ROOT_DIR=$QT_PREFIX" >> "$GITHUB_ENV"
echo "CMAKE_PREFIX_PATH=$QT_PREFIX:${CMAKE_PREFIX_PATH:-}" >> "$GITHUB_ENV"
echo "QT_QPA_PLATFORM=offscreen" >> "$GITHUB_ENV"
echo "$QT_PREFIX/bin" >> "$GITHUB_PATH"
