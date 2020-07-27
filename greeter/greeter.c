
# include <stdio.h>

int main(){
	char answer[32];
	int n;
	printf("whats you'r name?\n:");
	n = scanf("%s",answer);
	printf("hello %s\n", answer);
	exit(1);
}
