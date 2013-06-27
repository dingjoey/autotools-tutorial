## 常见的构建任务 outline##
- 组织工程的方式
    - 工程源目录结构
    - exmpale

- 构建相关
    - 利用Libtool构建发布的动态库
    - 利用Libtool构建内部静态库
    - 利用Automake原始primary构建program
    - 利用Automake原始primary构建单元测试TESTS nonist_program

- 依赖配置化
    - 一般来说项目依赖安装在系统路径中是OK的
    - 如果以来安装在自定义位置如何进行配置?
        - ./configure时指定CPPFLAGS, LDFLAGS
        - 利用M4宏，添加-with-deps的配置选项进行配置

- 依赖下载安装自动化
    - 提供脚本下载所有需要的依赖
------

## 常见的构建任务 details##
- 组织工程的方式
    - 工程源目录结构
    ```
        src/
           Makfile.am
           componentA/
                     src.c
                     header.h
                     Makfile.am
           componentB/
                     src.c
                     header.h
                     Makfile.am
    ```
    - exmpale
    ```
        src/
        ├── client
        │   ├── client.c
        │   ├── jupiterclient.h
        │   ├── Makefile.am
        │   ├── Makefile.in
        │   └── test_client.c
        ├── common
        │   ├── caculate.c
        │   ├── jupcommon.h
        │   ├── Makefile.am
        │   ├── Makefile.in
        │   └── print.c
        ├── main
        │   ├── main.c
        │   ├── Makefile.am
        │   └── Makefile.in
        ├── Makefile.am
        └── Makefile.in
    ```
------

- 构建相关
    - 利用Libtool构建发布的动态库步骤如下:
        - 使用Libtool在configure.ac中的配置:AC_PROG_LIBTOOL
    
        - 编写对应要构建成so的组件目录中Makefile.am
            1. 指明构建库，并且使用libool来构建（lib_xxx_LTLIBRARIES， lib就已经指明了以后的安装路径$(libdir)==$(prefix)/dir）
            ```
                lib_LTLIBRARIES = libjupclient.la
            
            ```
            2. 指明源码和头文件（xxx_la_SOURCES）（注意一定要包括要发布的头文件）
            ```
                libjupclient_la_SOURCES = jupiterclient.h client.c
            
            ```
            3. 指明要发布的头文件和安装的路径(xxxincludedir : 指定头文件的安装路径)(xxxinclude_HEADERS: 指明需要发布的头文件)
            ```
                libjupclientincludedir = $(includedir)/@PACKAGE_NAME@/client
                libjupclientinclude_HEADERS = jupiterclient.h
            ```
            4. 指明其本身依赖的静态库
            ```
                libjupclient_la_LIBADD = $(top_srcdir)/src/common/libjupcommon.la
            
            ```
            5. 指明编译参数
            ```
                libjupclient_la_CPPFLAGS =  $(AM_CPPFLAGS) $(NULL)
            
                libjupclient_la_CFLAGS =  $(AM_CFLAGS) $(NULL)    
                libjupclient_la_CXXFLAGS =  $(AM_CXXFLAGS) $(NULL)
            
                libjupclient_la_LDFLAGS =  $(AM_LDFLAGS) $(NULL) #依赖的动态库 和搜索路径
            ```    
        - example:
            ```
                 11 # 构建一个需要发布的so 用作jupiter的client
                 12 lib_LTLIBRARIES = libjupclient.la
                 13 
                 14 # client库源码client.c 
                 15 libjupclient_la_SOURCES = jupiterclient.h client.c
                 16 libjupclient_la_CPPFLAGS =  $(AM_CPPFLAGS) $(NULL)
                 17 libjupclient_la_CFLAGS =  $(AM_CFLAGS) $(NULL)
                 18 libjupclient_la_CXXFLAGS =  $(AM_CXXFLAGS) $(NULL)
                 19 libjupclient_la_LDFLAGS =  $(AM_LDFLAGS) $(NULL)
                 20 # 依赖内部工具库libjupcommon.la
                 21 libjupclient_la_LIBADD = $(top_srcdir)/src/common/libjupcommon.la
                 22 # 指定要发布的la的对应发布头文件 
                 23 libjupclientincludedir = $(includedir)/@PACKAGE_NAME@/client
                 24 libjupclientinclude_HEADERS = jupiterclient.h
            ```
    - 利用Libtool构建内部静态库
        - 类似于使用Libtool构建需要发布的动态库，但是更加简单:
            - 不需要指明发布的头文件和安装路径
            - 库本身不需要install_location（lib_）的前缀，而是使用noninst_的前缀
        - example:
            ```
                 10 #使用libtoolize 构建工程内部工具库 不需要发布安装
                 11 noinst_LTLIBRARIES = libjupcommon.la
                 12 libjupcommon_la_SOURCES = jupcommon.h print.c caculate.c
                 13 libjupcommon_la_CPPFLAGS =  $(AM_CPPFLAGS) $(NULL)
                 14 libjupcommon_la_CFLAGS =  $(AM_CFLAGS) $(NULL)
                 15 libjupcommon_la_CXXFLAGS =  $(AM_CXXFLAGS) $(NULL)
                 16 libjupcommon_la_LDFLAGS =  $(AM_LDFLAGS) $(NULL)
            ```
        
    - 利用Automake原始primary构建program
        - steps:
            1. 指明program 使用前缀指明安装位置比如 bin_
            2. 指明编译参数 program_CPPFLAGS/CFLAGS CXXFLAGS/LIBADD/LDFALGS
    
        - example:
            ```
             11 bin_PROGRAMS = jupiter
             12 jupiter_SOURCES = main.c
             13 jupiter_CPPFLAGS = $(AM_CPPFLAGS) $(NULL)
             14 jupiter_CFLAGS = $(NULL)
             15 jupiter_CXXLAGS = $(NULL)
             16 jupiter_LDFLAGS = $(NULL)
             17 jupiter_LDADD = $(top_srcdir)/src/common/libjupcommon.la \
             18                 $(NULL)
            ```

    - 利用Automake原始primary构建单元测试TESTS nonist_program

