AUTOMAKE_OPTIONS = foreign

#AM_xxx全局的automake build变量
AM_CPPFLAGS = -I$(top_srcdir)/src \
				$(NULL)
AM_CXXFLAGS = $(NULL)
AM_CFLGAS = $(NULL) 
AM_LDFLAGS = $(NULL) 


bin_PROGRAMS = jupiter
jupiter_SOURCES = main.c
jupiter_CPPFLAGS = $(AM_CPPFLAGS) $(NULL)
jupiter_CFLAGS = $(NULL)
jupiter_CXXLAGS = $(NULL)
jupiter_LDFLAGS = $(NULL)
jupiter_LDADD =	$(top_srcdir)/src/client/libjupclient.la \
				$(NULL)


