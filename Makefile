# SPDX-License-Identifier: GPL-2.0
#
# Makefile for the Linux Bluetooth HCI device drivers.
#

ifneq ($(KERNELRELEASE),)

obj-m	+= btusb_git.o
obj-m	+= btintel_git.o
obj-m	+= btbcm_git.o
obj-m	+= btrtl_git.o
obj-m	+= btmtk_git.o

else

KVER ?= `uname -r`
KDIR ?= /lib/modules/$(KVER)/build
MODDIR ?= /lib/modules/$(KVER)/extra/bluetooth

modules:
	$(MAKE) -j`nproc` -C $(KDIR) M=$$PWD modules

clean:
	$(MAKE) -C $(KDIR) M=$$PWD clean

install:
	strip -g *.ko
	@install -Dvm 644 -t $(MODDIR) *.ko
	depmod -a $(KVER)
	
uninstall:
	@rm -rvf $(MODDIR)
	@rmdir --ignore-fail-on-non-empty /lib/modules/$(KVER)/extra || true
	depmod -a $(KVER)

endif
