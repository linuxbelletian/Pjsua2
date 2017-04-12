#!/usr/bin/env bash
## this script need update for more flexible usage

##  todo we are going to change the 'build tools' dir to rootProject/build-tools/{ARCHITECTURE}/
## the 'ARCHITECTURE' can be replace with 'arm' 'x86' 'x86_64' 'arm64'
## the dir may be Symbolic link link to other build tool dirs ,such as arm64 links to arm
## before we do anything we should check the tool is available.

## check the tools

./build-tools/

export NDK=/Users/aber/Library/Android/sdk/ndk-bundle
${NDK}/build/tools/make_standalone_toolchain.py \
    --arch ${1} --api 14 --install-dir ./build-tool/${1}

make clean
case ${1} in
x86)
export TOOLCHAIN_PATH=`pwd`/x86-build-tool/bin
export BASE_TOOL_NAME=${TOOLCHAIN_PATH}/i686-linux-android
;;
arm)
export TOOLCHAIN_PATH=`pwd`/arm-build-tool/bin
export BASE_TOOL_NAME=${TOOLCHAIN_PATH}/${1}-linux-androideabi
;;
esac
export CC=${BASE_TOOL_NAME}-gcc
export CXX=${BASE_TOOL_NAME}-g++
export LINK=${CXX}
export LD=${BASE_TOOL_NAME}-ld
export AR=${BASE_TOOL_NAME}-ar
export RANLIB=${BASE_TOOL_NAME}-ranlib
export STRIP=${BASE_TOOL_NAME}-strip

case ${1} in
x86)
export ARCH_FLAGS="-march=i686 -msse3 -mstackrealign -mfpmath=sse"
export ARCH_LINK=
;;
arm)
export ARCH_FLAGS="-march=armv7-a -mfloat-abi=softfp -mfpu=vfpv3-d16"
export ARCH_LINK="-march=armv7-a -Wl,--fix-cortex-a8"
;;
esac
export CPPFLAGS=" ${ARCH_FLAGS} -fpic -ffunction-sections -funwind-tables -fstack-protector -fno-strict-aliasing -finline-limit=64 "
export CXXFLAGS=" ${ARCH_FLAGS} -fpic -ffunction-sections -funwind-tables -fstack-protector -fno-strict-aliasing -finline-limit=64 -frtti -fexceptions "
export CFLAGS=" ${ARCH_FLAGS} -fpic -ffunction-sections -funwind-tables -fstack-protector -fno-strict-aliasing -finline-limit=64 "
export LDFLAGS=" ${ARCH_LINK} "
cd ./openssl-1.0.2k/
./Configure android
make
rm lib/lib*.a
cp lib*.a lib/