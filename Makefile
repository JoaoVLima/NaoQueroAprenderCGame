CC = g++
CFLAGS = -Wall -std=c++17
LIBS = -lraylib -lGL -lm -lpthread -ldl -lrt -lX11

all:
	$(CC) main.cpp -o game $(CFLAGS) $(LIBS)

run:
	./game

clean:
	rm -f game