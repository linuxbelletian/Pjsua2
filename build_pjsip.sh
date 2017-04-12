#!/usr/bin/env bash

# this file for building the pjsip lib
# Note: by default it will build armeabi target,
# to build for other targets such as:
# ---  arm64-v8a
# ---  armeabi-v7a
# ---  x86
# instead of just './build_pjsip', specify the target
# target arch in TARGET_ABI and run it with
# --use-ndk-cflags, for example:
# TARGET_ABI=armeabi-v7a ./configure-android --use-ndk-cflags
# script itself will disable the video function which needs
# extra lib(ffmpeg ..) to support video feature
echo "arch ${1}"
cd ./pjproject-2.6/
# you may change this variable to suit
export ANDROID_NDK_ROOT=~/Library/Android/sdk/ndk-bundle/
chmod a+x ./configure-android
NDK_TOOLCHAIN_VERSION=4.9 TARGET_ABI=${1} APP_PLATFORM=android-14 ./configure-android --use-ndk-cflags \
--disable-video --with-ssl=`pwd`/openssl-1.0.2k
make dep && make clean && make