# openconnect-login-linux-ShellScriptshells
OpenConnect Linux 客户端登陆脚本
功能：
代替 Cisco 的 AnyConnect 客户端；
可以实现无交互的静默登录；

## 安装OpenConnect
### 安装源（Redhat系列）
```
yum install epel-release
```
###  安装客户端（Redhat系列）
```
yum install openconnect
```

###  安装客户端（Debian系列）
```
apt install openconnect
```


## 查看帮助
```
openconnect -h
```
## 脚本
此处使用密码登录，无密码登录需要服务端配合设置证书。
为了实现自动输入密码，使用了管理命令，也可以使用 expect 实现自动执行 Shell 的交互操作。

```
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
```

### 执行
# 登录
./openconnect.sh login
# 注销
./openconnect.sh logout
