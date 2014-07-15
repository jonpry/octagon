#!/bin/sh
mipsel-linux-gnu-gcc-4.7 -c main.c -o main.o -march=mips1 -mno-mips16 -msoft-float -O1 -fno-delayed-branch  -mno-check-zero-division
mipsel-linux-gnu-gcc-4.7 -c sprintf.c -o sprintf.o -march=mips1 -mno-mips16 -msoft-float -O1 -fno-delayed-branch  -mno-check-zero-division
mipsel-linux-gnu-gcc-4.7 -c str.c -o str.o -march=mips1 -mno-mips16 -msoft-float -O1 -fno-delayed-branch  -mno-check-zero-division
mipsel-linux-gnu-gcc-4.7 -c dhry_1.c -o dhry_1.o -march=mips1 -mno-mips16 -msoft-float -O1 -fno-delayed-branch  -mno-check-zero-division
mipsel-linux-gnu-gcc-4.7 -c dhry_2.c -o dhry_2.o -march=mips1 -mno-mips16 -msoft-float -O1 -fno-delayed-branch  -mno-check-zero-division
mipsel-linux-gnu-gcc-4.7 -c term.c -o term.o -march=mips1 -mno-mips16 -msoft-float -O1 -fno-delayed-branch  -mno-check-zero-division
mipsel-linux-gnu-gcc-4.7 -c head.S -o head.o -march=mips32 -mno-mips16 -msoft-float -mno-check-zero-division
mipsel-linux-gnu-gcc-4.7 -c div.S -o div.o -march=mips32 -mno-mips16 -msoft-float -mno-check-zero-division
mipsel-linux-gnu-gcc-4.7 -c opcodes.S -o opcodes.o -march=mips32 -mno-mips16 -msoft-float -mno-check-zero-division
mipsel-linux-gnu-ld -o main.elf head.o div.o opcodes.o main.o sprintf.o str.o term.o dhry_1.o dhry_2.o -static -T link.lds 
mipsel-linux-gnu-objcopy main.elf -O binary main.bin
mipsel-linux-gnu-objdump -D main.elf > main.S
