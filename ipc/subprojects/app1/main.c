#include "s3k.h"
#include <stdio.h>

void temporal_fence() {
#ifdef TEMPORAL_FENCE
	__asm__ volatile (".word 0xb");
#endif
}

uint64_t rdcounter() {
	uint64_t v;
#if defined(COUNTER_CYCLE)
	__asm__ volatile ("csrrs %0,cycle,x0" : "=r"(v));
#elif defined(COUNTER_LOAD)
	__asm__ volatile ("csrrs %0,hpmcounter3,x0" : "=r"(v));
#elif defined(COUNTER_STORE)
	__asm__ volatile ("csrrs %0,hpmcounter4,x0" : "=r"(v));
#else
	v = 0;
#endif
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
		uint64_t begin = rdcounter();
		s3k_reply_t reply = s3k_sock_sendrecv(3, &msg);
		uint64_t end = rdcounter();
		uint64_t call_latency = reply.data[0] - begin;
		uint64_t replyrecv_latency = end - reply.data[1];
		printf("%d\t%d\t%ld\t%ld\n", ++i, reply.err, call_latency, replyrecv_latency);
		s3k_sleep(0);
	}
}
