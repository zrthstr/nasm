// https://austinmarton.wordpress.com/2011/09/14/sending-raw-ethernet-packets-from-a-specific-interface-in-c-on-linux/
#include <stdio.h>
#include <ifaddrs.h>

int main(int argc, char *argv[]) {

	struct ifaddrs *addrs, *tmp;
	getifaddrs(&addrs);
	tmp = addrs;

	while (tmp) {
		if (tmp->ifa_addr && tmp->ifa_addr->sa_family == AF_PACKET) {
			printf("%s\n", tmp->ifa_name);
		}
		tmp = tmp->ifa_next;
	}
	freeifaddrs(addrs);

	return 0;
}
