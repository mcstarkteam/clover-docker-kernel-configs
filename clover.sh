#!/usr/bin/bash
cd 
echo $PWD
mkdir kbuild
cd kbuild
echo "开始更新apt软件包"
apt update

echo "开始安装依赖"
apt install -y bc bison build-essential ccache curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5-dev libsdl1.2-dev libssl-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev unzip openjdk-8-jdk language-pack-zh-hans

#第二批
apt install -y bc bison build-essential ccache curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5-dev libsdl1.2-dev libssl-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev unzip openjdk-8-jdk language-pack-zh-hans

#第三批
apt install -y gcc-9 wget curl

apt install -y build-essential openssl pkg-config libssl-dev libncurses5-dev pkg-config minizip libelf-dev flex bison libc6-dev libidn11-dev rsync bc liblz4-tool 
apt install -y gcc-aarch64-linux-gnu dpkg-dev dpkg git
apt install -y git-core gnupg flex bison gperf build-essential zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z-dev libgl1-mesa-dev libxml2-utils xsltproc unzip bc

echo "依赖安装完成"

echo "克隆内核源码"
git clone https://github.com/xiaomi-sdm660/android_kernel_xiaomi_sdm660 -b 10.0-eas kernel 
echo "下载编译器"
wget http://releases.linaro.org/components/toolchain/binaries/4.9-2017.01/aarch64-linux-gnu/gcc-linaro-4.9.4-2017.01-x86_64_aarch64-linux-gnu.tar.xz
tar xvf *.xz
mv gcc-linaro-4.9.4-2017.01-x86_64_aarch64-linux-gnu toolchains
rm *.xz

#设置环境
echo "设置编译环境"
export ARCH=arm64
export SUBARCH=arm64
export CROSS_COMPILE=/root/kbuild/toolchains/bin/aarch64-linux-gnu-
#完成

echo "降低 gcc 编译器版本"
update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 100
update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-9 100

echo "开始编译"
cd kernel
make O=out nx531j_defconfig
cd out
make -j8
echo "编译完成"