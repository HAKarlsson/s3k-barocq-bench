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
	printf("i\terr\t\call\treply\n");
	while (1) {
		msg = (s3k_msg_t){0};
		temporal_fence();
		uint64_t begin = rdcycle();
		s3k_reply_t reply = s3k_sock_sendrecv(3, &msg);
		uint64_t end = rdcycle();
		uint64_t call_latency = reply.data[0] - begin;
		uint64_t replyrecv_latency = end - reply.data[1];

		printf("%d\t%d\t%ld\t%ld\n", ++i, reply.err, call_latency, replyrecv_latency);
		s3k_sleep(0);
	}
}
