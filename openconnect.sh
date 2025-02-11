#!/bin/bash
server=vpn.abc #VPN服务器地址
group=User #用户组
user=user1 #用户名
password=passwd #密码
pid_file=/opt/openconnect/pid_file 


## 登录
function login() {
        if [ `pidof openconnect` ];then
                echo "已登录"
        else
                echo $password | openconnect -b --pid-file=$pid_file --authgroup $group -u $user --no-dtls $server
                ## 判断启动状态
                if [ `pidof openconnect` == `cat $pid_file` ];then
                        echo "登录成功"
                else
                        echo "登录失败"
                fi
        fi
}

## 退出
function logout() {
  # 通过 pid 结束进程
        kill -9 `cat $pid_file`
        echo "注销成功"
}

## [] 计算布尔值，需要前后空格
## "$1" 防止无参，或空格作为一个整体字符串
if [ "$1" == "login" ]; then
        login
elif [ "$1" == "logout" ]; then
        logout
else
        echo 参数输入错误，支持的命令 login 或 logout
fi
