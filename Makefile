all: vmidle.sys

vmidle.sys: vmidle.asm
	nasm -o vmidle.sys -O0 vmidle.asm

clean:
	del /q vmidle.sys
