// convert int to string
// max N char for now

#include <stdio.h>


int main(){
	int test = 123987;
	printf("Converting int %d\n", test);

	char buff[100] = {0};
	int i = 0;

	for (;test>0;i++)  {
		char rest = test % 10;
		test = test / 10;
		buff[i] = rest + 48; // '0'
		//buff[i] = rest ;

		printf("%d  %d\n",test, rest);
		}
	printf("buff has len: %ld", i);

	printf("\n");
	for (int c = 0; i>0; i--){
		printf(" %x %c ",buff[i], buff[i] );
	}

	return 0;
}

