# Makefile for extreme speed (Linux/macOS + clang/gcc)
CC ?= clang
CFLAGS ?= -O3 -march=native -mtune=native -flto -fomit-frame-pointer -fno-stack-protector -ffast-math -funroll-loops -s -fasm-blocks

all: minphp

minphp: minphp.c
	$(CC) $(CFLAGS) minphp.c -o minphp
	@echo "Built ./minphp - ultra fast PoC"

clean:
	rm -f minphp minphp.exe

test: minphp
	@echo '=== Running PoC on test.php ==='
	@./minphp test.php
	@echo ''
	@echo '=== Expected: Hallo Welt! (no newline) ==='

.PHONY: all clean test
