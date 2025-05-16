# hw11
Tyler Peacock
CMSC313 MW0830
build commands:
nasm -f elf32 -g -F dwarf -o asciihex.o asciihex.asm
ld -m elf_i386 -o asciihex asciihex.o
This code takes in bytes and outputs the bytes similar to a hex dump by converting each byte to ascii characters
eax stores the bytes, ebx stores the masked data, ecx counts how many chars have been added and functions as a loop variable
edx counts the number of bytes in outputBuf to be printed out at the end
Each conversion loop the program will check if ecx is even or odd in order to know when to add spaces
pushing and popping the stack only controls how many times the conversion logic will run, in this program we only need 2 loops. 
I used magic numbers frequently because my assembly knowledge is still not very good yet
Theres definitely a better way to do it but tbh i just needed to finish this assignment sorry
Once all the bytes have been converted to ascii and put in outputBuf, add a linefeed char and call syswrite
