CSOUND		= -lcsound64 -lcsnd6
INCLUDES    = -I/usr/include/csound/
SRC		    = src/iydhoti.cpp
CC			= g++

iydhoti: $(SRC) 
	$(CC) $(INCLUDES) $(SRC) $(CSOUND) -o iydhoti


