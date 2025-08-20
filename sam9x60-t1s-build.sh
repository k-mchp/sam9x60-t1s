#! /bin/bash

<<comment
Prerequisites:
-This script was tested on Ubuntu 24.04.3

Description:
-This script clones all repos needed to build a t1s image for the SAM9X60 MPU into the newly created directory
-The script copies rebuild script into the build folder, so the image can be rebuilt by just running this script as ". t1s.rebuild" from the build folder
-The script also puts t1s.clean, t1s.rebuild, and sdk scripts into the build folder
-Lastly it builds the final image


Usage:
". sam9x60-t1s-build.sh"

Examples:
For new installs use the following command with the script in your created build folder:
". sam9x60-t1s-build.sh"
This will clone all repos and build an SAM9X60 t1s image

To build only, after you have already setup, run:
". t1s.rebuild" from the build directory

 Written by:
 __  __     
/\ \/ /     
\ \  _"-.  
 \ \_\ \_\  
  \/_/\/_/ 

  
comment

rd='\e[0;31m'
lg='\e[1;32m'
lp='\e[1;35m'
cy='\e[0;36m'
NC='\e[0m'

#--------------START WORK--------------------
sudo apt-get update
sudo apt-get -y upgrade

sudo apt-get -y install gawk wget git git-lfs diffstat unzip texinfo gcc-multilib \
     build-essential chrpath socat cpio python3 python3-pip python3-pexpect \
     xz-utils debianutils iputils-ping python3-git python3-jinja2 libsdl1.2-dev \
     pylint xterm libssl-dev python3-pyasyncore repo libncurses-dev lz4

export CROSS_COMPILE=arm-linux-gnueabi-

if [ ! -f /etc/sysctl.d/20-apparmor-donotrestrict.conf ]; then
  sysctl kernel.dmesg_restrict=0
  sysctl -w kernel.apparmor_restrict_unprivileged_userns=0
  cat << EOF >> /etc/sysctl.d/20-apparmor-donotrestrict.conf
  kernel.apparmor_restrict_unprivileged_userns = 0
EOF
fi

echo -e "${rd}-----Cloning Microchip Repos-----${NC}"
git clone https://github.com/k-mchp/meta-microchip-sam9x60-t1s.git
repo init -u https://github.com/linux4microchip/meta-mchp-manifest.git -b refs/tags/linux4microchip-2025.04 -m mpu/default.xml
repo sync

echo -e "${lg}-----Building t1s Image for SAM9X60-----${NC}"
export TEMPLATECONF=${TEMPLATECONF:-../meta-mchp/meta-mchp-mpu/conf/templates/default}
source openembedded-core/oe-init-build-env
bitbake-layers add-layer ../meta-microchip-sam9x60-t1s/
MACHINE=sam9x60-curiosity-sd bitbake sam9x60-t1s-demo

cd ../..
echo -e "${lp}T1s Build Complete!!! ${NC}\c"
echo -e "\c"

