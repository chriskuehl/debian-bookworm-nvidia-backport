#!/bin/bash
set -euxo pipefail

perform_build() {
    dpkg-checkbuilddeps
    time debuild -us -uc -b
    cp -v ../*.deb /dist
}

cp -r /source /tmp/work

cd /tmp/work/nvidia-modprobe
perform_build

cd /tmp/work/nvidia-graphics-drivers
perform_build
