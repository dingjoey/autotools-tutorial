#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.63])
AC_INIT([jupiter], [1.0.0], [BUG-REPORT-ADDRESS])
AC_CONFIG_SRCDIR([src/jupiter/main/main.c])
AC_CONFIG_HEADERS([config.h])
AM_INIT_AUTOMAKE

# Checks for programs.
AC_PROG_CC
AC_PROG_CXX
AC_PROG_RANLIB #使用archive library即.a静态库后运行automake提示需要检查这个

# Checks for libraries.

# Checks for header files.
# PCA惯例 configure.ac中只检查二方库的依赖头文件和库
AC_CHECK_HEADERS([pthread.h])

# Checks for library functions.
# FIXME: Replace `main' with a function in `-lpthread':
AC_CHECK_LIB([pthread], [main])

# Checks for typedefs, structures, and compiler characteristics.


AC_CONFIG_FILES([Makefile
                 src/jupiter/Makefile
                 src/jupiter/common/Makefile
                 src/jupiter/main/Makefile])
AC_OUTPUT