------

- 依赖配置化
    - 一般来说项目依赖安装在系统路径中是OK的
    - 如果以来安装在自定义位置如何进行配置?
        - ./configure时指定CPPFLAGS, CFLGAS, LDFLAGS
        - 利用M4宏，添加-with-deps的配置选项进行配置，本质上还是设置CPPFLAGS CFLAGS LDFLAGS等
    - steps:
        - **acinclude.m4中使用AC_DEFUN定义宏AC_CHECK_EXTR_OPTIONS,在configure.ac中调用**
        - 根据--with-xx传入的值设置XXX_HOME
        - 设置XXX_PARSER_H根据依赖的头文件来检查依赖是否存在
        - 如果依赖存在则设置XXX_CFLGAS GTEST_LIBS
        - 如果依赖不存在则AC_MSG_ERROR
    - exmpale:
        ```
              2 ## debug arg
              3     AC_MSG_CHECKING(for debugging)
              4     AC_ARG_ENABLE(debug, [  --enable-debug          compile for debugging, default yes])
              5     if test -z "$enable_debug" ; then
              6         CFLAGS="-g -D_DEBUG -Wall"
              7         CXXFLAGS="-g -D_DEBUG -Wall"
              8     elif test $enable_debug = "yes" ; then
              9         CFLAGS="-g -D_DEBUG -Wall"
             10         CXXFLAGS="-g -D_DEBUG -Wall"
             11     else
             12         CFLAGS="-g -O2 -DNDEBUG -Wall"
             13         CXXFLAGS="-g -O2 -DNDEBUG -Wall"
             14     fi
             15     AC_MSG_RESULT([$enable_debug])
        ```
        
        ```
             17 ##gtest
             18     AC_ARG_WITH([gtest],
             19         [AS_HELP_STRING([--with-gtest],
             20             [location of the gtest, defaults to /usr])],
             21         [GTEST_HOME="$withval"],
             22         [GTEST_HOME='/usr'])
             23     AC_SUBST([GTEST_HOME])
             24     GTEST_PARSER_H="$GTEST_HOME/include/gtest/gtest.h"
             25     if test -f "$GTEST_PARSER_H"; then
             26         GTEST_CPPFLAGS="-I$GTEST_HOME/include"
             27         GTEST_LDFLAGS=$(NULL)
             28         GTEST_LIBS="$GTEST_HOME/lib/libgtest_main.la"
             29         AC_SUBST(GTEST_CPPFLAGS)
             30         AC_SUBST(GTEST_LDFLAGS)
             31         AC_SUBST(GTEST_LIBS)
             32     else
             33         AC_MSG_ERROR([cannot find gtest in $GTEST_HOME, check --with-gtest])
             34     fi
        ```
             
        ```
             36 ##json 
             37     AC_ARG_WITH([json],
             38         [AS_HELP_STRING([--with-json],
             39             [location of the json, defaults to /usr])],
             40         [JSON_HOME="$withval"],
             41         [JSON_HOME='/usr'])
             42     AC_SUBST([JSON_HOME])
             43     JSON_PARSER_H="$JSON_HOME/include/json/json.h"
             44     if test -f "$JSON_PARSER_H"; then
             45         JSON_CPPFLAGS="-I$JSON_HOME/include/json"
             46         JSON_LDFLAGS="-L$JSON_HOME/lib64"
             47         JSON_LIBS="-ljson"
             48         AC_SUBST(JSON_CPPFLAGS)
             49         AC_SUBST(JSON_LDFLAGS)
             50         AC_SUBST(JSON_LIBS)
             51     else
             52         AC_MSG_ERROR([cannot find json in $JSON_HOME, check --with-json])
             53     fi
        ```


