git clone --depth=1 https://github.com/project-lede/luci-app-godproxy && merge_packge luci-app-godproxy
git clone --depth=1 -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git && merge_packge luci-theme-argon

svn co https://github.com/coolsnowwolf/lede/trunk/package/lean/luci-app-cifsd && merge_packge luci-app-ksmbd
svn co https://github.com/coolsnowwolf/packages/trunk/kernel/ksmbd && merge_packge ksmbd
svn co https://github.com/coolsnowwolf/packages/trunk/net/ksmbd-tools && merge_packge ksmbd-tools

if [ $DEVICE = 'r2s' ]; then
mkdir -p target/linux/rockchip/armv8/base-files/usr/bin &&\
wget https://github.com/friendlyarm/friendlywrt/raw/master-v19.07.1/target/linux/rockchip-rk3328/base-files/usr/bin/start-rk3328-pwm-fan.sh -qNP target/linux/rockchip/armv8/base-files/usr/bin &&\
chmod +x target/linux/rockchip/armv8/base-files/usr/bin/start-rk3328-pwm-fan.sh
mkdir -p target/linux/rockchip/armv8/base-files/etc/init.d &&\
wget https://github.com/friendlyarm/friendlywrt/raw/master-v19.07.1/target/linux/rockchip-rk3328/base-files/etc/init.d/fa-rk3328-pwmfan -qNP target/linux/rockchip/armv8/base-files/etc/init.d &&\
chmod +x target/linux/rockchip/armv8/base-files/etc/init.d/fa-rk3328-pwmfan
mkdir -p target/linux/rockchip/armv8/base-files/etc/rc.d &&\
ln -sf ../init.d/fa-rk3328-pwmfan target/linux/rockchip/armv8/base-files/etc/rc.d/S96fa-rk3328-pwmfan

git clone --depth=1 https://github.com/NateLol/luci-app-oled && merge_packge luci-app-oled
fi

sed -i 's/192.168.1.1/192.168.2.1/' package/base-files/files/bin/config_generate

function merge_packge(){
    rm -rf $1/.git
    find package/ -type d -name $1 | xargs -r rm -r
    mv $1 package/
}
