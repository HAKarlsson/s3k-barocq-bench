#include "s3k.h"
#include <stdio.h>

uint64_t rdcycle() {
	uint64_t v;
	__asm__ volatile ("rdcycle %0" : "=r"(v));
	return v;
}

int main(void)
{
	printf("Client: Starting...\n");
	s3k_msg_t msg;
	int i = 0;
	while (1) {
		msg = (s3k_msg_t){0};
		// uint64_t begin = rdcycle();
		s3k_reply_t reply = s3k_sock_sendrecv(3, &msg);
		// uint64_t end = rdcycle();
		// printf("%d %d %ld\n", ++i, reply.err, end - begin);
		printf("%d %d %lu\n", ++i, reply.err, s3k_get_syscall_handler_rdcycle());
		s3k_sleep(0);
	}
}
