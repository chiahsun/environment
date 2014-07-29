SRCS = $(wildcard *.cpp)
OBJS = $(patsubst %.cpp, %.o, $(SRCS))
EXES = $(patsubst %.cc, %.out, $(wildcard *.cc))
EXE_OBJS = $(patsubst %.cc, %.o, $(wildcard *.cc))
DEPENDS = $(patsubst %.cc, %.d, $(wildcard *.cc))
DEPENDS += $(patsubst %.cpp, %.d, $(wildcard *.cpp))


EXT_INC=$(patsubst %, -I%, $(EXT_PKGS)) $(patsubst %, -I%, $(EXT_INCS)) 
EXT_LIB=$(patsubst %, -L%, $(EXT_PKGS))
EXT_LIB_FLAGS=$(foreach x, $(EXT_PKGS), -l$(shell basename $x))

PKG_IFLAGS=$(EXT_INC)
PKG_LFLAGS=$(EXT_LIB) $(EXT_LIB_FLAGS)

CXX = g++ $(PKG_IFLAGS) 
# CFLAGS = -Wall -pedantic -Wextra -Wconversion -Wno-cpp

CFLAGS = -pedantic -Wall -Wextra -Wcast-align -Wcast-qual -Wctor-dtor-privacy -Wdisabled-optimization -Wformat=2 -Winit-self -Wmissing-include-dirs -Wold-style-cast -Woverloaded-virtual -Wredundant-decls -Wshadow -Wsign-promo -Wswitch-default -Wundef -Wno-unused -Wno-language-extension-token# -Werror -Wnoexcept -Wsign-conversion -Wstrict-overflow=5 -Wlogical -Wmissing-declarations

mode = debug
# CFLAGS = -g -Wall -O0 -pedantic 
ifeq ($(mode), debug)
    CFLAGS += -O0 -g
else ifeq ($(mode), test)
    CFLAGS += -O2 -g
else ifeq ($(mode), release)
    CFLAGS += -O2 
else
$(error Unknown mode please check)
endif
# CFLAGS = -g -Wall -O0 -pedantic -D USE_STL=

LFLAGS = $(PKG_LFLAGS)

.SUFFIXES : .cpp .o .cc .d

all : $(EXES)

clean :
	rm -f $(OBJS) $(EXES) $(EXE_OBJS) $(DEPENDS)

ifneq ($(MAKECMDGOALS), clean)
-include $(DEPENDS)
endif

.cpp.d :
	$(CXX) -MM -MG "$<" | sed -e 's@^\(.*\)\.o:@\1.d \1.o:@' > $@	

.cc.d : 
	$(CXX) -MM -MG "$<" | sed -e 's@^\(.*\)\.o:@\1.d \1.o:@' > $@	

.cpp.o :
	$(CXX) $(CFLAGS) -c -o $@ $<

.cc.o :
	$(CXX) $(CFLAGS) -c -o $@ $<

%.out : %.o $(OBJS)
	$(CXX) $(CFLAGS) -o $@ $^ $(LFLAGS) 
