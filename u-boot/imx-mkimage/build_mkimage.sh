#!/bin/sh
export MKIMAGE_SRC=$PWD
export COPY_FILES=1
export ADD_OPTEE=0

if [ ${COPY_FILES} == 1 ]; then
cp -rfvp ../uboot-imx/tools/mkimage iMX8M/mkimage_uboot
cp -rfvp ../uboot-imx/spl/u-boot-spl.bin iMX8M/
cp -rfvp ../uboot-imx/u-boot-nodtb.bin iMX8M/
cp -rfvp ../uboot-imx/u-boot.bin iMX8M/
cp -rfvp ../uboot-imx/arch/arm/dts/imx8mq-evk.dtb iMX8M/imx8mq-evk.dtb
cp -rfvp ../firmware-imx-8.14/firmware/hdmi/cadence/signed_hdmi_imx8m.bin iMX8M/
cp -rfvp ../firmware-imx-8.14/firmware/ddr/synopsys/lpddr4_pmu_train_* iMX8M/
cp -rfvp ../imx-atf/build/imx8mq/release/bl31.bin iMX8M/
    if [ ${ADD_OPTEE} == 1 ]; then
        cp -rfvp ../imx-optee-os/build.imx-mx8mqevk/core/tee.bin iMX8M/
    else
        rm iMX8M/tee.bin
    fi
fi

make clean
make SOC=iMX8M flash_evk

if [ ${ADD_OPTEE} == 1 ]; then
    cp -rfvp iMX8M/flash.bin ./flash.bin-optee
else
    cp -rfvp iMX8M/flash.bin ./
fi
