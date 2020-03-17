# 环境配置

首先迁出 [SpaceCommander](https://github.com/CodingPub/spacecommander)。

```bash
git clone https://github.com/CodingPub/spacecommander
```

配置命令行别名，关键字 alias，以 iTerm 为例，修改文件 `~/.bash_profile`，在尾部插入：

```bash
# spacecommander
export PATH="${PATH}:$HOME/<spacecommander_path>"
# 初始化配置
alias ocformatsetup="setup-repo.sh"
# 格式化stash文件
alias ocformat="format-objc-files.sh"
# 格式化指定文件
alias ocformatfile="format-objc-file.sh"
# 格式化所有文件
alias ocformatall="format-objc-files-in-repo.sh"
```

在控制台，进入项目根目录执行`ocformatsetup`，之后可以看到项目目录下的 .git/hooks/pre-commit 文件注入了脚本执行语句。

在项目根目录执行 ocformatall 命令，愉快的玩耍吧。

> `ocformatsetup`命令还在项目根目录生成了一个`.clang-format`文件，执行`ls -a`可以看到，它只是一个软连接文件，如果保持软连接，不要将它上传到 git 仓库，需要添加到 .gitignore，建议是不上传，所有项目使用同一份配置。当然，这可以根据实际情况进行调整。

# 常用命令

- ocformatsetup: 初始化项目配置
- ocformat：最常用的命令，格式化 git 暂存的文件，也就是即将提交的文件，因为格式化整个项目，需要几分钟时间，因此提交前只格式化当前修改文件是有必要的。
- ocformat -s: 格式化暂存文件，之后暂存格式化后的文件，初期不建议使用，格式化后要观察一下格式化的结果，保证编译正常再提交。
- ocformatfile：格式化指定文件，将文件路径作为参数传递即可。
- ocformatall：格式化所有文件，项目第一次格式化时使用，大概需要执行2次，才能完成所有格式化操作。

# 升级 clang-format

笔者仓库内置了 clang-format-9，原作者内置的 clang-format-3.8 版本年代已经不可考，当前最新版本是 9，通过 brew 安装的版本是 9，还算够用。可以在[这里](https://clang.llvm.org/docs/index.html)查看最新版本的 clang。如果要更新 clang-format 版本，只需要将最新的 clang-format 可执行文件放到`SpaceCommander/bin`目录下，再修改`format-objc-file-dry-run.sh`和`format-objc-file.sh`两个脚本文件引用的 clang-format 路径即可，如：

```bash
"$DIR"/bin/clang-format-9.0.0 -i -style=file "$1" ;
```

这里需要注意，不同版本的 clang-format 配置属性不能相互兼容，因此升级后，需要重新导出一份默认的 .clang-fomat 配置

```bash
clang-format -style=llvm -dump-config > .clang-format
```

再根据项目需要，定制相关配置，最后替换掉

```bash
SpaceCommander/.clang-format
```

## 忽略多个文件

在项目根目录新建 .formatting-directory-ignore 文件，列出不参与格式化的目录名或文件名，可包含多个配置，配置不支持正则，可只列出文件名的一部分，进行模糊匹配，如：

```
.framework
Pods
```

注意：Pods 是被默认屏蔽的，这里只是作为 demo.

## 忽略单个文件

在文件的第一行加上 `#pragma Formatter Exempt` or `// MARK: Formatter Exempt` 就可以阻止该文件被格式化。

## 忽略代码段

在指定代码段的前后加上 `// clang-format off` 和 `// clang-format on` 可以阻止该段代码被格式化。**注意**这个功能对于自定义扩展的格式化操作无效。

# 强制提交

工具是程序员编写的，偶尔出点 bug 也是能理解的，在实际开发中，如果代码格式化出现异常，又需要马上提交代码，可以绕过提交钩子提交代码。

![截图](http://codingpub.github.io/2019/04/22/OC%E5%9B%A2%E9%98%9F%E7%BC%96%E7%A0%81%E8%A7%84%E8%8C%83%E5%8C%96-2/WX20190412-175741.png)