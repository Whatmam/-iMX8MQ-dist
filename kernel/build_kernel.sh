export KERNEL_SRC=$PWD
export TOOLCHAIN=Linaro_Toolchain

if [ ${TOOLCHAIN} == "Yocto_Toolchain" ]; then
        echo "used Yocto SDK Toolchain"
source /opt/fsl-imx-wayland/5.10-hardknott/environment-setup-cortexa53-crypto-poky-linux
else
        echo "used Linaro Toolchain"
export ARCH=arm64
export CROSS_COMPILE=${KERNEL_SRC}/../Toolchain/gcc-arm-8.2-2019.01-x86_64-aarch64-elf/bin/aarch64-elf-
fi

# export INSTALL_MOD_PATH=
# if [ ! -e $INSTALL_MODE_PATH ]; then
#         mkdir -p $INSTALL_MODE_PATH
# fi

if [ -e ./Image ] ;  then
        rm ./Image
fi

dtbs_list=`find . -maxdepth 1 -name "*dtb"`
if [ "$dtbs_list" ] ;  then
        rm ./*.dtb
fi


#make clean
#make distclean
#make imx_v8_defconfig
#make -j9

make imx8mq_whatmam_defconfig
make Image -j9
make dtbs

#make modules
#make modules_install

cp -rfvp  arch/arm64/boot/Image ./
cp -rfvp  arch/arm64/boot/dts/freescale/imx8mq-whatmam.dtb ./
