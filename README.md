# patchup

## Readme

该工具是我自用的一个小工具，用于快速匹配 `ELF` 文件的 `gilbc` 库并安装，一个 `PWN` 手的趁手小工具，不要过多的在环境部署上浪费时间（配置 `gilbc` 库），Just PWN ~

## Deploy

It is so easy~

你应该是使用的 python2 吧？没有人会用写脚本相对麻烦的 python3 吧。

首先你应该有如下东西 `patchelf`   `glibc-all-in-one` ，如果你没有，下文就是部署。

### install patchelf

#### 直接使用预编译的二进制文件

```bash
wget https://github.com/NixOS/patchelf/releases/download/0.14.5/patchelf-0.14.5-x86_64.tar.gz
tar -xzvf patchelf-0.14.5-x86_64.tar.gz
cd bin
sudo mv patchelf /bin/patchelf
```

#### 手动编译 patchelf

```bash
git clone https://github.com/NixOS/patchelf

cd patchelf
# 安装autoreconf
sudo apt install -y autoconf
# 赋予执行权限
chmod +x bootstrap.sh
# 使用预设脚本配置编译环境
./bootstrap.sh
./configure
make
make check
sudo make install
```



### install glibc-all-in-one

```bash
git clone https://github.com/matrix1001/glibc-all-in-one
cd glibc-all-in-one
mkdir libs
chmod +x  extract  update_list download
./update_list
```

cd 到上级目录

## install patchup

```bash
git clone https://github.com/polishing-labs/patchup.git

cd patchup

sudo pip install --editable .

```

安装完成，可以这样看看是否正常？

```bash
patchup --help
```



## 示例

假设你有一个 名为 `demo`  ELF 文件

你仅仅需要以下命令 ，就可以为该文件配置好 `gilbc` 库

```bash
patchup demo 2.23 -b
```

