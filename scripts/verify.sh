#!/usr/bin/env bash
set -euo pipefail

ok()   { printf "%-28s %s\n" "$1" "OK"; }
warn() { printf "%-28s %s\n" "$1" "WARN"; }
err()  { printf "%-28s %s\n" "$1" "ERROR"; }

echo "== Compilers =="
gcc_v=$(gcc -dumpfullversion -dumpversion || echo "0")
gpp_v=$(g++ -dumpfullversion -dumpversion || echo "0")
clang_v=$(clang --version | awk 'NR==1{print $4}' || echo "0")

ver_ge() {
  dpkg --compare-versions "$1" ge "$2"
}

ver_ge "$gcc_v" "11"  && ok "gcc >= 11 (found $gcc_v)"   || err "gcc >= 11 required (found $gcc_v)"
ver_ge "$gpp_v" "11"  && ok "g++ >= 11 (found $gpp_v)"   || err "g++ >= 11 required (found $gpp_v)"
ver_ge "$clang_v" "14" && ok "clang >= 14 (found $clang_v)" || warn "clang >= 14 recommended (found $clang_v)"

echo -e "\n== CMake & Ninja =="
cmake_v=$(cmake --version | awk '/version/{print $3}')
ninja_v=$(ninja --version)
ver_ge "$cmake_v" "3.21" && ok "cmake >= 3.21 (found $cmake_v)" || err "cmake >= 3.21 required (found $cmake_v)"
ver_ge "$ninja_v" "1.10" && ok "ninja >= 1.10 (found $ninja_v)" || err "ninja >= 1.10 required (found $ninja_v)"

echo -e "\n== Qt6 Install =="
if [ -n "${QT_ROOT_DIR:-}" ] && [ -d "$QT_ROOT_DIR" ]; then
  [ -f "$QT_ROOT_DIR/lib/cmake/Qt6/Qt6Config.cmake" ] && ok "Qt6Config.cmake" || err "Qt6Config.cmake"
  [ -x "$QT_ROOT_DIR/bin/qmake6" ] && ok "qmake6" || err "qmake6"
  [ -d "$QT_ROOT_DIR/qml/QtQuick" ] && ok "QtQuick" || err "QtQuick"
  [ -d "$QT_ROOT_DIR/qml/QtQuick/Controls" ] && ok "QtQuick Controls2" || err "QtQuick Controls2"
  [ -d "$QT_ROOT_DIR/qml/QtQuick3D" ] && ok "QtQuick3D" || err "QtQuick3D"
else
  err "QT_ROOT_DIR non défini"
fi


echo -e "\n== GTest & cppcheck =="
dpkg -s libgtest-dev &>/dev/null && ok "libgtest-dev" || err "libgtest-dev"
cppv=$(cppcheck --version | awk '{print $2}')
ver_ge "$cppv" "2.10" && ok "cppcheck >= 2.10 (found $cppv)" || warn "cppcheck >= 2.10 recommended (found $cppv)"
