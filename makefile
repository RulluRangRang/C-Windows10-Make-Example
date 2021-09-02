CC=gcc
CFLAGS=-g -Wall
TARGET=main.exe
OBJS=main.o

$(TARGET): $(OBJS)
	$(CC) -o $@ $(OBJS)

main.o : main.c
	$(CC) -c main.c

clean:
	powershell "(Remove-Item -ErrorAction Ignore ${OBJS}, ${TARGET})"
# rm $(OBJECT) $(TARGET)