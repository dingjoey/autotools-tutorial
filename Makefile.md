## 手动调用各个Autotools工具完成工程构建 ##

### 步骤 ###
1. 完成程序

2. 完成对应构建的Makefile.am

3. 运行autoscan 生成configure.scan  
    - 初始化autoconf： 
    ```
        AC_INIT
    ```
    - 定义项目目录： 
    ``` 
        AC_CONFIG_SRCDIR
    ```
    - 为生成config.h配置准备:
    ```
        AC_CONFIG_HEADERS
        AC_CHECK_HEADERS
        #PCA的Autotools用法中不在configure.ac中定义三方库依赖的头文件和库是否存在
        #PCA只是利用AC_CHECK_HEADERS; AC_CHECK_LIB 检查二方库依赖比如pthread等等依赖
        #原因：整个程序部署时，没有将依赖安装在系统默认位置；所以一般在acinclude.m4中自定义检查逻辑
    ```
    - 为生成Makefile配置准备：
    ```
        AC_CONFIG_FILES    
    ```

4. 运行aclocal 
    > 运行automake之前一定要先运行aclocal，不然automake不认识aoncfigure.ac中用到的Automake定义的M4宏
    > 

5. 运行autoheader生成config.h.in；根据要求修改


6. 运行automake 生成Makefile.in和其他一下GNU标准要求的文件
    ```
        automake -vacf
        # -v verbose
        # -a add missing
        # -c copy
        # -f force
    ```

7. 运行autoconf生成configure脚本

------

### 一张图 ###

![image](./assets生成Makefile流程图.gif)

------

### 神图 ###

```
1.autoscan (autoconf): 扫描源代码以搜寻普通的可移植性问题，比如检查编译器，库，头文件等，生成文件configure.scan,它是configure.ac的一个雏形。
2.aclocal (automake):根据已经安装的宏，用户定义宏和acinclude.m4文件中的宏将configure.ac文件所需要的宏集中定义到文件 aclocal.m4中。aclocal是一个perl 脚本程序，它的定义是：“aclocal - create aclocal.m4 by scanning configure.ac”
 
user input files   optional input     process          output files
================   ==============     =======          ============
 
                    acinclude.m4 - - - - -.
                                          V
                                      .-------,
configure.ac ------------------------>|aclocal|
                 {user macro files} ->|       |------> aclocal.m4
                                      `-------'
3.autoheader(autoconf): 根据configure.ac中的某些宏，比如cpp宏定义，运行m4，声称config.h.in
 
user input files    optional input     process          output files
================    ==============     =======          ============
 
                    aclocal.m4 - - - - - - - .
                                             |
                                             V
                                     .----------,
configure.ac ----------------------->|autoheader|----> autoconfig.h.in
                                     `----------'
4.automake: automake将Makefile.am中定义的结构建立Makefile.in，然后configure脚本将生成的Makefile.in文件转换为Makefile。如果在configure.ac中定义了一些特殊的宏，比如AC_PROG_LIBTOOL，它会调用libtoolize，否则它会自己产生config.guess和config.sub
 
user input files   optional input   processes          output files
================   ==============   =========          ============
 
                                     .--------,
                                     |        | - - -> COPYING
                                     |        | - - -> INSTALL
                                     |        |------> install-sh
                                     |        |------> missing
                                     |automake|------> mkinstalldirs
configure.ac ----------------------->|        |
Makefile.am  ----------------------->|        |------> Makefile.in
                                     |        |------> stamp-h.in
                                 .---+        | - - -> config.guess
                                 |   |        | - - -> config.sub
                                 |   `------+-'
                                 |          | - - - -> config.guess
                                 |libtoolize| - - - -> config.sub
                                 |          |--------> ltmain.sh
                                 |          |--------> ltconfig
                                 `----------'
5.autoconf:将configure.ac中的宏展开，生成configure脚本。这个过程可能要用到aclocal.m4中定义的宏。
 
user input files   optional input   processes          output files
================   ==============   =========          ============
 
                   aclocal.m4 - - - - - -.
                                         V
                                     .--------,
configure.ac ----------------------->|autoconf|------> configure ----->autoconfig.h,Makefile
```

