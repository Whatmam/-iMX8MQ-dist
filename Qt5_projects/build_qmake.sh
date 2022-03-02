#!/bin/bash
Project=$1

	### Create fake project
if [ -z $1 ]; then
   echo "Usage : build_qmake.sh [Project Directory name]"
   exit
fi

if [ -e ./${Project} ]; then
	cp -rfvp ${Project} ${Project}_arm
	cp -rfvp /opt/fsl-imx-wayland/5.10-hardknott/sysroots/x86_64-pokysdk-linux/usr/bin/qmake ${Project}_arm
	find ${Project}_arm -type f -exec touch {} +
else
	echo "\"${1}\" Project file does not exist"
	exit
fi

	### build, Create Makefile
cd ${Project}_arm
source /opt/fsl-imx-wayland/5.10-hardknott/environment-setup-cortexa53-crypto-poky-linux
qmake
make clean ; make

