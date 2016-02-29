#!/bin/bash
HOSTNAME="127.0.0.1" #数据库地址
PORT="3306" #端口
USERNAME=$1 #数据库用户名
PASSWORD=$2 #数据库密码
DBNAME=$3  #数据库名称
USER=$4 #新建用户名

#生成新用户
pwd=`date +%s%N | md5sum | head -c 10` #随机数
csql="CREATE USER '${USER}' IDENTIFIED BY '${pwd}'" #执行创建用户
mysql -h${HOSTNAME} -P${PORT} -u${USERNAME} -p${PASSWORD} -e "${csql}"


#授权
gsql="GRANT ALL ON ${DBNAME}.* TO '${USER}' identified by '${pwd}';flush privileges;"
mysql -h${HOSTNAME} -P${PORT} -u${USERNAME} -p${PASSWORD} -e "${gsql}"
echo "成功为数据库${DBNAME}，创建用户${USER}，密码${pwd}"
