#include <stdint.h>
#include <stdio.h>

#define COUNT 1024

void main(){
	unsigned data[1024];
	uint16_t lfsr = 0xACE1u;
	unsigned period;
	for(period = 0; period < COUNT; period++) 
	{
	  	/* taps: 16 14 13 11; feedback polynomial: x^16 + x^14 + x^13 + x^11 + 1 */
		printf("%4.4X: %X %X %X\n", period*4+0x2000,lfsr, lfsr >> 1, -(lfsr & 1u));
		data[period] = lfsr;    
  		lfsr = (lfsr >> 1) ^ (-(lfsr & 1u) & 0xB400u);
	}

	unsigned sum =0;
	for(period=0; period < COUNT; period++){
		sum = sum ^ data[period];
	}

	printf("Hash: %8.8X\n", sum);
}

/*
ace1
e270
c538
d69c*/
