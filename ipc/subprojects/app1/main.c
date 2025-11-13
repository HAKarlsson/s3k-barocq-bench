#include "s3k.h"
#include <stdio.h>

uint64_t rdcycle() {
	uint64_t v;
	__asm__ volatile ("rdcycle %0" : "=r"(v));
	return v;
}

void temporal_fence() {
	__asm__ volatile (".word 0xb");
}


// int main(void)
// {
// 	printf("Client: Starting...\n");
// 	s3k_msg_t msg;
// 	int i = 0;
// 	while (1) {
// 		msg = (s3k_msg_t){0};
// 		uint64_t begin = rdcycle();
// 		s3k_reply_t reply = s3k_sock_sendrecv(3, &msg);
// 		uint64_t end = rdcycle();
// 		printf("%d %d %ld\n", ++i, reply.err, end - begin);
// 		s3k_sleep(0);
// 	}
// }

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

        uint64_t call_time = msg.data[0] - begin;
        uint64_t reply_time = end - msg.data[1];
        uint64_t total_time = call_time + reply_time;
		printf("%d %d %ld %ld %ld\n", ++i, reply.err, begin, msg.data[0], msg.data[1]);
        // printf("%d %d %ld %ld %ld\n", ++i, reply.err, call_time, reply_time, total_time);
        s3k_sleep(0);
    }
}