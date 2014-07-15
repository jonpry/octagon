#include <stdint.h>
#include <stdio.h>

#include "prcos.h"

int foo(int a, int b){
	if(a==2)
		return b | 0xabab;
	return b & 0xaaaa;	
}

void printn(int i){
	*(char*)0x8000000 = '0' + i;
}

void printdur(){
	int i;
	for(i=0; i < 10; i++){
		printn(i);
	}
}

char hello[] = "hel1o world!, i wonder if the dcache can't handle switching ways, or what the problem could possibly be";

void printfoo(){
	int i=0;
	char c=hello[i++];
	while(c){
		*(char*)0x8000000 = c;
		c=hello[i++];
	}
}

#define COUNT 1024

void cache_test(){
	unsigned *data = (unsigned*)0x10000;
	uint16_t lfsr = 0xACE1u;
	unsigned period;
	for(period = 0; period < COUNT; period++) 
	{
	  	/* taps: 16 14 13 11; feedback polynomial: x^16 + x^14 + x^13 + x^11 + 1 */
//		data[period<<2] = lfsr;    
//		data[(period<<2)+1] = lfsr>>1;    
//		data[(period<<2)+2] = lfsr&1;    
//		data[(period<<2)+3] = -(lfsr&1);    

		data[period] = lfsr;

  		lfsr = (lfsr >> 1) ^ (-(lfsr & 1u) & 0xB400u);
	}
}


uint32_t xor(){
	unsigned *data = (unsigned*)0x10000;
	uint32_t sum = 0;
	unsigned period;
	for(period = 0; period < COUNT; period++) 
	{
		sum = sum ^ data[period];
	}
	return sum;
}

uint32_t mul(uint32_t a, uint32_t b){
	return a*b;
}

uint32_t div2(uint32_t a, uint32_t b){
	return a/b;
}

void my_printf(const char *fmt, ...){
	char buf[128];

	va_list ap;
	va_start(ap, fmt);
	my_vsprintf(buf,fmt,ap);
	va_end(ap);

	printstr(buf);
}

int main(int tid){

	*(volatile unsigned*)0x8000000 = tid;
	*(volatile char*)0x8000000 = 'b';
	*(volatile short*)0x8000000 = 'c';

	unsigned blah = *(unsigned*)0x8000008;
	*(volatile unsigned*)0x8000000 = blah;

	term_init(tid);

	my_printf("Hello from Octagon!\n");

	my_printf("TID: %d, Bootin 'er Up.\n",tid);

	my_printf("Approximate Stack: 0x%8.8X\n", &blah);
	
	my_printf("foo: %d %d, 0x%X 0x%X\n", 5, 500, 0x20, 0xAABBCCDD);

	my_printf("2 x 6 is %d\n", mul(2,6));

	my_printf("13 / 2 is %d\n", div2(13,2));	

	printdur();

	cache_test();
	uint32_t sum = xor();

	my_printf("Hash test result: 0x%X\n", sum);

	*(volatile unsigned*)0x8000000 = sum;

	printfoo();

	foo(2,0xcdcd);
	foo(3,0xbbbb);

	dhry(1000);

	return 0;
}

/*
float mulf(float a, float b){
	return a*b;
}*/

char helloint[] = "hel1o from interrupt";

int intc(){
	int i=0;
	char c=helloint[i++];
	while(c){
		*(char*)0x8000000 = c;
		c=helloint[i++];
	}
}

char helloop[] = "hel1o from opcode";

int opc(unsigned rt, unsigned rs, unsigned t0){
	*(volatile unsigned*)0x8000000 = rt;
	*(volatile unsigned*)0x8000000 = rs;
	*(volatile unsigned*)0x8000000 = t0;

	int i=0;
	char c=helloop[i++];
	while(c){
		*(char*)0x8000000 = c;
		c=helloop[i++];
	}
}
