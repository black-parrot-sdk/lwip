#ifndef __ARCH_CC_H__
#define __ARCH_CC_H__

#define LWIP_DECLARE_MEMORY_ALIGNED(variable_name, size) u8_t variable_name[size] __attribute__ ((aligned (MEM_ALIGNMENT)));

#endif /* __ARCH_CC_H__ */
