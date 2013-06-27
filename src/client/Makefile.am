AUTOMAKE_OPTIONS = foreign

#AM_xxx全局的automake build变量
AM_CPPFLAGS = -I$(top_srcdir)/src \
				$(NULL)
AM_CXXFLAGS = $(NULL)
AM_CFLGAS = $(NULL) 
AM_LDFLAGS = -fPIC -lstdc++ 


# 构建一个需要发布的so 用作jupiter的client
lib_LTLIBRARIES = libjupclient.la 

# client库源码client.c 
libjupclient_la_SOURCES = jupiterclient.h client.c
libjupclient_la_CPPFLAGS =  $(AM_CPPFLAGS) $(NULL)
libjupclient_la_LDFLAGS =  $(AM_LDFLAGS) -static $(NULL)
# 依赖内部工具库libjupcommon.la
libjupclient_la_LIBADD = $(top_srcdir)/src/common/libjupcommon.la
# 指定要发布的la的对应发布头文件 
libjupclientincludedir = $(includedir)/@PACKAGE_NAME@/client
libjupclientinclude_HEADERS = jupiterclient.h


check_PROGRAMS = client_test
client_test_SOURCES = client_test.cc
client_test_CPPFLAGS = $(AM_CPPFLAGS) \
					   $(GTEST_CPPFLAGS)\
					   $(NULL)
client_test_LDFLAGS = $(AM_LDFLAGS)\
					  $(GTEST_LDFLAGS)\
					  -static\
					  $(NULL)
client_test_LDADD = $(GTEST_LIBS)\
					$(top_srcdir)/src/client/libjupclient.la\
					$(NULL)

TESTS = $(check_PROGRAMS)
