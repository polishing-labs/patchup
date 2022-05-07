# patchup

## 前言

该工具是我自用的一个小工具（针对于做pwn题的辅助工具），用于快速修改本地`ELF`文件的libc使其与远程服务器那边所运行的程序依赖的`libc`库一样
从而避免了因为 `libc` 问题，而导致本地打通了但是远程没打通的尴尬情况。因为每次都手动 `patch libc` 的过程太过于重复，而且有概率出错，同时受到了
`roderick` 师傅写的 `pwncli` 的启发，于是就有自己写一个命令行工具的想法。

## Deploy

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
ok，假设你现在有了 `patchelf` 和 `glibc-all-in-one`  那么你就可以输入以下命令来安装 `patchup` 这个小工具了 
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
├── glibc-all-in-one(目录)
├── patchelf(目录i)
├── patchup.py(仓库文件)
└── setup.py(仓库文件
```


## 示例

假设你有一个 名为 `demo`  ELF 文件,他现在默认的 `libc` 库是 `2.27` 的，但是服务器那边的这个程序所依赖的 `libc` 库是2.23的
那么你就可以使用以下命令，去为你的ELF文件patch一个 `2.23` 的 `libc` 库。（`-b` 是备份的意思，建议每次使用 `patchup` 时都开启该选项）

```bash
patchup demo 2.23 -b
```
<img width="965" alt="image" src="https://user-images.githubusercontent.com/93199623/167239931-d6266ea8-5ee6-4dde-9037-a20ae9e73069.png">

假设你的 `glibc-all-in-one` 中空空如也，别担心，你依旧可以输入上面的命令。`patchup` 将会为你自动下载（如果你需要的话）效果如下：
<img width="1149" alt="image" src="https://user-images.githubusercontent.com/93199623/167242074-a6b3d411-af5d-4444-b9f4-acec16667e94.png">
此时 `match_libc_success_match` 展示了当前可以下载的libc版本，你可以输入下面索引来选择它们（第一个索引是0，第二个索引是1，以此类推）
<img width="1145" alt="image" src="https://user-images.githubusercontent.com/93199623/167242133-464207ad-6416-4cc1-859f-32ebca40ff7b.png">
等待下载成功后，将自动进行 `patch`（如果不想下载的话，可以输入q退出）


如果题目给定了一个libc库，别担心 `patchup` 依旧会正常工作，`patchup` 将会去寻找相应匹配的 `ld`，如果有的话则会直接链接，没有的话则会自动下载（如果你需要的话）
<img width="966" alt="image" src="https://user-images.githubusercontent.com/93199623/167242830-9cf871bb-e025-4c51-9fca-c3d78f462924.png">
<img width="1150" alt="image" src="https://user-images.githubusercontent.com/93199623/167242865-c6a01d64-1c9f-415b-aa18-5428821d0a15.png">

