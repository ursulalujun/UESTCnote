# Unix读书笔记

## Unix操作系统

NorthBridge和SouthBridge是两个主要的集成芯片，北桥继集成了总线，南桥集成了IO、声卡、网卡等很多功能，现在北桥基本被CPU集成取代。

<font color='cornflowerblue'>Linux不是Unix</font>，是模仿Posix标准从头开发的系统

Unix的UI（用户接口）Shell 是命令行式的，windows和maxOS是图形用户接口（GUI）

Windows的命令行有cmd（使用dos命令）、shell和powershell

## Unix命令

常见命令格式：

![image-20220225204914882](https://s2.loli.net/2022/06/26/JIa8d6AhNswfFSo.png)

短选项：-字符，长选项：--单词

<font color='cornflowerblue'>Unix对大小写敏感，命令名只能是小写</font>



关机：sudo shutdown -P now

重启：sudo reboot

（虚拟机挂起：可以使用挂起和恢复功能保存虚拟机的当前状态。在恢复虚拟机时，在挂起之前运行的应用程序将恢复运行状态，而不更改其内容。）

退出：1. exit	2.logout	3.Ctrl+d

Ctrl+c  异步中断运行，原理是发送中断信号，模拟硬件中断。

Ctrl+d  原始的语义是文件输入结束，bash会提供三个文件描述符stdin, stdout, stderr，stdin会把Ctrl+d解释成文件结束，文件结束就是用户不再想书如命令，于是就退出了。

Ctrl+h  退格

Ctrl+u  删除输入行

Ctrl+z   将进程放入后台，fg 1 （frontGround）把1号进程放到前台，或者%+进程名

修改密码：passwd

查看用户：who，用户的相关信息记录在/etc/passwd，其中记录的口令是hash散列

/etc/passwd的文件格式：**用户名**:**口令**:**用户标识号**:**组标识号**:**注释性描述**:**主目录**:**登录Shell**

帮助：help、learn

打印：cat

man查阅操作手册，man man，前三卷的内容：

1. 命令

2. system call   是在用户空间和内核空间之间的中间层，是连接用户态和内核态的桥梁。系统调用是用户态进入内核态的唯一入口。
3. clib函数，clib是基于系统调用封装形成的一个库，比如printf等函数都是通过system call执行的。

（有些函数可能会出现在多个卷里，则要指定卷号，eg： man 3 printf



sudo命令以系统管理者的身份执行指令，也就是说，经由 sudo 所执行的指令就好像是 root 亲自执行。



### Shell

shell仅仅是一个程序，在Unix中没有特权

字符界面下，用户登录系统后，由shell负责与用户交互，交互的方式是提示用户输入命令。
shell的种类：sh、ksh、csh、bash、dash
切换shell：chsh -s /bin/ksh、dash、bash

### 登录过程

init进程是所有进程的父进程，是1号进程

`systemd=init`

Unix系统启动后，init/systemd进程负责拉起所有用户进程

kthreadd是2号进程，在内核初始化的时候被创建，作用是管理调度其它的内核线程。

查看所有进程：ps -elH

PPID表示该进程的父进程，是由谁拉起的

![image-20220311193010966](https://s2.loli.net/2022/03/11/XYzSEvhc2kfGKFq.png)

<font color='cornflowerblue'>fork 进程创建出新的子进程</font>，p1 fork出p2，p1和p2完全相同，采用copy-on-write写时拷贝机制，等到**修改数据时**才真正分配内存空间，避免不必要的内存拷贝。

<font color='cornflowerblue'>exec 执行对应的程序</font>

真正的执行过程是进程首先fork出一个子进程，由子进程执行相应的程序

登录：init进程创建getty进程守候在各个终端上，当终端上有字符输入，exec login程序，当username，password验证成功，fork一个shell进程

```Mermaid
graph LR
    id1(init)--fork-->id4(init')
    id4--exec-->id2[getty]
    id2--exec-->id3{login}
    id3--fork-->id6{login'}
    id6--exec-->id5((bash))
    id5-->id1

```

退出：shell退出、login退出，init回收login，init再fork一个新的getty进程



## vi编辑器

创建文件 vim+文件名

### 工作模式切换

![image-20220318193641364](https://s2.loli.net/2022/03/18/C2estkx8rE7n9HY.png)

区分命令模式和命令行模式，编辑模式先按ESC进入命令模式，然后:进入命令行，命令行在最末行

:q!不保存退出，:wq保存退出

i,I,a,A,o,O 进入输入模式时切换移动光标到不同的位置

### 其他基本命令

<font color='green'>ps：以下命令都要先ESC退出编辑模式，在命令模式下操作</font>

移动光标：hjkl，0或`^`移动到行首，`$`移动到行尾，w向后移动一个word，b移动到word开头，e移动到word尾部（^和$​也分别对应正则表达式的行首和行尾）

: help 进入说明文档，Ctrl+]进入教程的某一节

单词搜索，/word 向后搜索，再n就向后匹配下一个，?word 向前搜索

x删除字符，dd删除行，数字+x/dd 删除几个字符或几行，u撤销最近的修改，U撤销当前所有修改，. 重复最近的修改操作

### 缓冲与显示

文件存储在磁盘里，vim进程开启后加载到缓冲区buffer，然后用window截取显示。

## vi高级

临时写入：键入vim后就可以开始编辑，:w或wq +文件名，把临时缓冲区中的内容保存到这个文件，如果文件已存在会提示，可以用w!强制写入替换

w也可用于另存文件，:w+不同的文件名，就是另存了，之后编辑的仍然是原文件

### vi调用选项（vi命令的参数）

只读选项：vim -R	以只读方式打开文件

命令选项：vim -c    允许用户在命令行指定vi命令作为参数。对于用户在开始编辑文件时先进行光标定位或查找特定的样式非常有用。eg：vi- c/most myfirst，vi将文件myfirst 复制到临时缓冲区中,然后将光标定位在第一次找到单词most的位置。

### 编辑多文件

vim +文件名1 文件名2 同时打开两个文件

命令行模式下

:next(:n)，:prev切换文件（跳到上一个，下一个参数）

:e +文件名 创建一个新文件，创建前注意保存当前的文件

:ar	显示当前正在编辑的文件名（argument）

:r+文件名	将另一个文件中的内容复制到当前编辑的文件中

:ls 查看当前打开的（buffer中的）文件目录，:bnext, :bprev在buffer之间切换

使用标签切换，标签 :tabnew打开一个新的标签，:tabclose关闭标签，:tabnext，:tabprev

### 剪切与拷贝

#### 寄存器

vim中设计的特别的暂存机制，用于保存拷贝和删除的文本

:registers显示寄存器

- 有名寄存器a-z（小写），一共26个，供用户使用

  对指定寄存器操作："+缓冲区名+命令

  eg："z7yy，复制7行到z缓冲区，''zp，复制z缓冲区额内容到光标所在位置

- 编号寄存器0-9，10个，vim自己使用，存放删除和拷贝的文本

  “0号寄存器是visual模式下拷贝的内容

  “1-”9号寄存器是dd删除、yy拷贝的行文本，形成一个栈，把新内容下压

- 缺省寄存器

  ""     用于寄存粘贴的内容

  "%	当前窗口对应的文件名

  "#     当前窗口的其它文件名

  ":	命令行模式最近输入的命令

  ".	最近插入的文本

命令模式下：

dd命令将删除行拷贝到””和”1寄存器，并且下压2-9号寄存器（dd其实相当于剪切）
yy命令将当前行复制到””和”0寄存器
p命令将缺省寄存器””内容拷贝到光标位置之后，"np，拷贝n号寄存器的内容
P命令将缺省寄存器””内容拷贝到光标位置之前

<font color='cornflowerblue'>**visual模式下可跨行拷贝**</font>：命令模式下v进入visual模式，移动光标，y命令将选择内容拷贝到””和”0寄存器，y表示yank，x命令删除多行

#### motion和range

motion移动光标的锚定位置，光标起始和终止位置之间的范围

| motion | 功能                                   |
| ------ | -------------------------------------- |
| $      | 从光标所在位置到改行的行尾             |
| 0      | 从光标的前一个位置到该行行首           |
| e或w   | 从光标所在位置到光标所在单词的末尾     |
| b      | 从光标的前一个位置到光标所在单词的开始 |

range是指行数

<font color='cornflowerblue'>寄存器+[range]+d/y+[motion]组合</font>，完成拷贝删除动作->寄存器

“wdd	删除当前行到”w寄存器

“z7yy	拷贝从当前光标开始算，一共7行，到”z寄存器

d$	删除从光标到行尾

cw	替换 change word，cw+要替换成的单词

寄存器+p，将寄存器内容拷贝到光标后的位置上，完成寄存器->缓冲动作

u或U撤销最后的动作

### 光标的快速定位

|                          | 命令行                   | 命令模式     |
| ------------------------ | ------------------------ | ------------ |
| 第n行的行首              | :n(:0定位到第一行的行首) | nG           |
| 最后一行的行首           | :$ |G，0G，$G|
| 文件的最后一个字符上     |                          | G$、Ctrl-end |
| 在命令行区域输出当前行号 |                          | Ctrl-g       |

![image-20220325201403847](https://s2.loli.net/2022/03/25/47vrZ25CSXinyux.png)

### 定制vi编辑器

:set	显示被修改的选项

:set 选项 ？ 显示某个选项的值

:set all	显示所有选项

:set number	显示行号，关闭，开关选项前加no即可，nomunber

:ser showmode	提示当前的工作模式，比如最下面---visual---

.exrc是vi编辑器的配置文件，vim启动的时候先去找.exrc，再找.vimrc

用户在vi编辑器中所设置的所有选项都是临时的;当用户退出vi时,它们都会失效。要想使这些设置成为永久的,可以将选项的设置保存到文件. exre中。

### 其他高级命令

**退出vim**

ZZ	直接保存并退出vim

:shell	切换到shell，exit回到vim

ctrl+z	将程序放进后台，fg +进程号/%vi	拉出到前台

命令行模式下 :! +命令，命令的结果会被显示在shell中，按回车返回vim

:! vim +文件名	调用另一个vim编辑器编辑文件，这个时候不是多文件同时编辑

r 替换字符，:r !date，把date命令执行的结果拷贝到当前文件中

**搜索并替换或删除**：?word或/word -> dw或cw newWord-> n/N -> .（重复上次的操作）

cw: vi在当前单词的尾部放置一个标记,并覆盖字母t,然后切换到文本编辑状态。光标停留在将要修改的第一个字母m 上。

方法二 ：命令行模式下range s/from/to/flags 
range表示行范围，%是全局所有行，1,$表示从1行到尾行
flags为g表示这一行中所有的匹配项都替换

**行连接**：  J	将当前行的下一行和当前行连接起来

**临时文件的恢复**：:recover



## 文件系统

![image-20220304215537846](https://s2.loli.net/2022/03/04/j7Y4DxcnRgQLyiA.png)

### 文件类型

普通文件：用vim创建的都是普通文件

目录文件：<font color='cornflowerblue'>目录本身也是一个文件</font>，目录文件记载了其他文件的信息

`-` 表示普通文件（在选项中一般用f表示普通文件）
d	表示目录
c	表示字符设备
b	表示块设备
l	表示符号连接文件

文件权限：rwx
r	表示读权限
w	表示写权限
x	表示执行权限，<font color='cornflowerblue'>对目录是访问权限（可以cd到这里）</font>
3个rwx表示：拥有者自己的权限、组权限、其它人的权限， - 表示不可

以.点开头的文件或目录是缺省不被显示

windows要用拓展名来关联该程序的打开程序，但是命令会指明打开程序，拓展名意义就不大了

### 文件操作

cat：查看文件内容，如果文件很长,用户看到的只有最后的23行,其他行已经从眼前翻过。可以按[ Ctrl-s]停止卷屏,然后用[Ctrl-q]恢复。
每一个[ Ctr-s]要用[Ctrl-q]取消,否则屏幕保持锁定,不响应键盘输入。
touch：创建一个空文件
rm：删除文件
	rm –fr：递归删除文件及目录，r-recursion递归，f-force（注意：不会让你确认删除）
	rm –i：确认删除

### 目录

Unix的目录系统没有盘符，所有文件都是挂在根目录下的（所以注意<font color='cornflowerblue'>路径最前面一定要有/</font>），呈树型

.. 父目录    .当前目录

绝对路径：/开头

相对路径：./开头，从工作目录开始定位

Unix目录对大小写敏感，文件名不能使用一些特殊字符，否则会被当作命令的一部分进行解释和执行，不能使用空格

Unix不考虑普通文件和目录文件名字之间的区别。因此，目录和文件可能有同样的名字。

- /etc 是存放配置文件的目录（windows的配置文件放在注册表中）
- /home	普通用户所在的目录
- /usr	用户目录
  - /usr/include	各种库头文件位置
  - /usr/bin	用户可执行文件
  - /usr/local	用户自行编译安装目录
- /bin	存放可执行文件
- /sbin	是管理程序目录
- /root	管理员目录
- /boot	自举目录，存放开机时所要用的文件，包括linux核心文件、开机菜单和开机所要的配置文件。
  - /boot/grub	引导加载程序相关的文件
- /dev	<font color='cornflowerblue'>设备文件，把硬件设备抽象成了文件</font>
  - /dev/null  垃圾桶
  - /dev/console 控制台
  - /dev/cdrom  光盘只读存储器
- /var	经常变动的文件，例如数据库、日志等
- /mnt	mnt是mount的缩写，表示挂载，挂接光驱、USB设备的目录
- /proc	进程信息，ID号等

#### 目录命令

- pwd( print working directory,打印工作目录)：显示用户当前所在目录的绝对路径名。用户初次登录到UNIX 系统上时,处在用户主目录中。

- cd
  
  cd命令是不能用man查看的，要用man bash查看，cd其实是改变bash的工作目录，一般的命令是用创建子进程的方式执行的，但是如果用子进程cd通知父进程bash的方式很麻烦，所以实际上<font color='cornflowerblue'>cd是bash的内置命令</font>，不会fork出cd子进程，而是bash自己执行
  
  - cd $HOME、cd、cd ~：返回用户主目录
  
    ![image-20220311203338030](https://s2.loli.net/2022/03/11/jsYlpikBLTxAXRh.png)
  
  - cd - ：返回上一个目录，cd的实现是用一个变量记录上一个目录的路径，所以不能多级回退
  
    ![image-20220311203849965](https://s2.loli.net/2022/03/11/kSEuB6nxrI7b9OA.png)

- mkdir：在工作目录或者其他任何命令指定的目录下创建一个新的子目录。必须处在父目录或者更高层的目录中才能删除子目录
  - -p选项：一行命令就可以创建一个完整的目录结构。使用-p选项在当前目录下逐级创建目录。

- rmdir：删除空目录，-p 选项：递归删除空目录

- rm -rf dirName 强行删除，不管是否为空

- `ls` ：列出所给目录下的所有文件名

  - 列出当前目录下的子目录名，可以使用 `ls -d */` 命令。

  绿色目录，所有人可读可写，比如存放临时信息的tmp目录，内存盘RamDisk挂在tmp下，系统重启之后，RamDisk中的内容全部清零

  ![image-20220311202225487](https://s2.loli.net/2022/03/11/wOCMn4aU739gsYp.png)

  - ls -a：显示包括隐藏文件
  - ls -l：以长格式显示

- 安装tree，打印树状目录



## 文件系统高级

### 重定向

C语言程序一般会打开三个缺省文件，stdin、stdout、stderr，文件描述符分别是0,1,2。默认标准输入是键盘，标准输出是用户终端（显示器）。Unix中利用shell重定向操作符，用户可以把标准输入、标准输出、错误输出替换为其它文件。

**标准输出重定向**

command > file 把命令执行的结果写入该文件<font color='cornflowerblue'>（覆盖）</font>，而不是打印到终端上

command >> file	<font color='cornflowerblue'>追加</font>

command > /dev/null（这个文件相当于一个黑洞、垃圾桶）只想执行命令，不想在终端打印结果

**标准输入重定向**

command <font color='red'><< EOF标准输入，当碰到EOF字符串时，输入结束</font> 

也可以不用<<EOF，

command > file 其实是缺省的command 1 > file，标准输出重定向，command 2 > file，默认情况下是标准错误重定向

&n 表示引用描述符为n的文件，m >&n合并描述符为m和n的文件



**与cat配合**

`cat first > second` 相当于 `cp first second` 本来是要在终端上输出first，现在输出在second中了，就相当于把first拷贝到second中，`cat myfirst mysecond > mythird`，拼接拷贝（注意命令中可以出现多个文件名，但要用空格分开）

`cat > myfirst`  从键盘输入，输出到myfirst中，按Ctrl-d结束，`cat > myfirst << EOF`，碰到EOF结束输入，可以用cat把命令写入脚本(.sh)，sh+文件名 执行脚本

**重定向原理**

[I/O重定向的原理和实现 - Todd Wei - 博客园 (cnblogs.com)](https://www.cnblogs.com/weidagang2046/p/io-redirection.html#:~:text=理解I%2FO重定向的原理需要从Linux内核为进程所维护的关键数据结构入手。 对Linux进程来讲，每个打开的文件都是通过文件描述符,(File Descriptor)来标识的，内核为每个进程维护了一个文件描述符表，这个表以FD为索引，再进一步指向文件的详细信息。 在进程创建时，内核为进程默认创建了0、1、2三个特殊的FD，这就是STDIN、STDOUT和STDERR，如下图所示意：)

重定向到的文件的描述符是1，标准输出被关闭后，file指针栈中原本指向标准输出的指针指向null，然后打开的文件寻找空的槽位就会先找到描述符是1对应的位置，这样就完成了重定向，仍然是向1输出，只是改变了1的指针指向，命令执行的脚本不用做修改

![image-20220401203247204](https://s2.loli.net/2022/04/01/gCryoPA91YNUxkl.png)

文件描述符是为了进程能与文件更好地对应

![image-20220506215525096](https://s2.loli.net/2022/05/06/KcWOiyPFsTlwrR4.png)

### 文件处理命令

command source target

**cp 复制**

cp -b 如果目标文件已存在，就创建备份文件

也可以cp source path，把文件拷贝到指定目录中

cp -r path1 path2，目录中有很多文件，把这整个目录及其所有内容都拷贝到指定目录中

**mv 移动**

重命名：mv name newName

mv fileName（可以是多个，用空格分隔） dirName

-i 提示，-f 强制移动

**wc 统计字数** ，c表示统计

![image-20220401210318305](https://s2.loli.net/2022/04/01/79zIWO6N4dX3jHw.png)

**cut 切分显示**

![image-20220401210620718](https://s2.loli.net/2022/04/01/gGvOMyiC2DUmTAh.png)

域就是一列列的，用分隔符（默认是\t，可用-d指定）分隔

eg：`cut -f1 -d: /etc/passwd` 提取所有用户，分隔符是：

`cut -c 1-4 file.txt`，按字符

（wc、cut经常用管道来考）

**head/tail** 默认显示开头/结尾的10行

head -cnt(b/l/c 单位字块/行/字符) file，只显示前面cnt行

**paste** 横向连接两个文件，把域连接起来

paste -d分隔符 文件1 文件2

**ln 创建链接**

ln fileName linkName

软连接 ln -s source

类似创建快捷方式，为文件建立了另外一个文件名，并没有新文件被创建。如果改变了链接文件中任何一个的内容，无论用哪个文件名.都会看到文件发生了改变。

硬链接比软链接的紧密程度要大，硬链接没有创建新的inode和block，也就是没有新创建文件，只是增加了一个别名|inode编号目录项，引用次数+1，相当于备份了目录项（但没有拷贝文件本身）只有所有目录项都被删除的时候block和inode才会被删除，软链接创建了新的inode和block，所以ls的时候会显示l类型文件，文件内容是链接到的文件的path

如果删除了source文件，软连接就会悬空（类似c语言的野指针）

软连接原理图：

![image-20220409102230044](https://s2.loli.net/2022/04/09/rMeZIHRYxaQSljV.png)

**more** 命令分页显示文件内容，可以向后翻，但不能向前翻

**less** 是more的改进，可以向前翻，可以搜索

- b 向后翻一页 
- d 向后翻半页
- Q 退出less 命令 
- 空格键 滚动一页 
- 回车键 滚动一行



### 文件系统元字符

bash会展开shell元字符，然后再执行命令，所以<font color='cornflowerblue'>参数是补全之后的！</font>

`？` 必须要匹配且只能匹配一个，匹配两个??

`*` 匹配任意多个（包括0）字符（神奇的是没有包括`.*`）

`[]` 匹配中间的任意**单个**字符， 里面写多个字符就是或，[! ] 不包含

[]中有多个字符任选一个，`ls [ab]*`，以"a"或“b"开头的文件，用户可以使用[]元字符设定字符或者数字的范围。例如,[5-9]意味着数字5，6，7，8，9，`ls *[5-9]`以5-9结尾的文件

**find**

find命令用来在目录层次中定位与一组给定的标准相匹配的文件。标准可以是文件名或者文件的指定属性(例如更改日期.大小或者类型)。
`find pathname search options action option`
pathname表明find开始搜索的目录名，然后会向下递归搜索它的子目录。“查找选项"确定用户感兴趣的文件,“动作选项"指示一且发现了文件该怎么做。

pathname之后的选项总是以-开头

![image-20220408193845006](https://s2.loli.net/2022/04/08/ejJgGoidPrWOcnI.png)

-name选项中可以使用通配符，但一定要加""，否则就会被bash自动扩展替换，而不是去查询

-type选项:通过类型查找文件。输人- type并跟指定文件类型的字符。



可以用逻辑操作符or、 and和not来结合查找选项。

![image-20220408194229215](https://s2.loli.net/2022/04/08/57vqSD8wACbNHRI.png)

对找到的文件执行某条命令，-exec +命令 {} \;   用管道可以实现相同的效果

### 底层存储和命令执行

文件是操作系统对io设备的一个抽象，进程/线程是对执行过程的抽象

磁盘被分为扇区（sector），block（文件读取的单位）由多个扇区组成，|MBR|1|2|3|4|，MBR 是主引导记录，位于硬盘的 0 磁道、0 柱面、1 扇区中，主要记录了启动引导程序和磁盘的分区表。

文件系统在磁盘里的保存分区：|Boot|super|inode（存放所有inode结构体的数组）|data

目录即文件，文件里面要保存目录的信息（目录项），分成两部分，变长的文件名（dos下name是定长的，文件名(8B).扩展名(2B)），定长的inode编号（指针）

inode 是一个定长结构128B或256B，存放meta信息（如权限，userid等）和指向存放文件的block的指针，如果文件太大，block指针太多，可以用block指针指向另一个inode结构，用该结构存放放不下的block指针（文件名只存储在目录项中，不存在inode中）

文件访问过程：首先根据路径找到目录表项，文件名对应的inode编号，然后在inode表中找到inode，通过其中的block指针找到文件

自举过程：BIOS将MBR加载到内存里，再将Boot拉入内存，再将inode拉入内存，这样就不需要访问磁盘读取元信息和blockpoint了，访问磁盘的时间开销很大

cp hello.c hello.bak

1. 分配block，拷贝数据
2. 建立新的hello.bak的inode
3. 添加目录项，将文件名与新的inode关联

mv只是改变了目录项的移动，inode结点和文件指针都没有变

ls命令就是打开当前目录的目录文件，输出目录项的相关信息

ls -ail，i就是指inode

inode号，权限，引用计数，uid，gid，文件长度，创建时间

引用计数是指inode（编号）在目录项中被存储的次数

touch 只分配inode编号，不分配block，因为新建文件大小是0

mkdir，建立目录的时候，目录文件其实是非空的，有两项，记载自己的和父节点的inode，所以刚创建的时候目录的引用次数是2，一次在父目录文件中，一次在自己的目录文件中

父子目录文件之间有双向的指针，进程中有一个指向工作目录的指针，就可以实现cd

cd不会fork出子进程来做，cd是bash的内置命令，直接执行

## 管道

将一个程序的标准输出作为另一个程序的标准输入，形成管道（pipeline）

command A | command B，两条命令之间是以一个匿名文件传输

打印该文件夹下头文件的数量   ls -al | grep -e '.*h' | wc -l   （正则）

find /usr/include -name “*.h” -type f | xargs grep -e 'EPOLLIN'   （文件元字符）

和-exec grep -e 'EPOLLIN' {}\ 效果一样

xargs从标准输入上读，将标准输入文件按照空格/TAB拆解成参数，作为command执行参数，前一个命令生成的文件作为后面一个命令的参数，也就是在grep找到的这些文件中执行grep -e 'EPOLLIN' 

<font color='red'>！！如果不用xargs就是把find输出的结果，就是那几个文件名当作输入给grep，让grep在那几个文件名里面去匹配，用了xargs就是在找到的文件里匹配</font>

原理：管道是进程间进行单向通信的通道

增加文件描述符3,4对应管道的输入端和输出端，父进程bash fork出两个子进程bash1和bash2，两个子进程分别执行两个命令，第一个命令的文件描述符1，即标准输出连接管道的输入，第二个命令的文件描述符0，即标准输入连接管道的输出

![image-20220422210001331](https://s2.loli.net/2022/04/22/PrHEjp3Omcea54i.png)

### tee

tee命令多分支输出，同时输出到标准输出和文件，ls -al | tee dir.list

ls -al的标准输出作为后一个命令的stdin，tee把stdin拷贝到标准输出的同时还拷贝到目标文件dir.list

## 正则表达式

正则表达式RE是一种元语言，描述词法的语言，表现为一种表达式

BRE和ERE，ERE不是BRE的超集

<font color='red'>！！</font>注意区分正则表达式字符和文件系统元字符，find 后面用的就是文件系统的元字符

^introduction 就是查找位于行首的（顶格写的）introduction

 `*`作用于前一个字符或分组，`a*bc` 表示匹配任意多次a，比如aabc,aaabc，`.*`表示任意字符串，a.*bc，a开头，bc结尾中间任意的字符串

注意*可以匹配0次，匹配markdown中的标题，`^##*`不能一个#都没有

\n，反向引用已经定义到了的字符串，`ab*ab`和`\(ab\).*\1`等价

`\(ab\)\(cd\)[def]*\2\1`，ab是第一个分组，cd是第二个，abcd开头，cdab结尾，中间有任意个d或e或f的组合

![image-20220415200205213](https://s2.loli.net/2022/04/15/ndzfSRZP7iwjYa8.png)

注意是两层[]，外层[]表示选择在该范围内的，内层[]表示集合

![image-20220415200403433](https://s2.loli.net/2022/04/15/7ZpMkONAjGTDVJv.png)

从最外层的[]中的元字符中任选一个，[]的匹配规则是最长匹配，eg：`[*\.], []*\.], [-*\.], []*\.-]`

![image-20220415201646873](https://s2.loli.net/2022/04/15/gxyLeJP8QChKT9s.png)

空行：^[[:space:]]*$



### grep 命令

用正则表达式来搜索字符串，一定要把正则表达式写在'  '里面

grep '正则表达式'  文件名（文件名中可以使用文件元字符，注意区分）

“  ”中如果使用了变量名，shell会在执行命令时把变量名换成变量的值，会展开

' '中的不会展开

默认显示所有包含能匹配上正则表达式的内容的行

-o: 只显示匹配上的部分

-i：匹配时忽略大小写

-v：只显示不匹配的行



### 流编辑 sed

- a ：新增， a 的后面可以接字串，而这些字串会在新的一行出现(目前的下一行)
- d ：删除，因为是删除啊，所以 d 后面通常不接任何东西；
- s ：替换，s/from/to/

sed 's/:.*//' /etc/passwd和cut -f1 -d: /etc/passwd执行的效果是一样的

sed 用正则表达式来编辑文件的**每一行**（每次把\n前面的内容给sed处理），把所有以：开头的字符串都替换成空串，也就相当于删除，就只保留了第一个域

sed里面更改路径名的时候为了清晰，可以用;或者:分隔而不是用/，;from;to

删除c++中所有的//注释，`sed 's://.*::' *.cpp`

Dos中用\r\n来断行，unix中用\n

tr命令的替换不分行，全局替换

`tr -s '\r\n' '\n' <hello.txt > hello2.txt`

[Linux sed 命令 | 菜鸟教程 (runoob.com)](https://www.runoob.com/linux/linux-comm-sed.html)

## Shell

shell和GUI都位于用户和操作系统之间

shell可以看作一种交互程序或者一种语言

/etc/passwd决定了用户登录后执行的shell程序

对大多数用户健人的命令, shel并不执行,而是检查每个命令并启动相应的程序(系统工具)来完成请求的动作。shell决定启动哪个程序(程序的名字与用户所键入的命令相同)。

echo 显示命令的参数

### 执行命令的原理

[简述shell命令的解释过程](https://blog.csdn.net/huayangshiboqi/article/details/80217150)

基本步骤：命令解析（分解成token然后一个个匹配和检查）-> 替换和重定向（shell元字符和$VAR会在这个过程中被展开，正则表达式不会，反斜杠\转义，消除shell元字符语义） -> 进程替换 ->环境处理 -> 执行命令 -> 跟踪执行过程

命令：内置命令，外部命令，type +命令名 查看命令的类型

内置命令由当前bash直接执行，外部命令由fork出的子进程执行，父进程创建出子进程后就进入了阻塞wait状态，直到子进程结束，发送信号通知父进程，父进程中断结束，转移到下一条指令上继续执行（看书上的图p181）

展开步骤中，单引号和双引号中的shell元字符、正则表达式都不会被展开

双引号字符串需要展开$VAR变量，单引号，重音符号；单引号字符串不展开变量

重音符号：命令替换 eg: echo `date`

```shell
echo '\\'   -> echo '\\'
echo "\\" -> echo "\"
```

/etc/profile 是shell的公共脚本

![image-20220506200302367](https://s2.loli.net/2022/05/06/K2PnM38JFLrbCVk.png)



命令分行

```shell
$ ls \
>  -al
```

一行写多个命令用；分隔

（command），会fork出一个bash子进程执行（）内的命令



### 变量

定义变量 VAR=hello，=两端不能有空格，否则会被当成token切分

shell内置一个变量表，可以看出哈希表，变量名 -> 字符串

export修饰的环境变量会被传递给子进程，通过getenv()查看

标准变量：赋给标准shel变量的值通常由系统管理。用户登录时，shell通过这些写变量来得知用户的环境信息。用户可以改发这些变量的值，但只是临时改变，重新登录又会复原。如果希望长久改变,则把这些变量放到一个名为. profile的文件中。

HOME 当前用户的主目录；PATH外部程序的搜索路径，不在PATH的路径里面就要写完整的路径才能执行文件；IFS 定义扩展命令参数时的分隔符，比如read title author < TEMP，从TEMP文件中读取两个变量，变量之间的分隔符就是$IFS



### 进程管理

ps命令显示进程

kill命令向进程发送信号

kill -n 进程号，向某号进程发送信号

信号类似于硬件中断
Ctrl-c：  发送SIGINT信号，终止进程
Ctrl-d： 在标准输入流中写入EOF，结束输入

trap设置进程捕获信号后如何处理，trap “command” signal numbers

trap ‘’ “  TERM	忽略SIGTERM信号，trap - TERM	恢复SIGTERM信号缺省处理

![image-20220506214059910](https://s2.loli.net/2022/05/06/4xFCI1OczJPZBns.png)



#### 前台后台

shell命令使用&表示后台执行，command &

fg +作业号，把程序拉到前台

jobs，列举后台执行的作业

nohup “command”&，后台执行命令，并且该命令在用户退出登录后仍然执行

原理：当用户退出系统时，该进程与任何终端无关，孤儿进程会被init回收，但是nohup会让它不被回收，该进程的输出存入nohup.out文件



#### history与fc

命令暂存在约有两千多行的bash中，当用户退出登录，所有命令保存~/.bash_history文件中

history命令则列出到目前为止执行的所有命令

fc –s cmd	cmd是history的命令编号，执行该编号任务

给命令起别名，alias ll=‘ls –al’



## Shell脚本

自解释编程

脚本调试技术：打开调试开关，set -x，输出的是带参数展开后的命令，关闭，set +x

set –v命令输出参数替换前的命令

sh +文件名执行脚本

sh -c 解释执行字符串，把后面的字符串参数当做命令执行

eg：sh -c "echo; sleep 3"

sh -x 后面跟shell脚本，可以详细的显示shell脚本的执行信息



定义变量 VAR=hello，=两端不能有空格，否则会被当成token切分

添加变量：(export) VAR=xxx

取消变量：unset VAR或者VAR=

引用变量：`$`VAR或者${VAR}

显示变量的值：echo/printf `$`VAR 

变量替换

| **替换操作**    | **功能**                                               |
| --------------- | ------------------------------------------------------ |
| ${VAR:-word}    | 如果变量不存在，返回word                               |
| ${VAR:=word}    | 如果变量不存在，设置VAR变量为word，返回word            |
| ${VAR:?message} | 如果变量不存在，打印message，退出，但交互shell不会退出 |
| ${VAR:+word}    | 如果变量存在，返回word；否则返回null                   |



注意区分参数和变量，参数是指的函数的参数，命令也是一种函数，set就是设置命令行参数

参数设置：

位置参数是一种特殊的变量，用于表示命令行参数，set命令用于改变命令行参数
`$1-$9`
`$`0表示命令名
`$`#表示参数个数
`$`*将所有参数使用`$IFS`隔开，形成一个字符串
`$`@基本上与上面相同。只不过是“`$*`”返回的是一个字符串，字符串中存在多个空格，而 “`$@`”是返回多个字符串。

$?表示进程退出状态

$$表示当前进程pid，一般是当前shell的pid

shift：从右向左移参数，$#会表变小，最左边的参数被丢弃



<font color='red'>shell变量默认是字符串类型</font>，所以数学运算需要使用特殊的方式

计算算术表达式：

1. expr，数字和运算符之间要用空格分开，因为bash中的变量都默认被当做字符串，三个参数传递给expr，然后expr把三个参数解释成数字，不加空格就无法分隔字符串
2. let x=6+8，赋值语句中不能有空格
3. 使用$(())，`echo $((3+2))`

代码分块（），为（）内的命令创造一个新的shell子进程来执行

算术表达式包括比大小，符合则结果为1，如果两个变量中有一个是非数值，那就转换成字符串的比较，即ASCII的大小

<font color='red'>！！</font>注意与test区分，test的数值比较要使用 -lt, -gt，而且是符合则返回值是0

条件分支（看下ppt上的例子）：

```shell
if [ condition ]
then
	...
elif
	...
else
	...
fi #结束
```

条件是一段命令，shell命令执行成功返回0，<font color='red'>返回值为0满足条件</font>，不为0则不满足条件，返回值可用echo $?查看

注意Unix中用0表示true，用1表示false，条件判断时也是这样，所以逻辑短路中[ ... ]&&cmd，是第一条正确执行，返回0（true），就会接着执行下面的命令，相当于if [ ... ];then cmd

shell不像高级语言==可以直接判断true or false，要用test命令的返回值来判断，test ... 等价于[ ... ]<font color='red'>！！[]中间要有空格</font>，test 可以测试三类：字符串，文件，数字

test "$VAR" = "hello"，<font color='red'>一定要加双引号！</font>字符串测试

命令的返回值保存在$?中，不能直接用来赋值，可能是因为涉及子进程，不像函数的直接返回

```shell
x=`test "$VAR" = "hello"`
```

![image-20220429214914411](https://s2.loli.net/2022/04/29/kQeBy7v6rdUjO9g.png)

![image-20220429215553131](https://s2.loli.net/2022/04/29/RvOVCnNQKfe75F9.png)

if [ "$hour" -lt 18 ]

变量可以是字符串，但要是表示数字的字符串，shell会转换

![image-20220513200610491](https://s2.loli.net/2022/05/13/noOCi2z18pZKb5R.png)



循环：

```shell
for i; do
	echo $i
done
```

注意list-of-values用$IFS隔开，缺省是空格、tab、回车

如果不指定变量（如以上代码中的i）的任何范围，直接for，默认是`for i in "$@"`，i遍历脚本中的所有参数，在命令行中就是i遍历当前shell中的所有参数

until和while相反，当条件为假时继续执行循环体



函数：

```shell
[function] funname() 
{
…
$1 $2 $3
return 0
}
funname arg1 arg2 arg3
```

<font color='red'>！！</font>shell中函数的参数的个数是不确定的，不用在（）里写，调用的时候把参数用空格隔开就行(和命令的格式一样)

函数执行，类似于内置命令，不会新fork一个shell

函数内部定义的变量，外部可见，可以使用local指定局部，函数的调用参数是局部的



其他操作：

&&，||，逻辑连接，注意逻辑短路

read 读取用户输入并保存到变量或中， read 变量名，空格分隔，用户输入回车结束，和IFS+输入重定向，可从文件中读取变量值

source命令：在当前bash环境下读取并执行FileName中的命令（内置命令）

```shell
source fileName
. fileName
```

用途是刷新当前的shell环境

1. 使用source命令执行脚本则可以在父shell中设置变量，用sh来执行shell脚本，是在fork出的子shell里运行的，因此在脚本中设置的变量并不会同步到父shell中

2. 子进程不能直接访问父进程中定义的函数，所以需要先执行source命令访问到函数
3. 在~/.bashrc文件中定义完别名，可以使用source命令刷新当前shell环境，而不必重新登录使其生效 eg：`echo "alias ll='ls -al'" >> ~/.bashrc`



tar命令：用来存档和压缩

tar zcfv压缩成.tar.gz文件
tar zxfv解压.tar.gz文件（z：zip，c表示创建一个新的存档文件，即存放压缩文件，x表示从存档文件中还原出被打包的文件，即解压）

chmod：修改文件的权限，chown修改文件目录的owner，chgrp修改文件目录的group

![image-20220514095642222](https://s2.loli.net/2022/05/14/iK7TGotLgrAfNyb.png)



eval

shell不做递归变量替换，只做一次变量替换，eval等驱使shell做两次命令解释

eval 执行以下两个步骤：
第一步，执行变量替换，类似与C语言的宏替代；
第二步，执行替换后的命令串。

![image-20220622103033758](https://s2.loli.net/2022/06/22/cYQxuB8pfVvOPw4.png)

df显示可用空间
du统计文件或者目录的磁盘使用情况



## Unix通信

查看网络接口的连接状态

ifconfig / ip addr  IP地址的配置
netstat / ss  当前的网络连接情况
ping  检查连通性

虚拟机ping windows操作系统的IP，是因为windows有防火墙

![image-20220506205031871](https://s2.loli.net/2022/05/06/7vKbHLyFeor451z.png)

curl 拉取页面

wget 下载文件

scp和sftp



## Gnu工具链

Gnu toolchain是开发操作系统、应用程序的一套完整的程序和库

linux中的可执行文件主要是elf格式，如下图

![image-20220506205031872](https://ask.qcloudimg.com/http-save/yehe-3499826/gu8eoju32t.png?imageView2/2/w/1620)

代码汇编生成的二进制机器码就存放在.text中

用readelf命令读elf文件

### gcc 

一族语言的编译器，包括c、c++、go、java

gcc [options] file1 file2... //若不加入参数，则按默认参数依次执行编译、汇编和链接操作，生成的可执行文件名为 a.out

gcc -o filename



### gdb 

调试工具

- `(gdb) run + 回车` -- 运行程序并显示运行结果
- `(gdb) break + 某位置` -- 在某位置处设置断点
- `(gdb) next + 回车` -- next键入后才会开始执行 （注：显示下一行尚未执行的代码）
- `(gdb) print + 某变量名` -- 查看此时某变量名的值 （注：print结果以美元符号$开头+顺序数组+变量值）
- `(gdb) continue + 回车` -- 取消断点
- `(gdb) step` -- 进入某函数
- `(gdb) q` -- 退出debug



### makefile 

用于工程组织和编译

makefile使用一种**依赖**的语法来表示文件之间的关系，和命令式（告诉机器做什么，python，c++）的语法不一样，根据**时戳**来判断依赖关系是否被违反了

编写：

Makefile里主要包含了五个部分内容：显式规则、隐式规则、变量定义、文件指示和注释。　

　　1、显式规则。显式规则说明了如何生成一个或多个目标文件。这是由Makefile的书写者明显指出，要生成的文件，文件的依赖文件，生成的命令。

　　2、隐晦规则。由于make有自动推导的功能，所以隐式规则可以让我们比较粗糙地简略地书写Makefile，这是由make支持的。

　　 3、变量的定义。在Makefile中我们要定义一系列的变量，变量一般都是字符串，这个有点你C语言中的宏，当Makefile被执行时，其中的变量都会被扩展到相应的引用位置上

　　4、文件指示。其包括了三个部分，一个是在一个Makefile中引用另一个Makefile，就像C语言中的include一样；另一个是指根据某些情况指定Makefile中的有效部分，就像C语言中的预编译#if一样。

　　5、注释。和UNIX的Shell脚本一样Makefile中只有行注释， 其注释是用“#”字符，这个就像C/C++中的“//”或者“ /*”。

```makefile
%.o: %.c
	$(COMPILE.c) $(OUTPUT_OPTION) $<
```

显示和隐式冲突的情况，优先遵循显示规则

[如何编写一个Makefile文件（手把手的教你）](https://blog.csdn.net/heng000000/article/details/120930239?spm=1001.2101.3001.6650.9&utm_medium=distribute.pc_relevant.none-task-blog-2~default~BlogCommendFromBaidu~default-9-120930239-blog-123152833.pc_relevant_default&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2~default~BlogCommendFromBaidu~default-9-120930239-blog-123152833.pc_relevant_default&utm_relevant_index=16)

编译：在makefile编译之前，都会检测所有的依赖对应的修改时间是否与上次编译的修改时间一致，如果所有的依赖都没有修改过，则不会进行编译，如果只要一个依赖的时间被修改过，则makefile就会再次编译。

执行：make 命令可以通过 -f 执行使用的makefile。如果在没有使用 -f 指定的情况下，会按照顺序：GNUmakefile, makefile 和 Makefile

### cmake

看一个小项目的cmake，作为框架



### git

版本控制系统

优点：对branch的支持很好，分布式（把整个版本库fork到本地，然后做push和pull操作与服务器同步），采用围绕主干开发的分支管理，测试好的版本再合并到主干上

![image-20220528202529834](https://s2.loli.net/2022/05/28/nDw7UcdIolyaOFp.png)



考点：find，sed，grep，wc，cut通过管道组合

find是用来找文件的，匹配文件名，用的是文件系统元字符, " "，grep是匹配内容的,用的是正则，' '

cat > f3 << EOF

提取用户：cut -f1 -d: /etc/passwd或sed 's/:.*//' /etc/passwd

`c[ae]t\{3\} `

书上文件系统的图



