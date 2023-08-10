ifndef KDIR
    KDIR=/lib/modules/$(shell uname -r)/build
endif

obj-m += lan867x_phy.o smsc95xx_t1s.o

lan867x_phy-y := phy-driver/src/lan867x_phy.o
smsc95xx_t1s-y := smsc95xx-drv/smsc95xx.o

all:
	$(MAKE) -C $(KDIR) M=$(PWD) modules

clean:
	$(MAKE) -C $(KDIR) M=$(PWD) clean
