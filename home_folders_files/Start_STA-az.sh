#!/bin/sh
echo "---------------------------------------------------"
echo "  #####  #######    #            "
echo " #     #    #      # #           "
echo " #          #     #   #         "
echo "  #####     #    #     #         "
echo "       #    #    #######         "
echo " #     #    #    #     #         "
echo "  #####     #    #     #         "
echo "---------------------------------------------------"
echo " ######  ####### #     # ####### "
echo " #     # #       ##   ## #     # "
echo " #     # #       # # # # #     # "
echo " #     # #####   #  #  # #     # "
echo " #     # #       #     # #     # "
echo " #     # #       #     # #     # "
echo " ######  ####### #     # ####### "
echo "---------------------------------------------------"
echo "---------------------------------------------------"
                                 
rfkill unblock all

if lsmod | grep -q "wilc_sdio" ; then
        echo "1.############## WILC-SDIO module is available ##############"
else
        echo "1.############## Inserting the wilc-sdio module ##############" 
        modprobe wilc-sdio 
        if lsmod | grep -q "wilc_sdio";  then
                echo "WILC-SDIO module insterted successfully"
        else
                echo "WILC-SDIO module insert failed"
        fi
fi

if ! test -f /etc/wpa_supplicant.conf; then
cat << 'EOT' > /etc/wpa_supplicant.conf
ctrl_interface=/var/run/wpa_supplicant
ctrl_interface_group=0
update config=1

network={
	key_mgmt=NONE
}	
EOT
fi

if grep -q "ssid" /etc/wpa_supplicant.conf; then
	echo "Connecting to router:-" 
	sed -n "/ssid/p" /etc/wpa_supplicant.conf
	sleep 2
else
	echo "Input the SSID of the router/AP"
	read newSsid
	echo "New SSID " $newSsid
	sed -i "s/{.*/& \n\tssid=\"$newSsid\"/gI" /etc/wpa_supplicant.conf
	echo "Input the passphrase(if non-secured, press Carriage Return(Enter)"
	read passPhrase
	if [ "$passPhrase" = "" ];then
		echo "Connecting to Non-Secured AP"
		sed -i "s/\bkey_mgmt\b.*/\tkey_mgmt=\"NONE\"/gI" /etc/wpa_supplicant.conf
	else
		echo "New Passphrase " $passPhrase
		sed -i "s/ssid.*/& \n\tpsk=\"$passPhrase\"/gI" /etc/wpa_supplicant.conf
		sed -i "/key_mgmt/d" /etc/wpa_supplicant.conf
	fi

fi

echo "2.############## Connecting to configured AP ##############"
echo 0 > /sys/kernel/debug/wilc/wilc_debug_region
rfkill unblock all
wpa_supplicant -B -iwlan0 -Dnl80211 -c /etc/wpa_supplicant.conf &
udhcpc -i wlan0 &
ifconfig wlan0 192.168.1.105
route add default gw 192.168.1.1

#current way to bring up and down wlan0
#ip link set wlan0 down
#ip link set wlan0 up

#old way to bring up and down
#ifdown
#ifup

echo "---------------------------------------------------"
echo "---------------------------------------------------"
