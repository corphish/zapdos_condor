 #
 # Copyright � 2014, Varun Chitre "varun.chitre15" <varun.chitre15@gmail.com>
 # Copyright � 2015, Avinaba Dalal "corphish" <d97.avinaba@gmail.com>
 #
 # Custom build script
 #
 # This software is licensed under the terms of the GNU General Public
 # License version 2, as published by the Free Software Foundation, and
 # may be copied, distributed, and modified under those terms.
 #
 # This program is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
 #


#!/bin/bash
#Variables
STRIP="/home/corphish/android/toolchains/linaro/linaro-4.9.4/bin/arm-eabi-strip"
ZIMAGE="/home/corphish/android/kernel/condor/zapdos_condor/arch/arm/boot/zImage-dtb"
KERNEL_DIR="/home/corphish/android/kernel/condor/zapdos_condor"
ZIP_DIR="/home/corphish/android/kernel/condor/zapdos_condor/zip/raw"
KERNEL="zImage-dtb"

#Main
BUILD_START=$(date +"%s")
export ARCH=arm
export SUBARCH=arm
export CROSS_COMPILE=/home/corphish/android/toolchains/linaro/linaro-4.9.4/bin/arm-eabi-
export KBUILD_BUILD_USER="avinaba"
export KBUILD_BUILD_HOST="build"
if [ -a $KERNEL_DIR/arch/arm/boot/$KERNEL ];
then
rm $ZIMAGE
rm $ZIP_DIR/system/lib/modules/*
fi
if [ $1 = "dt2w" ]
then
echo "Initializing build for dt2w version"
make  cm_condor_dt2w_defconfig
else
echo "Initializing build for non-dt2w version"
make cm_condor_defconfig
fi
echo "Building Kernel"
make
echo "Copying kernel"
cp $KERNEL_DIR/arch/arm/boot/$KERNEL $ZIP_DIR/kernel/$KERNEL
if [ -a $ZIMAGE ];
then
echo "Copying modules"
find . -name '*.ko' -exec cp {} $ZIP_DIR/system/lib/modules \;
cd $ZIP_DIR/system/lib/modules
echo "Stripping modules for size"
$STRIP --strip-unneeded *.ko
cd $KERNEL_DIR
./zip.sh $1
BUILD_END=$(date +"%s")
DIFF=$(($BUILD_END - $BUILD_START))
echo "Build completed in $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds."
else
echo "Compilation failed! Fix the errors!"
fi

