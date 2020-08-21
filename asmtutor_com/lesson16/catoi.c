/* ascii to int
 * reads all args
 * prints the sum as int
 *
 */

#include <stdio.h>

int atoi(char *string){
	printf("%s\n",string);
	int integer = 0;
	for (int c = 0;string[c];c++){
		//printf(">> %c\n", string[c]);
		if (string[c] >= '0' && string[c] <= '9'){
			integer *= 10;
			integer += (string[c] - '0');
		}else
			return 0;
	}
	return integer;
}

int main(int argc, char **argv){
	int sum = 0;
	printf("%d argumnets\n", --argc);
	for (int i = 1;i<=argc; i++){
		int this = atoi(argv[i]);
		sum += this;
	}

	printf("The sum is:%4d\n",sum);
	return 0;
}
