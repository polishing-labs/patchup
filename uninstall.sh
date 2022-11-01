#!/usr/bin/bash
###
 # @Author: ttimochan
 # @Date: 2022-11-01 20:59:51
 # @LastEditors: ttimochan
 # @LastEditTime: 2022-11-01 21:14:59
 # @FilePath: /patchup/uninstall.sh
### 
if [ $UID -ne 0 ]; then
    echo "请使用 root 用户执行此脚本"
    exit 1
fi
rm -r /usr/bin/patchup
if [ -f /usr/bin/patchup ]; then
    echo "删除失败，请手动删除 /usr/bin/patchup"
    exit 1
fi
echo "删除 patchup 文件成功"
SCRIPTDIR="$( cd "$( dirname "$0"  )" && pwd  )"
rm -r $SCRIPTDIR
if [ $? -ne 0 ]; then
    echo "删除失败"
    exit 1
fi
echo "卸载 patchup 成功"