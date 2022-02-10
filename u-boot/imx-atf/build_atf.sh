#!/bin/sh
export ATF_SRC=$PWD
export TOOLCHAIN=Linaro_Toolchain

if [ ${TOOLCHAIN} == "Yocto_Toolchain" ]; then
        echo "used Yocto SDK Toolchain"
source ${ATF_SRC}/../../../SDK/environment-setup-cortexa53-crypto-poky-linux
unset CFLAGS CPPFLAGS CXXFLAGS LDFLAGS MACHINE	#remove -Wl, -O1
else
        echo "used Linaro Toolchain"
export ARCH=arm64
export CROSS_COMPILE=${ATF_SRC}/../../Toolchain/gcc-arm-8.2-2019.01-x86_64-aarch64-elf/bin/aarch64-elf-
fi

make distclean
make PLAT=imx8mq bl31
#make PLAT=imx8qm bl31
#make -j8 PLAT=imx8qm BUILD_BASE=OUTPUT bl31
