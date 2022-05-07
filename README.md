# patchup

## 前言

该工具是我自用的一个小工具（针对于做pwn题的辅助工具），用于快速修改本地`ELF`文件的libc使其与远程服务器那边所运行的程序依赖的`libc`库一样
从而避免了因为 `libc` 问题，而导致本地打通了但是远程没打通的尴尬情况。因为每次都手动 `patch libc` 的过程太过于重复，而且有概率出错，同时受到了
`roderick` 师傅写的 `pwncli` 的启发，于是就有自己写一个命令行工具的想法。

## Deploy

由于目前我个人做 `pwn` 题习惯用`python2`，所以这个脚本是用 `python2` 来写的。这就导致了如果用 `python3` 运行的话，会出现一些错误
（就比如我使用了 `python2` 里的 `raw_input` 函数）

由于这个小工具依赖的核心依然是 `patchelf` 和 `glibc-all-in-one` ，能让它以命令行工具的身份出现，还少不了python中的 `click` 模块。
因此你应该有如下东西 `patchelf`   `glibc-all-in-one` ，如果有的话请直接看下面的`install patchup` 部分，如果没有的话下文就是相关部署。

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
ok，假设你现在有了`patchelf`和`glibc-all-in-one` 那么你就可以输入以下命令来安装patchup这个小工具了 
```bash
git clone https://github.com/polishing-labs/patchup.git

cd patchup

sudo pip install --editable .

```

可以输入patchup --help命令查看帮助，如果出现下面图片所展示的内容，则说明安装成功。

```bash
patchup --help
```
<img width="550" alt="image" src="https://user-images.githubusercontent.com/93199623/167239756-3f52d19f-390e-4648-ba74-fee10ba71dfb.png">



最后目录结构应该如下

```tree
patchup
│──├── glibc-all-in-one (目录)
│──├── patchelf (目录)
│  ├── patchup.py(仓库文件)
│  └── setup.py(仓库文件)
```



## 示例

假设你有一个 名为 `demo`  ELF 文件,他现在默认的 `libc` 库是2.27的，但是服务器那边的这个程序所依赖的 `libc` 库是2.23的
那么你就可以使用以下命令，去为你的ELF文件patch一个2.23的 `libc` 库。

```bash
patchup demo 2.23 -b
```
<img width="945" alt="image" src="https://user-images.githubusercontent.com/93199623/167239899-9ee68231-1d84-4e7c-a85a-f38ad20635e3.png">

