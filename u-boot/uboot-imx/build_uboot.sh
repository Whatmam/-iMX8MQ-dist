#!/bin/sh
export UBOOT_SRC=$PWD
export TOOLCHAIN=Linaro_Toolchain

if [ ${TOOLCHAIN} == "Yocto_Toolchain" ]; then
        echo "used Yocto SDK Toolchain"
source ${UBOOT_SRC}/../../SDK/environment-setup-cortexa53-crypto-poky-linux
else
        echo "used Linaro Toolchain"
export ARCH=arm64
export CROSS_COMPILE=${UBOOT_SRC}/../../Toolchain/gcc-arm-8.2-2019.01-x86_64-aarch64-elf/bin/aarch64-elf-
fi

make clean
make distclean
make imx8mq_evk_defconfig
#make imx8mq_evk_optee_defconfig
#make imx8qm_mek_defconfig
make -j9
