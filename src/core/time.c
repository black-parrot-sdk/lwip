#include <sys/time.h>
#include <lwip/arch.h>

/* Unit: ms */
u32_t sys_now(void)
{
    struct timeval tv;
    gettimeofday(&tv, NULL);
    return (u32_t)tv.tv_sec * 1000 + (u32_t)tv.tv_usec / 1000;
}
