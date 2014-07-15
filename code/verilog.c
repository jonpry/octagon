#include <stdio.h>
#include <stdlib.h>

#define BURST_LEN 4

void writeburst(FILE* f, unsigned *burst){
	int i,j,word,bit;
	for(i=BURST_LEN-1; i >= 0; i--){
		word = burst[i];
		for(j=31; j >= 0; j--){
			bit = (word >> j) & 1;
			fprintf(f,"%d",bit);
		}
	}
	fprintf(f,"\n");
}


int main(){
	FILE* fin = fopen("main.bin","r");
	FILE* fout = fopen("memory.list","w");
	if(!fin || !fout){
		printf("Could not open files\n");
		return 0;
	}	

	unsigned burst[BURST_LEN];
	unsigned burstidx = 0;

	while(fread(&burst[burstidx],1,4,fin)){

		if(burstidx < BURST_LEN-1)
			burstidx++;
		else{
			burstidx=0;
			writeburst(fout,burst);
		}
	}

	if(burstidx)
		writeburst(fout,burst);

	fclose(fin);
	fclose(fout);


	return 0;
}
