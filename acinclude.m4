AC_DEFUN([AC_CHECK_EXTRA_OPTIONS],[
## debug arg
	AC_MSG_CHECKING(for debugging)
	AC_ARG_ENABLE(debug, [  --enable-debug          compile for debugging, default yes])
	if test -z "$enable_debug" ; then
		CFLAGS="-g -D_DEBUG -Wall"
		CXXFLAGS="-g -D_DEBUG -Wall"
	elif test $enable_debug = "yes" ; then
		CFLAGS="-g -D_DEBUG -Wall"
		CXXFLAGS="-g -D_DEBUG -Wall"
	else
		CFLAGS="-g -O2 -DNDEBUG -Wall"
		CXXFLAGS="-g -O2 -DNDEBUG -Wall"
	fi
	AC_MSG_RESULT([$enable_debug])

##gtest
	AC_ARG_WITH([gtest],
		[AS_HELP_STRING([--with-gtest],
			[location of the gtest, defaults to /usr])],
		[GTEST_HOME="$withval"],
		[GTEST_HOME='/usr'])
	AC_SUBST([GTEST_HOME])
	GTEST_PARSER_H="$GTEST_HOME/include/gtest/gtest.h"
	if test -f "$GTEST_PARSER_H"; then
		GTEST_CPPFLAGS="-I$GTEST_HOME/include"
		GTEST_LDFLAGS=""
		GTEST_LIBS="$GTEST_HOME/lib/libgtest_main.la"
		AC_SUBST(GTEST_CPPFLAGS)
		AC_SUBST(GTEST_LDFLAGS)
		AC_SUBST(GTEST_LIBS)
	else
		AC_MSG_ERROR([cannot find gtest in $GTEST_HOME, check --with-gtest])
	fi

])
