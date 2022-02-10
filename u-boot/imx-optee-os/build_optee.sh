#!/bin/sh
export OPTEE_SRC=$PWD
export TOOLCHAIN=Linaro_Toolchain


### clean 
rm -rf build.imx-mx8mqevk


if [ ${TOOLCHAIN} == "Yocto_Toolchain" ]; then
        echo "used Yocto SDK Toolchain"
        ### [whatmam] Yocto SDK Toolchain build failed. it's not working.
source ${OPTEE_SRC}/../../../SDK/environment-setup-cortexa53-crypto-poky-linux
ARCH=arm CROSS_COMPILE64=${CROSS_COMPILE} CFLAGS="--sysroot=${SDKTARGETSYSROOT}" LDFLAGS= ./scripts/nxp_build.sh imx-mx8mqevk
#ARCH=arm CROSS_COMPILE64=${CROSS_COMPILE} CFLAGS="--sysroot=${SDKTARGETSYSROOT}" LDFLAGS= ./scripts/nxp_build.sh imx-mx8qmmek
else
        echo "used Linaro Toolchain"
export CROSS_COMPILE64=${OPTEE_SRC}/../../Toolchain/gcc-arm-8.2-2019.01-x86_64-aarch64-elf/bin/aarch64-elf-
export CC=${CROSS_COMPILE}gcc
export LD=${CROSS_COMPILE}ld
source ./scripts/nxp_build.sh imx-mx8mqevk
#source ./scripts/nxp_build.sh imx-mx8qmmek
fi
