RM        := /bin/rm -rf
SIM       := ./sim
CC        := g++
CFLAGS    := -lz -O3 -lm  -W -Wall -Wno-deprecated -Wno-unused-parameter -Wno-unused-but-set-variable
DFLAGS    :=  -O0 -g -fsanitize=address -fno-omit-frame-pointer
PFLAGS    := -pg




all: 
	${CC} ${CFLAGS} tracker.cpp sim.cpp  -o ${SIM}

dbg: 
	${CC} ${CFLAGS} ${DFLAGS} tracker.cpp sim.cpp -o ${SIM}

clean: 
	$(RM) ${SIM} *.o
