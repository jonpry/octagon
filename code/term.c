#include <stdint.h>

#include "prcos.h"

void term_init_half(unsigned term){
	volatile uint32_t *head = (uint32_t*)(term);
	volatile uint32_t *tail = (uint32_t*)(term + 64);

	*head = 0;
	*tail = 0;

	clean_dcache((uint32_t*)(term));
	clean_dcache((uint32_t*)(term+64));
}

void term_init(int tid){
	term_init_half(TERM_BASE + 2*tid*TERM_ALIGN);
	term_init_half(TERM_BASE + (2*tid+1)*TERM_ALIGN);
}

//TODO: this looks hideous, clean it up
void printstr(const char* str){
	unsigned count=0;
	int i;
	unsigned tid = get_tid();
	unsigned idx = *(unsigned*)(2*tid*TERM_ALIGN + TERM_BASE);
	char *data = (char*)(TERM_BASE + (2*tid*TERM_ALIGN) + 128);
	while(*str){
		data[(idx+count++)%TERM_BUF] = *str++;
	}

	for(i=0; i < count; i+=64){
		clean_dcache(&data[(idx+i)%TERM_BUF]);
	}

	if( ((unsigned)&data[(idx+i-64)%TERM_BUF]) >> 6 != ((unsigned)&data[(idx+count)%TERM_BUF]) >> 6)
		clean_dcache(&data[(idx+count)%TERM_BUF]);
	idx+=count;
	*(unsigned*)(2*tid*TERM_ALIGN + TERM_BASE) = idx%TERM_BUF;
	clean_dcache((void*)(2*tid*TERM_ALIGN + TERM_BASE));
}
