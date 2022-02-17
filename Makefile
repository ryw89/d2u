DESTDIR = /usr/local/bin

CC = gcc
CC_ARGS = -std=c99 -Wall -Werror -Wextra -Wpedantic -pedantic-errors
CC_CMD = $(CC) $(CC_ARGS)

C_FILES = d2u.c
O_FILES = has-cr.o

all: $(C_FILES) $(O_FILES)
	$(CC_CMD) $(CC_ARGS) $(C_FILES) $(O_FILES) -o d2u
	strip d2u

debug: $(C_FILES) $(O_FILES)
	$(CC_CMD) -gdwarf $(CC_ARGS) $(C_FILES) $(O_FILES) -o d2u-debug

has-cr.o: has-cr.asm
	nasm -f elf64 -g -F dwarf -O2 has-cr.asm

install: d2u
	install -m 755 d2u $(DESTDIR)

clean:
	rm -f has-cr.o d2u d2u-debug
