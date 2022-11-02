#!/usr/bin/bash
###
 # @Author: ttimochan
 # @Date: 2022-11-01 20:59:51
 # @LastEditors: ttimochan
 # @LastEditTime: 2022-11-02 08:43:42
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
echo "删除 patchup 可执行文件成功"
SCRIPTDIR="$( cd "$( dirname "$0"  )" && pwd  )"
rm -r ${SCRIPTDIR}
if [ -d ${SCRIPTDIR} ]; then
    echo "删除失败，请手动删除 ${SCRIPTDIR}"
    exit 1
fi
echo "删除 patchup 资源文件成功"
sleep 2
cd ..
echo "卸载 patchup 成功"
exit 0