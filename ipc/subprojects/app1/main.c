#include "s3k.h"
#include <stdio.h>

void temporal_fence() {
#ifdef TEMPORAL_FENCE
	__asm__ volatile (".word 0xb");
#endif
}

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
		temporal_fence();
		uint64_t begin = rdcycle();
		s3k_reply_t reply = s3k_sock_sendrecv(3, &msg);
		uint64_t end = rdcycle();
		printf("%d %d %ld\n", ++i, reply.err, end - begin);
		s3k_sleep(0);
	}
}
