#include <fcntl.h>
#include <errno.h>
#include <sys/socket.h>
#include <resolv.h>
#include <strings.h>
#include <stdlib.h>
#include <netdb.h>
#include <netinet/in.h>
#include <netinet/ip_icmp.h>

#define PACKETSIZE	64
struct packet
{
	struct icmphdr hdr;
	char msg[PACKETSIZE-sizeof(struct icmphdr)];
};

struct protoent *proto=NULL;


void display(void *buf, int bytes)
{	int i;
	for ( i = 0; i < bytes; i++ )
	{
		if ( !(i & 15) ) printf("\n%02X:  ", i);
		printf("%02X ", ((unsigned char*)buf)[i]);
	}
	printf("\n");
}

void listener(void)
{	int sd;
	struct sockaddr_in addr;
	unsigned char buf[1024];

	sd = socket(PF_INET, SOCK_RAW, proto->p_proto);
	if ( sd < 0 )
	{
		perror("socket");
		exit(0);
	}
		int bytes;
		unsigned int len=sizeof(addr);

		bzero(buf, sizeof(buf));
		bytes = recvfrom(sd, buf, sizeof(buf), 0, (struct sockaddr*)&addr, &len);
		if ( bytes > 0 )
			display(buf, bytes);
		else
			perror("recvfrom");
	exit(0);
}

int main()
{
	struct sockaddr_in addr;

	proto = getprotobyname("ICMP");
	bzero(&addr, sizeof(addr));
	addr.sin_port = 0;
	listener();
	return 0;
}

