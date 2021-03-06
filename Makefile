COMMON	= ../common

DBG      ?=
CXX      ?= g++
CXXFLAGS  = -O3 -I. -std=c++11 -I$(COMMON) $(DBG)

ifeq ($(CXX),icpc)
  CXXFLAGS += -xHost #-no-vec
  CXXFLAGS += -qopt-report=5
  CXXFLAGS += -Wunknown-pragmas # Disable warning about OpenMP pragma no defined.
endif

ifeq ($(CXX),g++)
  CXXFLAGS += -mtune=native -march=native
endif

EXEC = nbody3

all: $(EXEC)

# Load common make options
include $(COMMON)/Makefile.common
LDFLAGS	  = $(COMMON_LIBS)

nbody3.o: nbody3.cpp
	$(CXX) $(CXXFLAGS) -c nbody3.cpp

nbody3: nbody3.o $(COMMON_OBJS)
	$(CXX) $(CXXFLAGS) -o nbody3 nbody3.o $(COMMON_OBJS) $(LDFLAGS)

clean: clean_common
	/bin/rm -fv $(EXEC) *.o *.optrpt
