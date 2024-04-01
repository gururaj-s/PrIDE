#ifndef __TYPES_H__
#define __TYPES_H__

#define FALSE 0
#define TRUE  1

#define HIT   1
#define MISS  0

#define INVALID -1

#define MAX_UNS 0xffffffff

#define SAT_INC(x,max)   (x<max)? x+1:x
#define SAT_DEC(x)       (x>0)? x-1:0
#define MAX2(x,y)         (x>y)? x:y
#define MIN2(x,y)         (x<y)? x:y


/* Renames -- Try to use these rather than built-in C types for portability */


typedef unsigned	    uns;
typedef unsigned char	    uns8;
typedef unsigned short	    uns16;
typedef unsigned	    uns32;
typedef unsigned long long  uns64;
typedef short		    int16;
typedef int		    int32;
typedef int long long	    int64;


/*************************************************************************/

#endif  
