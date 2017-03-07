/*
 * linux.h
 *
 *  Created on: Oct 1, 2014
 *      Author: ckohn
 */

#ifndef LINUX_H_
#define LINUX_H_

#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


#define ARRAY_SIZE(a)  (sizeof(a)/sizeof((a)[0]))
#define ERRSTR strerror(errno)
#define ASSERT(cond, ...) 					\
		do {							\
			if (cond) { 				\
				int errsv = errno;			\
				fprintf(stderr, "ERROR(%s:%d) : ",	\
						__FILE__, __LINE__);	\
				errno = errsv;				\
				fprintf(stderr,  __VA_ARGS__);		\
				abort();				\
			}						\
		} while(0)

#endif /* LINUX_H_ */
