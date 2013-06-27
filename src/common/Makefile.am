AUTOMAKE_OPTIONS = foreign 

#AM_xxx全局的automake build变量
AM_CPPFLAGS = -I$(top_srcdir)/src \
				$(NULL)
AM_CXXFLAGS = $(NULL)
AM_CFLGAS = $(NULL) 
AM_LDFLAGS = $(NULL) 

#使用libtoolize 构建工程内部工具库 不需要发布安装
noinst_LTLIBRARIES = libjupcommon.la
libjupcommon_la_SOURCES = jupcommon.h print.c caculate.c
libjupcommon_la_CPPFLAGS =  $(AM_CPPFLAGS) $(NULL)
libjupcommon_la_CFLAGS =  $(AM_CFLAGS) $(NULL)
libjupcommon_la_CXXFLAGS =  $(AM_CXXFLAGS) $(NULL)
libjupcommon_la_LDFLAGS =  $(AM_LDFLAGS) $(NULL)
