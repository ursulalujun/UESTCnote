# Unix实验

## 实验笔记

1.安装Vmware，并创建虚拟机

2.下载Ubuntu iso，并在虚拟机中配置

注意配置server的时候不要改变下载源，否则很容易出现网络问题

3.远程登录，下载putty（或其他SSH），登录Ubuntu

[Putty远程登录VMware虚拟机Linux_](https://blog.csdn.net/C_0919/article/details/110634611)

在虚拟机中启动SSH服务：sudo /etc/init.d/ssh start

然后用IP地址 登录即可

Ubuntu需要安装一些东西，比如日历、bash等， sudo apt install +cal

![image-20220227194702654](https://s2.loli.net/2022/03/25/YC4Js7EFoxSvWOV.png)

## 实验一

![image-20220325193944356](https://s2.loli.net/2022/03/25/KRA7iOEZQfBrhyV.png)

![image-20220325194032927](https://s2.loli.net/2022/03/25/dsXtC7FpS8BkUIq.png)

简述登录过程

![image-20220325194331045](https://s2.loli.net/2022/03/25/mJXfH4ws9Tjilhz.png)

![image-20220325194702775](https://s2.loli.net/2022/03/25/j9D6v3rPXwm8GBC.png)

![image-20220325194934247](https://s2.loli.net/2022/03/25/3V9kv1JfPbaZuwr.png)

![image-20220325195715595](https://s2.loli.net/2022/03/25/X19IKlnREQJHADT.png)

![image-20220325200240952](https://s2.loli.net/2022/03/25/Kzre234HwQpxlMT.png)

简介一下各个目录

![image-20220311203338030](https://s2.loli.net/2022/03/11/jsYlpikBLTxAXRh.png)

![image-20220311203849965](https://s2.loli.net/2022/03/11/kSEuB6nxrI7b9OA.png)

ls解释文件类型

空格，回车，退格有效

文本替换《书》p48，搜索字符串

![image-20220325203920604](https://s2.loli.net/2022/03/25/t93yV4WJBMTYgfP.png)

Unix高级编程环境

## shell编程作业

```shell
#!/bin/bash

SUM=0
if [ $# = 0 ]
then
        echo usage: $0 n1 n2 ...
        exit 1
fi

for i; do
        # echo "$#,$@"
        SUM=$((SUM+i))
        shift
        if [ $# -gt 0 ]
        then
                OUTPUT="$OUTPUT $i +"
        else
                OUTPUT="$OUTPUT $i"
        fi
done
echo "$OUTPUT = $SUM"
```

1. shell中的变量默认是字符串，字符串最好是加“ ”，字符串内的变量写成$VAR，就会被替换成变量的值

2. [ ... ]或test，字符串测试，最好是都用" "括起来，另外if后面必须有空格， ‘=’两边必须也得加空格
3. `#!/bin/bash`，告诉操作系统，应该sh的哪一个实现来执行下面的script

```sh
#! /bin/bash -ex
```

- `-e`: 如果shell command中的任何一行failed，整个shell script file的运行会在这个command处立刻终止。
- `-x`: 在shell script的执行过程中，将command以及参数全部在标准输出中console出来

4. for i; 默认是`for i in "$@"`，for循环中为什么是固定的？

![image-20220515113744941](https://s2.loli.net/2022/05/15/mOGtIc4uVjEe2Rk.png)

![image-20220515113844406](https://s2.loli.net/2022/05/15/XsoqY2zPgavmbVH.png)

5. $0是命令名，不算做参数，不会被shift移动，`$@`、`$#`中也不包含它

```shell
#!/bin/bash

SUM=0
if [ $# = 0 ]
then
        echo "usage: $0 n1 n2 ..."
        exit 1
fi

while [ $# -gt 0 ]; do
        # echo "$#,$@")
        SUM=$((SUM+$1))
        if [ $# -gt 1 ]
        then
                OUTPUT="$OUTPUT $1 +"
        else
                OUTPUT="$OUTPUT $1"
        fi
        shift
done
echo "$OUTPUT = $SUM"
```

5. 在while循环中不好用i++的方式遍历参数，`$i`输出的是i的值，而不是i=1就输出`$1`，`$($i)`会报错，所以用shift移动，然后每次都用$1
6. 注意shift的时机和判断条件

Until 循环是不满足条件时就执行循环，因此把条件改成和while循环相反即可

```shell
#!/bin/bash

SUM=0
if [ $# = 0 ]
then
        echo "usage: $0 n1 n2 ..."
        exit 1
fi

until [ $# -le 0 ]; do
        # echo "$#,$@")
        SUM=$((SUM+$1))
        if [ $# -gt 1 ]
        then
                OUTPUT="$OUTPUT $1 +"
        else
                OUTPUT="$OUTPUT $1"
        fi
        shift
done
echo "$OUTPUT = $SUM"
```



执行shell脚本的方式

1. 当做命令/程序运行，要先chmod +x，`./test.sh p1 p2 ... `

2. 将 Shell 脚本作为参数传递给 sh 解释器 sh +脚本路径

![image-20220515122447159](C:\Users\86180\AppData\Roaming\Typora\typora-user-images\image-20220515122447159.png)



## 实验三

### 锁屏程序

设置终端，tput

终端：早期的主机较大，不便移动，终端是与计算机系统相连的一种输入输出设备，通常离计算机较远。 用ssh 远程登陆服务器，那么我们使用ssh的PC就是服务器的远程终端，也是一个虚拟终端（因为没有与服务器在本地用物理设备连接）虚拟终端在 Linux 中用 pts （pseudo termial slave）来标识。

控制台（console）与终端现在已经几乎表示同一个意思了，控制台是计算机最早的以及权限最大的一个终端。

[一篇文章带你快速弄清楚什么是终端 ](https://www.cnblogs.com/jfzhu/p/13040942.html)

tput clear就是产生了一个特殊的控制字符，能使终端产生清屏

tput ed 清除光标之后的内容

密码不要在终端显示，抑制字符回显，stty -echo

trap "" 2 3 15 屏蔽2,3,15号信号，使得进程不能被杀死



```shell
#!/bin/bash
# @brief
# lock the system

# handle parameters
if [ $# -gt 0 ]; then
	MESG="$@"
else
	MESG="System is locked"

#input passwd
tput clear
stty -echo
tput cup 14 30
printf "Enter your password: "
read PASSWORD1

# lock the screen
tput clear
trap "" 2 3 15 
tput cup 14 30
printf "$MESG"
until [ "$PASSWORD1" = "$PASSWORD2" ]; do
	read PASSWORD2
done

# return to original state
trap - 2 3 15 
stty echo
tput clear 
```



### 菜单

```shell
#!/bin/bash
# @brief
# menu case example

echo "0: Exit"
echo "1: Show date and time"
echo "2: List my home dictory"
echo "3: Display calender"
printf "Enter your choice: "

read OPTION
case "$OPTION" in 
	0) echo "Goodbye";;
	1) date;;
	2) ls $HOME;;
	3) cal;;
	*) echo "invalid input";;
esac	
```



```shell
#!/bin/bash
# @brief
# lock the system

HOUR=$(date +%H) #输出date中的小时部分
case $HOUR in
	0? | 1[01] )
	1[2-7])
	*)
esac
```



### 图书馆程序

被调用的函数必须写在调用的前面

闪退可能是有报错，ANSWER=y赋值的时候两边不能有空格，测试的时候必须有，测试的时候while或if后面还要有空格

bash -v/-x/-n

增加echo语句定位错误信息

read语句中止执行

add中：作为分隔符，追加写入

```shell
#!/bin/bash
# @brief
# Unix library

#ERROR: This progran displays an error message and waits for user
#input to continue.It displays the message at the
#specified row and column.
error(){
        tput cup $1 $2
        echo "Wrong Input. Try again."
        echo "Press any key to continue...> _ \b"
        read ANSWER
}

# ADD:This program adds a record to the library file(U_LIB).It asks for the
# title ,author，and category of the book. After adding the information
# to the ULIB_FIL file， it prormpts the user for the next record.
add(){
	ANSWER=y
	while [ "$ANSWER" = y ]; do
		tput clear
		tput cup 5 10 
		echo "UnNIX Library -${BOLD} ADDMODE"
		tput cup 7 23 
		echo "Tit1e: "
		tput cup 9 22 
		echo "Author: "
		tput cup 11 20
        echo "category: "
		tput cup 12 20 
		echo "sys: system，ref: reference，tb: textbook"
		echo "${NORMAL}"
		tput cup 7 30
		read TITLE
		tput cup 9 30 
		read AUTHOR
		tput cup 11 30 
		read CATEGORY
		STATUS = in	#set the status to indicate book is in
		echo " $TITLE: $AUTHOR: $CATEGORY: $STATUS: $bname: $date">> ULIB_FILB
		tput cup 14 10 
		echo "Any more to add? (y)es or (n)o >_\b"
		read ANSWER
		case $ANSWER in
			[Yy]*) ANSWER=y;; #表示匹配[Yy]*字符串
			[Nn]*) ANSWER=n;;
		esac
	done
}

#DISPLAY: This program displays a specified record from the ULIB_FILE.
#It asks the Author/Title of the book,and displays the specified
#book is not found in the file.
display(){
	OLD_IFS="$IFS"	#save the IFs sett ings
	answer=y	#initialize the arswer to indicate yes
	while[ "$answer" = y ]
	do
		tput clear;
    	tput cup 3 5;
    	echo "Enter the Title/buthor >_ \ b"
   		read response
		grep -i "$response" ULIB_FILE>TEMP # find the specified book in the library 
		if [ -s TEMP ]	#if it is found
		then
			IFS=":"
			read title author category status bnane date < TEMP
			tput cup = 10
			echo "UNIX Library~${BOLD} DISPLAYMODE ${NORMAL}"
			tput cup 7 23; echo "Tit1e: $title"
			tput cup 8 22; echo "Author: $authcr"
			case $category in	#check the category
				[Tt][Bb]) word= textbook;;
				[ss][Yy][ss] ) word=system;;
				[Rr][Ee][Ff} ) word= reference;;
				*) word = undefined;;
			esac
			tput cup 9 20;
   			echo "Category: $word"	
			tput cup 10 22;
			echo "Status: $status"	
			if["$status” = "out”]	#if it is checked out
			then	#then show the rest of the information
				tput cup 11 14 ; echo "Checked out by: $bname"
                tput cup 12 24 ; echo "Date: $date"
            fi
        else	#if book not found
		tupt cup 7 10 ; echo "$response not found"
		fi
		tput cup 15 10;echo "Any more to look? (Y)es or (N)o>_ \ b"
		read answer
		case $answer in
			[Yy]*) answer=y;;
 			[Nn]*) answer=n;;
		esac
	done	#end of the while loop
	IFS ="$OLD_IFS"	#restore the IFS to its original value
	exit 0
}


#EDTT:This program is the main driver for the EDIT program.
#lt shows the edit menu and invokes the appropriate programaccording #to the user selection.
edit(){
	ERROR_FLAG=0
	#initialize the error flag. indicating no error
	while true ; do
		if [ $ERROR_FLAG -eq 0 ]; then	#check for the error
			tput clear 
			tput cup 5 10
			echo "UNIx Library - ${BOLD}EDITMENU${NORMAL}"
			tput cup 7 20
        	echo "0: ${BOLD} RETURN ${NORMAL} To the Main Menu"
			tput cup 9 20
        	echo "1: ${BOLD} ADD ${NORMAL}"
			tput cup 11 20
        	echo "2: ${BOLD} UPDATESTATUS ${NORMAL}"
			tput cup 13 20
        	echo "3: ${BOLD} DISPLAY ${NORMAL}"
			tput cup 15 20
        	echo "4: ${BOLD} DELETE ${NORMAL}"
		fi
		ERROR_FLAG=0	# reset error flag
		tput cup 17 10
        echo " Erter your choice > _ \ b \ c:"
		read CHOICE		
		case $CHOICE in
			0) return ;;
			1) add ;;
			2) update ;;
			3) display ;;
			4) delete ;;
			*) error 20 10; tput cup 20 1; tput ed; ERROR_FLAG=1;;
		esac
	done
}

# set two variables
BOLD=$(tput smso) #定义凸显模式的控制字符
NORMAL=$(tput rmso)

# show greeting
tput clear
tput cup 5 15
echo "${BOLD}Super duper Unix library"
tput cup 12 10
echo "${NORMAL}This is Unix library application"
tput cup 14 10
echo "Please enter any key..."
read ANSWER

# print menu
ERROR=0
while true; do
	if [ $ERROR -eq 0 ]; then
		tput clear
		tput cup 5 10
		echo "Unix library - ${BOLD}Main Menu${NORMAL}"
		tput cup 7 20
		echo "0: ${BOLD}Exit${NORMAL}"
		tput cup 9 20
		echo "1: ${BOLD}Edit${NORMAL} Menu"
		tput cup 11 20
		echo "2: ${BOLD}Reports${NORMAL} Menu"
		ERROR=0
	fi

    tput cup 13 10
    printf "Enter your choice: "
    read CHOICE

    case "$CHOICE" in
       0) tput clear; exit 0;;
       1) edit;;
       2) reports;;
       # tput cup 20 1; tput ed;把此次输出的提示清除
       *) error 20 10; tput cup 20 1; tput ed; ERROR=1;
    esac
done

```



display:

7行:把环境变量F的值复制到OLD_ FLS中。在分配新的值之前,要保存原来的值。以后可以把初始设置恢复到变量IS中。

测试，-s filename	filename,文件是否存在并且长度非0

13行：用grep命令从文件ULIB_ FILE中寻找包含变量response所保存的模式的所有行,输出重定向到TEMP文件中。如果TEMP文件不空,表明存在指定书的记录;如果TEMP为空,说明没找到指定的书。grep -i忽略大小写

read title author category status bnane date < TEMP，从TEMP中读取这些变量

FIS就是分隔符，：分隔，不能有多余的空格



48行:用mv命令(见第5章)把TEMP文件重命名成ULIB_ FILE。现在ULIB_ FILE文件包含除了状态改变记录之外的所有记录。
49行:这一行把修改过的记录附加到ULIB_ FILE中。现在,ULIB_ F1ILE包含更新状态的指定记录。   

会查到包含指定字符的书籍



error_flag: integer expression expected

```shell

#!/bin/bash
# @brief
# Unix library

# ADD:This program adds a record to the library file(ULIB).It asks for the
# title ,author，and category of the book. After adding the information
# to the ULIB_FIL file， it prormpts the user for the next record.
add(){
        ANSWER=y
        while [ "$ANSWER" = y ]; do
                tput clear
                tput cup 5 10
                echo "UnNIX Library -${BOLD} ADDMODE"
                tput cup 7 23; echo "Tit1e: "
                tput cup 9 22; echo "Author: "
                tput cup 11 20; echo "category: "
                tput cup 12 20
                echo "sys: system，ref: reference，tb: textbook${NORMAL}"
                tput cup 7 30; read TITLE
                tput cup 9 30; read AUTHOR
                tput cup 11 30; read CATEGORY
                STATUS=in       #set the status to indicate book is in
                echo "$TITLE:$AUTHOR:$CATEGORY:$STATUS:$bname:$date">> ULIB_FILE
                tput cup 14 10
                echo -e "Any more to add? (y)es or (n)o >_\b\c"
                read ANSWER
                case $ANSWER in
                        [Yy]*) ANSWER=y;; #表示匹配[Yy]*字符串
                        [Nn]*) ANSWER=n;;
                esac
        done
}

#UPDATE: This program updates the status of a specified book. It asks for the.
#Aurhor/Title of the book,and changes the status of the specified
#a book from in (checked in) to out (checked out)，or from out to in.
#If the book is not found in the file,an error message is displayed
update(){
        DLD_IFS="$IFS"  # save the IFS settings
        answer=y
        while [ "$answer" = y ]; do
        new_status= ; new_bname= ; new_date=    # declare empty variables
        tput clear; tput cup 3 5; echo -e "Enter the Title/Author >_\b\c"
        read response
        grep -i "$response" ULIB_FILE>TEMP #find the specified book
        if [ -s TEMP ]  #if it is found
        then
                IFS=":"
                read title author category status bname date <TEMP
                tput cup 5 10
                echo "UNIX Library -${BOLD}UPDATE STATUS MODE${NORMAL}"
                tput cup 7 23 ; echo "Title: $title"
                tput cup 8 22 ; echo "Author: $author"
                case $category in       #check the category
                        [Tt][Bb]) word=textbook;;
                        [ss][Yy][ss] ) word=system;;
                        [Rr][Ee][Ff] ) word=reference;;
                        *) word=undefined;;
                esac
                tput cup 9 20; echo "category: $word"
                tput cup 10 22; echo "status: $status"
                if [ "$status" = "in" ] # if it is checked in
                then    #then show the rest of the infornation
                        new_status=out  #indicate the rew status
                        tput cup 11 18 ; echo "New status: $new_status"
                        tput cup 12 14 ; echo -e "Checked out by: _\b\c"
                        read new_bname
                        new_date=`date +%D`
                        tput cup 13 24 ; echo "Date: $new_date"
                else
                        new_status=in
                        tput cup 11 14 ;
                        echo "checked out by :  $bname"
                        tput cup 12 24 ; echo "Date: $date"
                        tput cup 15 18 ; echo "New status: $new_status"
                        fi
                grep -iv "$title:$author:$category:$status:$bnane:$date" ULIB_FILE > TEMP
                mv TEMP ULIB_FILE
                echo "$title:$author:$category:$new_status:$new_bname:$new_date" >> ULIB_FILE
        else    #if book not found
                tput cup 7 10 ; echo " $response not found"
                fi
        tput cup 16 10; echo -e "Any more to Update? (Y)es or (N)o>_\b\c"
        read answer
        case $answer in
                        [Yy]*) answer=y;;
                        [Nn]*) answer=n;;
                esac
        done    #end of the while loop
        IFS="$OLD_IFS"  #restore the IFs to its original value
    return
}

#DISPLAY: This program displays a specified record from the ULIB_FILE.
#It asks the Author/Title of the book,and displays the specified
#book is not found in the file.
display(){
        OLD_IFS="$IFS"  #save the IFs sett ings
        answer=y        #initialize the arswer to indicate yes
        while [ "$answer" = y ]; do
                tput clear
                tput cup 3 5
                echo -e "Enter the Title/Author >_\b\c"
                read response
                grep -i "$response" ULIB_FILE>TEMP # find the specified book in the library
                if [ -s TEMP ]  #if it is found
                then
                        IFS=":"
                        read title author category status bname date < TEMP
                        tput cup = 10
                        echo "UNIX Library~${BOLD} DISPLAYMODE ${NORMAL}"
                        tput cup 7 23; echo "Tit1e: $title"
                        tput cup 8 22; echo "Author: $author"
                        case $category in       #check the category
                                [Tt][Bb]) word="textbook";;
                                [ss][Yy][ss] ) word="system";;
                                [Rr][Ee][Ff] ) word="reference";;
                                *) word="undefined";;
                        esac
                        tput cup 9 20
                        echo "Category: $word"
                        tput cup 10 22
                        echo "Status: $status"
                        if [ "$status" = "out" ]        #if it is checked out
                        then    #then show the rest of the information
                                tput cup 11 14 ; echo "Checked out by: $bname"
                                tput cup 12 24 ; echo "Date: $date"
                        fi
                else    #if book not found
                tput cup 7 10 ; echo "$response not found"
                fi
                tput cup 15 10; echo -e "Any more to look? (Y)es or (N)o>_\b\c"
                read answer
                case $answer in
                        [Yy]*) answer=y;;
                        [Nn]*) answer=n;;
                esac
        done    #end of the while loop
        IFS="$OLD_IFS"  #restore the IFS to its original value
        return
}

#
#UNIX 1ibrary
#Delete:This program deletes a specified record from the ULTB_FILE.
#It asks for the Author/Title of the book,and displays the specified
#book,and deletes it after confirmation,or it shows an error
#message if the book is not found in the file.
#
delete(){
        OLD_IFS="$IFS"
        answer=y
        while [ "$answer" = y ]
        do
                tput clear ; tput cup 3 5 ; echo -e "Enter the Title/Author >_\b\c"
                read response
                grep -i "$response" ULIB_FILE > TEMP # find the specified book in the library
                if [ -s TEMP ]  #if it is found
                then
                        IFS=":"
                        read title author category status bname date < TEMP
                        tput cup 5 10
                        echo "UNIX Library - ${BOLD} DELETEMODE ${NORMAL}"
                        tput cup 7 23 ; echo "Title: $title"
                        tput cup 8 22 ; echo "Author: $author"
                        case $category in       #check the category
                                [Tt][Bb]) word=textbook;;
                                [ss][Yy][ss] ) word=system;;
                                [Rr][Ee][Ff] ) word=reference;;
                                *) word=undefined;;
                        esac
                        tput cup 9 20; echo "category: $word"
                        tput cup 10 22; echo "status: $status"
                        if [ "$status" = "out" ]        # if it is checked out
                        then    #then show the rest of the infornation
                                tput cup 11 14 ; echo "Checked out by: $bname"
                                tput cup 12 24 ; echo "Date: $date"
                                fi
                        tput cup 13 20 ; echo -e "delete this book? (Y)es or (N)o >_\b\c"
                        read answer
                        if [ $answer = y -o $answer = Y ]
                        then
                                grep -iv "$title:$author:$category:$status:$bname:$date" ULIB_FILE > TEMP
                                mv TEMP ULIB_FILE
                                fi
                else     #if book not found
                        tput cup 7 10 ; echo " $response not found"
                        fi
                tput cup 15 10; echo -e "Any more to delete? (Y)es or (N)o >_\b\c"
                read answer
                case $answer in
                        [Yy]*) answer=y;;
                        [Nn]*) answer=n;;
                esac
        done    #end of the while loop
        IFS="$OLD_IFS"  #restore the IFs to its original value
        return
}

#ERROR: This progran displays an error message and waits for user
#input to continue.It displays the message at the
#specified row and column.
error(){
        tput cup $1 $2
        echo "Wrong Input. Try again."
        echo -e "Press any key to continue...> _\b\c"
        read ANSWER
}

#EDTT:This program is the main driver for the EDIT program.
#lt shows the edit menu and invokes the appropriate programaccording #to the user selection.
edit(){
        ERROR_FLAG=0
        #initialize the error flag. indicating no error
        while true ; do
                if [ $ERROR_FLAG -eq 0 ]; then  #check for the error
                        tput clear
                        tput cup 5 10
                        echo "UNIx Library - ${BOLD}EDITMENU${NORMAL}"
                        tput cup 7 20
                echo "0: ${BOLD} RETURN ${NORMAL} To the Main Menu"
                        tput cup 9 20
                echo "1: ${BOLD} ADD ${NORMAL}"
                        tput cup 11 20
                echo "2: ${BOLD} UPDATESTATUS ${NORMAL}"
                        tput cup 13 20
                echo "3: ${BOLD} DISPLAY ${NORMAL}"
                        tput cup 15 20
                echo "4: ${BOLD} DELETE ${NORMAL}"
                fi
                ERROR_FLAG=0    # reset error flag
                tput cup 17 10
        echo -e " Erter your choice >_\b\c"
                #CHOI=1
                #echo "$CHOI"
                read CHOICE
                case $CHOICE in
                        0) return ;;
                        1) add;;
                        2) update;;
                        3) display;;
                        4) delete;;
                        *) error 20 10; tput cup 20 1; tput ed; ERROR_FLAG=1;;
                esac
        done
}

#REPROT_ NO:This progran produces reporvt from the ULIB_ FILE file.
#It checks for the report number passed to it on the cowmandline.sorts，and produces reports accordingly.
report_no(){
        IFS=":"
        case $1 in #check the contents of the $ 1
                1 ) sort -f -d -t: ULIB_FILE > TEMP ;;  # sort on title field
                2 ) sort -f -d -t: -k2 ULIB_FILE > TEMP ;; # sort on author field
                3 ) sort -f -d -t: -k3 ULIB_FILE > TEMP ;; # sort on category field
        esac

         # read records from the sorted file TEMP. Format and store them in PTEMP
        while read title author category status bname date      #read a record
        do
                echo "Title: $title" >> PTEMP   #format title
                echo "Author: $author" >> PTEMP #format authori
                case $category in       #check the category
                        [Tt][Bb]) word=textbook;;
                        [ss][Yy][ss] ) word=system;;
                        [Rr][Ee][Ff] ) word=reference;;
                        *) word=undefined;;
                esac
                echo "Category:  $word" >> PTEMP #format category
                echo -e "status: $status \n" >> PTEMP   #format status
                if [ "$status" = "out" ]
                then
                echo "checked out by : $bname" >> PTEMP
                echo -e "Date: $date \n" >> PTEMP
                fi
                echo >> PTEMP
        done < TEMP     #ready to display the formatted records in the PTEMP
        cat PTEMP       #display PTEMP page by page
        echo "Press any key to continue"
        read mode
        rm TEMP PTEMP
        return
}


# Reports: This program is the nain driver for the REPORTS menu..it shows the reports menu,and invokes the appropriate program
#according to the user's selection.
#
reports(){
        error_flag=0    #initialize the error flag,indicating no error
        while true      #loop forever
        do
                if [ "$error_flag" -eq 0 ]
                then
                        tput clear ; tput cup 5 10
                        echo "UNIX Library - ${BOLD} REPORTS MENU ${NORMAL}"
                        tput cup 7 20; echo "0: ${BOLD} RETURN ${NORMAL} To The Main Menu"
                        tput cup 9 20 ; echo "1: sorted by ${BOLD} TITLES ${NORMAL}"
                        tput cup 11 20 ; echo "2: sorted by ${BOLD} AUTHOR ${NORMAL}"
                        tput cup 13 20 ; echo "3: sorted by ${BOLD} CATEGORY ${NORMAL}"
                        fi
                error_flag=0
                tput cup 17 10 ; echo -e "Enter your choice> _\b\c"
                read choice
                case $choice in
                        0 ) return ;;
                        1 ) report_no 1 ;;
                        2 ) report_no 2 ;;
                        3 ) report_no 3 ;;
                        *) error 20 10; tput cup 20 1 ; tput ed; error_flag = 1;;
                esac
        done
}

# set two variables
BOLD=$(tput smso) #定义凸显模式的控制字符
NORMAL=$(tput rmso)

# show greeting
tput clear
tput cup 5 15
echo "${BOLD}Super duper Unix library"
tput cup 12 10
echo "${NORMAL}This is Unix library application"
tput cup 14 10
echo "Please enter any key..."
read ANSWER


ERROR=0
while true; do
        if [ $ERROR -eq 0 ]; then
                tput clear
                tput cup 5 10
                echo "Unix library - ${BOLD}Main Menu${NORMAL}"
                tput cup 7 20
                echo "0: ${BOLD}Exit${NORMAL}"
                tput cup 9 20
                echo "1: ${BOLD}Edit${NORMAL} Menu"
                tput cup 11 20
                echo "2: ${BOLD}Reports${NORMAL} Menu"
                ERROR=0
        fi

        tput cup 13 10
        printf "Enter your choice: "
        read CHOICE

        case "$CHOICE" in
                0) tput clear; exit 0;;
                1) edit;;
                2) reports;;
                *) error 20 10; tput cup 20 1; tput ed; ERROR=1;
        esac
done

```

## 实验四

C语言模拟管道

```c
#include <unistd.h>
#include <sys/wait.h>
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
  int fds[2];                      // 保存文件描述符的数组
  pipe(fds);                       // 创建管道，fd[0] 用于读取管道，fd[1]用于写入管道。
  pid_t pid = fork();              // fork出子进程
  if (pid == 0) {                  // 如果 pid == 0, 说明当前进程是子进程
    dup2(fds[0], STDIN_FILENO);    // 将子进程的输入与管道的输出关联
    close(fds[0]);                 // 管道输出已连接到子进程的输入，其他不用的文件描述符可以关闭
    close(fds[1]);                 // 子进程无需写入管道，因此可以关闭相应的文件描述符
    char *argv[] = {(char *)"ls", NULL};   // 设置命令
    if (execvp(argv[0], argv) < 0) exit(0);  // 在子进程中命令，如果运行出错则退出程序
  } 
    else if (pid < 0){
        printf("出错了，无法复制出子进程");
    }
  // 如果返回的pid不是0或负值，则当前位于父进程内
  close(fds[0]);                 // 关闭不使用的文件描述符
 
  // 使用dprintf将数据写入与管道输入对应的文件描述符，这样子进程就也可通过管道读取数据了 
    const char* path = "/home/ursula";
    dprintf(fds[1], "%s\n", path);	
  

  // 关闭管道输入对应的文件描述符，相当于向子进程发送了EOF表示管道通信结束，子进程能继续执行后续程序
  close(fds[1]); 

  int status;
  pid_t wpid = waitpid(pid, &status, 0); // 等待子程序结束后就退出程序
  return wpid == pid && WIFEXITED(status) ? WEXITSTATUS(status) : -1;
}

// fork函数测试
#include <unistd.h>
#include <stdio.h> 
int main () 
{ 
	pid_t fpid; //fpid表示fork函数返回的值
	int count=0;
	fpid=fork(); 
	if (fpid < 0) 
		printf("error in fork!"); 
	else if (fpid == 0) {
		printf("i am the child process, my process id is %d/n",getpid()); 
		count++;
	}
	else {
		printf("i am the parent process, my process id is %d/n",getpid()); 

		count++;
	}
	printf("统计结果是: %d/n",count);
	return 0;
}


void pipe(int fds[2]){
    fds[0] = open( "bufferedfile", O_RDWR ); //以读写形式打开模拟缓冲区的文件，并返回文件描述符
    fds[1] = fds[0]; // 读写管道的文件描述符均指向缓冲区文件
    dup(fds[0]); 	 // 使用当前可用的最小文件描述符将管道与进程关联
    dup(fds[1]);
   
}

// 写入管道
dprintf(fds[1], "%s\n", data);	

// 模拟重定向
#include<fcntl.h>
#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include <unistd.h>
int main(){
  int fd2=dup(0) ;    //复制文件描述符0对应的表项给fd2 = 3,此时fd2 ,和0 都指向终端
  close(0);           //关闭文件描述符0
  int fd = open("filename.txt",O_RDONLY); //filename.txt获取文件描述符0 
  int item;
  scanf("%d",&item);                //从标准输入0中读数据
   printf("format1= %d\n",item);    //输出filename.txt中读出来的内容
  dup2(fd2,0);                      //复制文件描述符fd2表项给0,此时0重新指向终端,
 // fopen("/dev/stdin", "r+");      
  scanf("%d",&item);                //同时意味着/dev/stdin 也间接指向了终端
  printf("format2= %d\n",item);
}
```



```makefile
//变量定义
CC=gcc
ATRGET=./bin/main.exe
C_SOURCE=$(wildcard ./src/*.c) 
INCLUDE_PATH=-I ./include
LIBRARY_PATH=-L ./lib

//依赖规则，生成的可执行文件依赖项目中的所有源文件和头文件       
$(ATRGET):$(C_SOURCE) 
        $(CC) $^ -o $@ $(LIBRARY_PATH) $(INCLUDE_PATH)

//每次执行make，都展示一下依赖和被依赖关系，需要添加 clean 信息
clean:
        $(RM) $(ATRGET)


./bin/main.exe:./src/cpipe.c
        gcc -o ./bin/main.exe ./src/cpipe.c

```

