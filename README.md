# Pearce Packman: CMSC 313 Homework 11

## Overview
This assignment is a 32-bit Linux program that converts bytes into two-digit ASCII hex and prints the result to the screen.

## Example Output
83 6A 88 DE 9A C3 54 9A  

Output prints each byte as hex characters followed by a space, then prints a newline.

## Files
- hw11.asm: NASM source file
- hw11.o: Assembled object file
- hw11: Executable binary

## Extra Credit
A subroutine is used to convert a 4-bit value to ASCII.

## How to Compile and Run the Program (Linux or GL Server)
nasm -f elf32 -o hw11.o hw11.asm  
ld -m elf_i386 -o hw11 hw11.o  
./hw11
