1 Introduction
The driver can be used with the 10BASE-T1S USB Adapter in a Linux system or as a code base for own development on other hardware and other operating systems.

1.1	Scope
This readme describes the usage of the 10BASE-T1S USB Adapter in Linux operating systems. 
For further support please contact our support team via the Microchip web portal: http://www.microchip.com/support

2 10BASE-T1S USB Adapter board basics
The board utilizes a Microchip LAN9500A to provide access to the 10BASE-T1S PHY LAN8670 via USB. The board hardware is described in the EVB LAN8670 USB User´s Guide. 
If you need it, please download it from the respective Microchip Webpage.

2.1	10BASE-T1S Network connection
The 10BASE-T1S network is using unshielded twisted pair cables for multidrop connection. The two wires are named N and P and should not be interchanged.

2.2	Termination
Terminations need to be active (both jumpers on the board closed) for the nodes located at the ends of a network. The nodes in between (drop nodes) do 
not require termination (both jumpers on the board open).

2.3	MAC Address
Each network adaptor has a pre-set unique MAC address. If you require the MAC address changed for individual purposes please contact: http://www.microchip.com/support

2.4	PLCA
The PLCA Mechanism (Physical Layer Collision Avoidance) requires a dedicated node ID set on each node. 
In a 10BASE-T1S system there has to be one single PLCA coordinator (node ID 0) and  at least one PLCA node (unique node ID >0). 
The node ID is set by the driver.

3 Driver

3.1	Install Linux Driver on your own system
The available Linux driver for 10BASE-T1S USB Adapter was tested with Linux kernel 5.4.83.
Copy und unzip the file t1s-usb_xx.xx.xxxx.zip to your Linux system and open a shell in this directory.
By executing

make

the driver kernel objects lan8767x_phy.ko and smsc95xx_t1s.ko are built.
Now please attach the 10BASE-T1S USB Adapter to your Linux device.
To load the driver you can use the script file t1s.sh with the node ID as parameter:

./t1s.sh 0 

for example loads the driver and configures the adapter as node 0 (PLCA coordinator) and sets also the
IP address for the T1S adapter (via ifconfig) to 192.168.0.10.

./t1s.sh 1

loads the driver and configures the adapter as node 1 (PLCA node) and sets the
IP address for the adapter to 192.168.0.11, and so on. 
Currently, up to 8 nodes are supported.
If your setup requires more than 8 nodes please contact: http://www.microchip.com/support
for additional configuration files.

3.2	Raspberry Pi image
If you use a Raspberry Pi test setup, a ready SD card image containing the driver is available.
Please contact:

http://www.microchip.com/support

and ask for the RPI SD card image.

