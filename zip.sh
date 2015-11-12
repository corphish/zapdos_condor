 #
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

ZIP_DIR="/home/corphish/android/kernel/condor/zapdos_condor/zip"
DEVICE="condor"
TYPE=""
if [ $1 = "dt2w" ]
then
echo "setting type to dt2w"
TYPE="dt2w"
else
echo "setting type to non-dt2w"
TYPE="non-dt2w"
fi

cd $ZIP_DIR/raw

zip -r ../archives/zd-$(date +"%Y%m%d")-$TYPE-$DEVICE.zip *


echo
if [ -f $ZIP_DIR/archives/zd-$(date +"%Y%m%d")-$TYPE-$DEVICE.zip ]
then
echo -e "Package Complete : $ZIP_DIR/archives/zd-$(date +"%Y%m%d")-$TYPE-$DEVICE.zip"
else
echo -e "Package Failed"
fi
