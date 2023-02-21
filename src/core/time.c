#include <sys/time.h>
#include <lwip/arch.h>

/* Unit: ms */
u32_t sys_now(void)
{
    unsigned long mtime;
    mtime = *(volatile unsigned long *)(0x30bff8UL);
    return (u32_t)(mtime * 4 / 5 / 1000);
}
