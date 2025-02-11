# openconnect-login-linux-ShellScriptshells
OpenConnect Linux 客户端登陆脚本  
### 功能：  
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
## 安装脚本
此处使用密码登录，无密码登录需要服务端配合设置证书。
为了实现自动输入密码，使用了管理命令，也可以使用 expect 实现自动执行 Shell 的交互操作。

```
sudo mkdir -p /opt/openconnect
sudo wget -O /opt/openconnect/openconnect.sh https://raw.githubusercontent.com/muzihuaner/Openconnect-Login-Linux-ShellScript/refs/heads/main/openconnect.sh
sudo chmod +x /opt/openconnect/openconnect.sh

```
修改相关信息
```
nano /opt/openconnect/openconnect.sh
server=vpn.abc #VPN服务器地址
group=User #用户组
user=user1 #用户名
password=passwd #用户密码
```
### 执行
# 登录
./openconnect.sh login
# 注销
./openconnect.sh logout
