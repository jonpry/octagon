#ifndef PRCOS_H
#define PRCOS_H

#define va_list __builtin_va_list
#define va_start __builtin_va_start
#define va_arg __builtin_va_arg
#define va_end __builtin_va_end

void dhry (int n);

void cinv_dcache(void* adr);
void clean_dcache(void* adr);
unsigned get_tid();

void my_sprintf(char* buf, const char *fmt, ...);
void my_vsprintf(char* buf, char const *fmt, va_list ap);

int strcomp(const char *s1, const char *s2);
char *strcopy(char *dst, const char *src);

void printstr(const char* str);

#define TERM_BASE (1024*1024)
#define TERM_BUF  4096
#define TERM_ALIGN (8*1024) //8kb per half channel

#endif
