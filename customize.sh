#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# 自定义配置

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default
sed -i 's/#src-git helloworld/src-git helloworld/g' ./feeds.conf.default
# Add a feed source
#sed -i '$a src-git lienol https://github.com/Lienol/openwrt-package' feeds.conf.default
#git clone https://github.com/tianiue/luci-packages.git package/luci-packages
#git clone https://github.com/xiaorouji/openwrt-passwall.git package/openwrt-passwall
#git clone https://github.com/fw876/helloworld.git package/helloworld
#git clone https://github.com/vernesong/OpenClash.git package/OpenClash
#git clone https://github.com/frainzy1477/luci-app-clash.git package/luci-app-clash
#git clone https://github.com/destan19/OpenAppFilter.git package/OpenAppFilter
# git clone https://github.com/jerrykuku/luci-app-ttnode.git package/luci-app-ttnode
#git clone https://github.com/linkease/ddnsto-openwrt.git package/ddnsto-openwrt
#git clone https://github.com/jerrykuku/luci-app-vssr.git package/luci-app-vssr
#git clone https://github.com/jerrykuku/lua-maxminddb.git package/lua-maxminddb
#git clone https://github.com/lisaac/luci-app-dockerman.git package/luci-app-dockerman
#git clone https://github.com/lisaac/luci-lib-docker.git package/luci-lib-docker
#sed -i '$a src-git kiddin9 https://github.com/kiddin9/openwrt-packages' feeds.conf.default
#git clone https://github.com/kiddin9/luci-app-dnsfilter.git package/luci-app-dnsfilter
#git clone https://github.com/tianiue/luci-app-bypass.git package/luci-app-bypass
#git clone https://github.com/esirplayground/luci-app-LingTiGameAcc.git package/luci-app-LingTiGameAcc
#git clone https://github.com/esirplayground/LingTiGameAcc.git package/LingTiGameAcc
#git clone https://github.com/Hyy2001X/luci-app-autoupdate.git package/luci-app-autoupdate
#git clone https://github.com/project-lede/luci-app-godproxy.git package/luci-app-godproxy
#git clone https://github.com/kenzok8/luci-theme-ifit.git package/luci-theme-ifit
#git clone https://github.com/kenzok8/small.git package/small

# 更改主机名
sed -i "s/hostname='.*'/hostname='LEDE'/g" package/base-files/files/bin/config_generate

# 修改内核5.14
# sed -i 's/KERNEL_PATCHVER:=5.4/KERNEL_PATCHVER:=5.14/g' target/linux/x86/Makefile
# sed -i 's/KERNEL_TESTING_PATCHVER:=5.4/KERNEL_TESTING_PATCHVER:=5.14/g' target/linux/x86/Makefile

# 修改openwrt登陆地址,把下面的192.168.6.1修改成你想要的就可以了
sed -i 's/192.168.1.1/10.0.0.1/g' package/base-files/files/bin/config_generate

# 修改主机名字，把OpenWrt-1.0修改你喜欢的就行（不能纯数字或者使用中文）
sed -i '/uci commit system/i\uci set system.@system[0].hostname='LEDE'' package/lean/default-settings/files/zzz-default-settings

# 版本号里显示一个自己的名字（Lan build $(TZ=UTC-8 date "+%Y.%m.%d") @ 这些都是后增加的）
# sed -i "s/OpenWrt /Lan build $(TZ=UTC-8 date "+%Y%m%d") @ OpenWrt /g" package/lean/default-settings/files/zzz-default-settings
       
# 修改argon为默认主题,可根据你喜欢的修改成其他的（不选择那些会自动改变为默认主题的主题才有效果）
# sed -i 's/luci-theme-bootstrap/luci-theme-ifit/g' feeds/luci/collections/luci/Makefile

# 设置密码为"空"（安装固件时无需密码登陆，然后自己修改想要的密码）
#sed -i 's/McPtUJaL$M47t/nUbjYrWraS5NgvOx0:18552/V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0/g' package/lean/default-settings/files/zzz-default-settings
sed -i '1c root:$1$McPtUJaL$M47t/nUbjYrWraS5NgvOx0:18552:0:99999:7:::' package/base-files/files/etc/shadow

# 关闭DHCP
wget -O package/network/services/dnsmasq/files/dhcp.conf https://raw.githubusercontent.com/aheig/bak/master/x86-64/dhcp.office
sed -i "s/ip6assign='60'/ip6assign='0'/g" package/base-files/files/bin/config_generate

# 更改ssh端口为2333
sed -i 's/22/2333/g' package/network/services/dropbear/files/dropbear.config
sed -i "/2333/a\        option Interface 'lan'" package/network/services/dropbear/files/dropbear.config

# 更改内核版本
sed -i 's/KERNEL_PATCHVER:=5.15/KERNEL_PATCHVER:=6.1/g' target/linux/x86/Makefile
sed -i 's/KERNEL_TESTING_PATCHVER:=5.15/KERNEL_TESTING_PATCHVER:=6.1/g' target/linux/x86/Makefile

# 修改插件名字（修改名字后不知道会不会对插件功能有影响，自己多测试）
# sed -i 's/"网络存储"/"存储"/g' package/lean/luci-app-vsftpd/po/zh-cn/vsftpd.po
# sed -i 's/"网络存储"/"存储"/g' package/lean/luci-app-usb-printer/po/zh-cn/usb-printer.po
# sed -i 's/"BaiduPCS Web"/"百度网盘"/g' package/lean/luci-app-baidupcs-web/luasrc/controller/baidupcs-web.lua
# sed -i 's/"带宽监控"/"带宽"/g' feeds/luci/applications/luci-app-nlbwmon/po/zh-cn/nlbwmon.po
# sed -i 's/"实时流量监测"/"流量"/g' package/lean/luci-app-wrtbwmon/po/zh-cn/wrtbwmon.po

# 修改bypass支持lean源码shadowsocksr-libev-ssr-redir/server重命名 (配合作者插件包仓库使用不需要更改）
# find package/*/ feeds/*/ -maxdepth 5 -path "*luci-app-bypass/Makefile" | xargs -i sed -i 's/shadowsocksr-libev-ssr-redir/shadowsocksr-libev-alt/g' {}
# find package/*/ feeds/*/ -maxdepth 5 -path "*luci-app-bypass/Makefile" | xargs -i sed -i 's/shadowsocksr-libev-ssr-server/shadowsocksr-libev-server/g' {}

# 修改bypass依赖为smartdns支持 (配合作者插件包仓库使用不需要更改）
# find package/*/ feeds/*/ -maxdepth 5 -path "*luci-app-bypass/Makefile" | xargs -i sed -i 's/smartdns-le/smartdns/g' {}
