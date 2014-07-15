
#include <sys/types.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <stdarg.h>
#include <assert.h>
#include <errno.h>

char *strchar(char *str, int character){
	while(*str){
		if(*str == character)
			return str;
		str++;
	}
	if(*str == character)
		return str;
	return 0;
}

int strcomp(const char *s1, const char *s2) {
  int ret = 0;
  while (!(ret = *(unsigned char *) s1 - *(unsigned char *) s2) && *s2) ++s1, ++s2;

  if (ret < 0) {
    ret = -1;
  } else if (ret > 0) {
    ret = 1 ;
  }

  return ret;
}


char *strcopy(char *dst, const char *src) {
  char *cp = dst;
  while (*cp++ = *src++);
  return dst;
}
