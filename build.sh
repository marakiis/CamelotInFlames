#! /bin/bash -x


export NAME=camelot

export CURDIR=${PWD}
export DATE=$(date +"%Y-%m-%d_%H-%M-%S")
export SCRIPT_PATH=$(dirname "$0")
export BUILD_DIR=${SCRIPT_PATH}/build


rm -rf build/*

godot --path . --export-release "Linux/X11" "${BUILD_DIR}/${NAME}_linux_${DATE}.x86_64"
godot --path . --export-release "Windows Desktop" "${BUILD_DIR}/${NAME}_windows_${DATE}.exe"

mkdir ${BUILD_DIR}/html
godot --path . --export-release "Web" "${BUILD_DIR}/html/index.html"
cd ${BUILD_DIR}/html
zip ${NAME}.zip *
mv ${NAME}.zip ..

cd ${CURDIR}
