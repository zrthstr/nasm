// https://austinmarton.wordpress.com/2011/09/14/sending-raw-ethernet-packets-from-a-specific-interface-in-c-on-linux/
#include <stdio.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <net/if.h>
#include <netinet/ether.h>
#include <netinet/ip.h>
#include <netinet/udp.h>
#include <linux/if_packet.h>
#include <arpa/inet.h>

#define MY_DEST_MAC_0 0x00
#define MY_DEST_MAC_1 0x01
#define MY_DEST_MAC_2 0x02
#define MY_DEST_MAC_3 0x03
#define MY_DEST_MAC_4 0x04
#define MY_DEST_MAC_5 0x05

#define BUF_SIZ 1024
#define INTERFACE_NAME "eth0"
// #define DESTINATION_IP "192.168.0.111"
#define DESTINATION_IP "172.17.0.2"
#define SOURCE_PORT 1337
#define DESTINATION_PORT 1338

unsigned short csum(unsigned short* buf, int nwords) {
	unsigned long sum;
	for (sum=0; nwords > 0; nwords--) {
		sum += *buf++;
	}
	sum = (sum >> 16) + (sum &0xffff);
	sum += (sum >> 16);

	return (unsigned short)(-sum);
}

int main(int argc, char *argv[]) {
	int sockfd;
	/* Open RAW socket to send on */
	if ((sockfd = socket(AF_PACKET, SOCK_RAW, IPPROTO_RAW)) == -1) {
		perror("socket");
	}

	/* Payload */
	int msg_len;
	char msg[1024];
	memset(msg, 0, BUF_SIZ);

	/* Get the index of the interface to send on */
	struct ifreq interface_index;
	memset(&interface_index, 0, sizeof(struct ifreq));
	strncpy(interface_index.ifr_name, INTERFACE_NAME, IFNAMSIZ - 1);
	int ioctl_result_0 = ioctl(sockfd, SIOCGIFINDEX, &interface_index);
	if (ioctl_result_0 < 0) {
		perror("SIOCGIFINDEX");
	}

	/* Get the MAC address of the interface to send on */
	struct ifreq if_mac;
	memset(&if_mac, 0, sizeof(struct ifreq));
	strncpy(if_mac.ifr_name, INTERFACE_NAME, IFNAMSIZ - 1);
	int ioctl_result_1 = ioctl(sockfd, SIOCGIFHWADDR, &if_mac);
	if (ioctl_result_1 < 0) {
		perror("SIOCGIFHWADDR");
	}

	/* Get the IP address ofd the interface to send on */
	struct ifreq if_ip;
	memset(&if_ip, 0, sizeof(struct ifreq));
	strncpy(if_ip.ifr_name, INTERFACE_NAME, IFNAMSIZ - 1);
	int ioctl_result_2 = ioctl(sockfd, SIOCGIFADDR, &if_ip);
	if (ioctl_result_2 < 0) {
		perror("SIOCGIFADDR");
	}

	/* Construct the Ethernet header */
	struct ether_header* eh = (struct ether_header*) msg;
	eh->ether_shost[0] = ((uint8_t*) &if_mac.ifr_hwaddr.sa_data)[0];
	eh->ether_shost[1] = ((uint8_t*) &if_mac.ifr_hwaddr.sa_data)[1];
	eh->ether_shost[2] = ((uint8_t*) &if_mac.ifr_hwaddr.sa_data)[2];
	eh->ether_shost[3] = ((uint8_t*) &if_mac.ifr_hwaddr.sa_data)[3];
	eh->ether_shost[4] = ((uint8_t*) &if_mac.ifr_hwaddr.sa_data)[4];
	eh->ether_shost[5] = ((uint8_t*) &if_mac.ifr_hwaddr.sa_data)[5];
	eh->ether_dhost[0] = MY_DEST_MAC_0;
	eh->ether_dhost[1] = MY_DEST_MAC_1;
	eh->ether_dhost[2] = MY_DEST_MAC_2;
	eh->ether_dhost[3] = MY_DEST_MAC_3;
	eh->ether_dhost[4] = MY_DEST_MAC_4;
	eh->ether_dhost[5] = MY_DEST_MAC_5;
	/* htons changes the byte order host->network */
	eh->ether_type = htons(ETH_P_IP);
	msg_len = sizeof(struct ether_header);

	/* Construct the IP header */
	struct iphdr* iph = (struct iphdr*) (msg + sizeof(struct ether_header));
	iph->ihl = 5;
	iph->version = 4;
	iph->tos = 16; // Low delay
	iph->id = htons(54321);
	iph->ttl = 60; // hops
	iph->protocol = 17; // UDP
	/* Source IP address, can be spoofed */
	iph->saddr = inet_addr(inet_ntoa(((struct sockaddr_in*) &if_ip.ifr_addr)->sin_addr));
	// iph->saddr = inet_addr("192.168.0.112");
	/* Destination IP address */
	iph->daddr = inet_addr(DESTINATION_IP);
	msg_len += sizeof(struct iphdr);

	/* Construct the UDP header */
	struct udphdr* udph = (struct udphdr*) (msg + sizeof(struct ether_header) + sizeof(struct iphdr));
	udph->source = htons(SOURCE_PORT);
	udph->dest = htons(DESTINATION_PORT);
	udph->check = 0; // skip for now, come back to this when known
	msg_len += sizeof(struct udphdr);

	/* Packet data */
	msg[msg_len++] = 0xa0;
	msg[msg_len++] = 0xb0;
	msg[msg_len++] = 0xc0;
	msg[msg_len++] = 0xd0;
	msg[msg_len++] = 0xe0;
	msg[msg_len++] = 0xf0;

	/* Finish the headers */
	udph->len = htons(msg_len - sizeof(struct ether_header) - sizeof(struct iphdr));
	iph->tot_len = htons(msg_len - sizeof(struct ether_header));
	iph->check = csum((unsigned short*) (msg + sizeof(struct ether_header)), sizeof(struct iphdr)/2);

	/* Destination address */
	socklen_t destination_len = sizeof(struct sockaddr_ll);
	struct sockaddr_ll destination;

	destination.sll_ifindex = interface_index.ifr_ifindex;
	destination.sll_halen = ETH_ALEN;
	destination.sll_addr[0] = MY_DEST_MAC_0;
	destination.sll_addr[1] = MY_DEST_MAC_1;
	destination.sll_addr[2] = MY_DEST_MAC_2;
	destination.sll_addr[3] = MY_DEST_MAC_3;
	destination.sll_addr[4] = MY_DEST_MAC_4;
	destination.sll_addr[5] = MY_DEST_MAC_5;

	for (int i = 0; i < sizeof(msg); ++i) {
		printf("%02x ", msg[i]);
	}
	printf("\n");

	/* Send packet */
	int sendto_result = sendto(sockfd, msg, msg_len, 0, (struct sockaddr*) &destination, destination_len);
	if (sendto_result < 0) {
		perror("send");
	}

	return 0;
}
