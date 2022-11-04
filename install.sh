#!/usr/bin/bash
###
 # @Author: ttimochan
 # @Date: 2022-11-04 17:14:08
 # @LastEditors: ttimochan
 # @LastEditTime: 2022-11-04 17:52:23
 # @FilePath: /patchup/install.sh
### 

install-patchelf()
{

    echo "正在安装 patchelf..."
    sudo apt install -y make autoconf libtool
    git clone https://github.com/NixOS/patchelf --depth 1 && \
    cd patchelf && \
    chmod +x bootstrap.sh && \
    ./bootstrap.sh && \
    ./configure && \
    make && \
    make check && \
    sudo make install && \ 


    echo "安装 patchelf 完成" && \
    echo "正在安装 glibc-all-in-one..." && \
    cd .. && \

    install-glibc-all-in-one
}
install-glibc-all-in-one()
{
    git clone https://github.com/matrix1001/glibc-all-in-one && \
    cd glibc-all-in-one && \
    mkdir libs && \
    chmod +x  extract  update_list download && \
    ./update_list && \
    echo "glibc-all-in-one 安装完成" && \
    echo "正在安装 patchup..." && \
    cd .. && \
    install-patchup
}
install-patchup(){
    git clone https://github.com/polishing-labs/patchup.git --depth 1 && \

    cd patchup && \

    sudo pip install --editable . && \
    if command -v patchup &> /dev/null; then
        echo "patchup 安装完成"
    else
        echo "patchup 安装失败"
    fi


}
if ! command -v patchelf &> /dev/null; then
        {   
            
            install-patchelf
        }
    else 
        {
            echo "patchelf 已安装, 直接进行下一步"
            install-glibc-all-in-one
        }
fi