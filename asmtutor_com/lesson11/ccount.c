// convert int to string
// max 2*10**98

#include <stdio.h>
#include <unistd.h>


int main(){
	int test = 123987;
	char buff[100] = {0};
	char lf = '\n';

	printf("Converting int %d\n", test);

	int i = 0;
	for (; test>0; i++){
		buff[i] = (test % 10) + '0';
		test = test / 10;
	}

	///////////////
	// method #1 //
	///////////////

	for (int c=i; c>=0; c--){
		write(1, &buff[c], 1);
	}
	write(1, &lf, 1);


	///////////////
	// method #2 //
	///////////////

	// tbd: reverse buff
	write(1, &buff, i);

	return 0;
}

