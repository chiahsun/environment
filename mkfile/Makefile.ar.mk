SRCS = $(wildcard *.cpp)
OBJS = $(patsubst %.cpp, %.o, $(SRCS))
EXES = $(patsubst %.cc, %.out, $(wildcard *.cc))
EXE_OBJS = $(patsubst %.cc, %.o, $(wildcard *.cc))

AR_OBJS=$(filter-out $(EXE_OBJS), $(OBJS))

AR= ar crs
SHELL := /bin/bash
BASENAME := $(shell basename $(shell pwd))

LIB_NAME=lib$(BASENAME).a

all : $(LIB_NAME)

$(LIB_NAME) : $(AR_OBJS)
	$(AR) $@ $^

clean :
	rm -f $(LIB_NAME)
