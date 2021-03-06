#
#  Unix Makefile
#
#	native build:	make clseek
#	cross-compile:	make CC=arm-arago-linux-gnueabi-gcc AR=arm-arago-linux-gnueabi-ar clseek
#

# .PHONY: all default
.PHONY: lib

# ~~~

USR_CFLAGS= -DSTDC_HEADERS=1 -DHAVE_STRING_H=1
CFLAGS	= -g $(USR_CFLAGS)

# ~~~

SRC_DIRINFO	=	\
	mygetopt.c	\
	dirinfo_drv.c	\
	dirinfo.c
#	finddir.c
SRC_WHICH	=	\
	which.c		\
	mygetopt.c	\
	dirinfo.c
SRC_ISEMPTY	=	\
	isempty.c	\
	mygetopt.c	\
	dirinfo.c
SRC_LIBTD	=	\
	mygetopt.c	\
	mystropt.c	\
	regex.c		\
	dirinfo.c
SRC_CLSEEK	=	\
	CLSeek.c

LIBtd	= libtd.a

OBJ_DIRINFO	=$(SRC_DIRINFO:.c=.o)
OBJ_WHICH	=$(patsubst %.c,%.o,$(SRC_WHICH))
OBJ_ISEMPTY	=$(patsubst %.c,%.o,$(SRC_ISEMPTY))
OBJ_LIBTD	=$(SRC_LIBTD:.c=.o)
OBJ_CLSEEK	=$(SRC_CLSEEK:.c=.o)


#
OBJS=	\
	$(OBJ_DIRINFO)	\
	$(OBJ_WHICH)	\
	$(OBJ_ISEMPTY)	\
	$(OBJ_LIBTD)	\
	$(OBJ_CLSEEK)
LIBS=	$(LIBtd)

# ~~~

#
# $@	: the target
# $<	: the dependent
# $^	: ALL dependents
#

dirinfo:	$(OBJ_DIRINFO)
	@echo building $@
	$(CC) $(CFLAGS) -o $@ $^

which:	$(OBJ_WHICH)
	@echo building $@
	$(CC) $(CFLAGS) -o $@ $^

isempty:	$(OBJ_ISEMPTY)
	@echo building $@
	$(CC) $(CFLAGS) -o $@ $^

lib:	$(LIBtd)
$(LIBtd):	$(OBJ_LIBTD)
	@echo building $@
	$(AR) -rc $@ $^

clseek:	$(OBJ_CLSEEK) $(LIBtd)
	@echo building $@
	$(CC) $(CFLAGS) -o $@ $^

# ~~~

clean:
	$(RM) -v $(OBJS)

clean-all:	clean
	$(RM) -v $(LIBS)
#	$(RM) -v $(EXES)
	$(RM) -rv *.dSYM *.exe

# ~~~

# dependency
mygetopt.o:	mygetopt.c mygetopt.h
mystropt.o:	mystropt.c mystropt.h
regex.o:	regex.c
dirinfo.o:	dirinfo.c dirinfo.h mygetopt.h
CLSeek.o:	CLSeek.c
CLSync.o:	CLSync.c

