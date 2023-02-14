.PHONY: all install clean

CC    := $(CROSS_COMPILE)gcc
AR    := $(CROSS_COMPILE)ar
RANLIB := $(CROSS_COMPILE)ranlib


BUILD ?= ./build
LWIP_INCLUDE := ./src/include

LWIP_CFLAGS    := -mabi=lp64 -march=rv64imafd -mcmodel=medany -Os \
        -I$(LWIP_INCLUDE) -Wall -Wextra -static -std=gnu99 -fno-common

LWIP_LIB_SRCS  := $(wildcard ./src/core/*.c)   \
		$(wildcard ./src/core/ipv4/*.c) ./src/netif/ethernet.c

LWIP_LIB_OBJS := $(LWIP_LIB_SRCS:%.c=$(BUILD)/%.o)

all:     $(BUILD)/liblwip.a
install: $(BUILD)/liblwip.a
	mkdir -p $(BP_SDK_INSTALL_DIR)/lib $(BP_SDK_INSTALL_DIR)/include
	cp $< $(BP_SDK_INSTALL_DIR)/lib
	cp -r $(LWIP_INCLUDE)/lwip  $(BP_SDK_INSTALL_DIR)/include
	cp -r $(LWIP_INCLUDE)/netif $(BP_SDK_INSTALL_DIR)/include
	cp -r $(LWIP_INCLUDE)/arch  $(BP_SDK_INSTALL_DIR)/include

$(BUILD)/%.o:%.c
	mkdir -p $(dir $@) && $(CC) $(LWIP_CFLAGS) -c $< -o $@

$(BUILD)/liblwip.a: $(LWIP_LIB_OBJS)
	$(AR) -rc $@ $^
	$(RANLIB) $@

clean:
	rm -rf $(BUILD)
