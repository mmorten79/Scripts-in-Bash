#!/bin/bash
# This is a script to set up the on board NIC on the server



# IF THIS FILE IS COPIED TO ANOTHER LOCATION, BE SURE TO CHANGE THE PERMISSIONS TO 777 ON WHATEVER SERVER YOU PUT IT ON
new0=0
new1=1
new2=2
new3=3

old0=0
old1=1
old2=2
old3=3

counter=0
counter2=0
counter3=0
answeryes=yes
answerno=no

while [ "$REPLY" != "$answeryes" ]; do

echo
read -p "Are you having and issue with a particular interface? "
echo

if [ "$REPLY" = "$answeryes" ]; then

echo - n "Let's check the interfaces"
echo

elif [ "$REPLY" != "$answerno" ]; then

echo -n " Please type 'yes' or 'no'  :"

elif [ "$REPLY" = "$answerno" ]; then
echo -n " Thanks for using this script. Good bye !!"
exit

elif [ "$REPLY" != "$answerno" ]; then

echo -n " Please type 'yes' or 'no'  :"
fi

done

clear

ethtool eth2
ethtool eth1
ethtool eth0

echo
echo -n "If an interface shows down please press ENTER"
echo

#SUCCESS WITH THE ENTER KEY !!!!
read -n 1 aa
 if [ -z "$aa" -o "$aa" = "n" -o "$aa" = "N" ];
 then

cat /etc/modprobe.d/blacklist | sed -e 's/blacklist tg3/#blacklist tg3/' > /etc/modprobe.d/blacklist3
cp /etc/modprobe.d/blacklist3 /etc/modprobe.d/blacklist

clear
echo -e "************************Updated /etc/modprobe.d/blacklist file to enable the 'tg3' drivers*************"
echo
sleep 2
echo
echo
echo
echo -n "Please press ENTER in order to enable the driver 'tg3'......"
echo
fi

 read -n 1 aa
  if [ -z "$aa" -o "$aa" = "n" -o "$aa" = "N" ];
  then
  modprobe tg3
fi

sleep 2
echo
echo
echo
echo -n "DONE"
sleep 1

clear
echo

echo -e "***************  Now lets go to '/etc/sysconfig/network'  *******************"
echo
echo
echo -e "*************** We need to create the interface configuration file ********************"
echo
echo
echo -e "**************************************Please wait**************************************"
cd /etc/sysconfig/network
sleep 3
echo
echo
echo
clear

ls -la | grep eth
echo
echo
echo
echo

while [ "$counter" -eq 0 ]; do

echo -e "What number are you going to give the new interface (enter number 2 or 3)"
echo
read setup1

bb="$setup1"

if [ "$bb" = "$new1" ]; then

counter=$((counter + 1))

elif [ "$bb" = "$new2" ]; then

counter=$((counter + 1))

elif [ "$bb" = "$new0" ]; then

counter=$((counter + 1))

elif [ "$bb" = "$new3" ]; then

counter=$((counter + 1))

else
echo
echo -n "Try again"
echo 

fi
done


while [ "$counter2" -eq 0 ]; do

echo -e "What is the number for the interface that is down: (Please enter a number 0-3 ) "
echo
read setup2

cc="$setup2"

if [ "$cc" = "$old0" ]; then

counter2=$((counter2 + 1))

elif [ "$cc" = "$old1" ]; then

counter2=$((counter2 + 1))

elif [ "$cc" = "$old2" ]; then

counter2=$((counter2 + 1))

elif [ "$cc" = "$old3" ]; then

counter2=$((counter2 + 1))


else
echo
echo -n "Try again"
echo 

fi
done

cp ifcfg-eth$cc ifcfg-eth$bb
mv ifcfg-eth$cc ifcfg-eth$cc.save
clear

echo
echo -e " ******  Interface Configuration files has been created   ********************"
sleep 1
echo
clear
echo


#WORKING TO GET THE DHCPD file updated 
#Assigning varibles to the WAN and the LAN interface to be able to update them correctly to this file
#Almost there... still in the works !!!
#Need a if statement to compare the results of the numwan var to get the number for the WAN eth interface

cd  /etc/sysconfig   
ifresults=`grep "DHCPD_INTERFACE" dhcpd | grep -v "#"` 

cd /etc/sysconfig/network
numwan0=`grep .201/24 ifcfg-eth0`
numwan1=`grep .201/24 ifcfg-eth1`
numwan2=`grep .201/24 ifcfg-eth2`
numwan3=`grep .201/24 ifcfg-eth3`


echo -e " What is the ETH number for the active WAN Ethernet controller "
echo -n "0. Information for ETH0 "
echo $numwan0
echo -n "1. Information for ETH1 "
echo $numwan1
echo -n "2. Information for ETH2 "
echo $numwan2
echo -n "3. Information for ETH3 "
echo $numwan3

echo -n " Please choose (0,1,2,3 ) for the active WAN Ethernet controller number ....... "
read wancontrollernum
WCN="$wancontrollernum"
ifreplace="eth$bb eth$WCN"

echo $ifreplace
echo -e "Press an key..."

cd /etc/sysconfig

cat /etc/sysconfig/dhcpd | sed "17 s/$ifresults/DHCPD_INTERFACE=$ifreplace/" | sed '17 s/=/="/'|sed '17 s/$/"/' > /etc/sysconfig/dhcpd.mine
cp /etc/sysconfig/dhcpd.mine /etc/sysconfig/dhcpd


 read -n 1 aa
   if [ -z "$aa" -o "$aa" = "n" -o "$aa" = "N" ];
     then
sleep 2
fi

clear

echo -e "    **********    G     R     E     A     T             J   O   B       ****************************"
echo

clear

echo
echo
echo -n " ........Last thing ............"
echo
echo

clear

echo -e " We have to shutdown the problem interface....."
echo
echo
echo -e " And start the newly configured interface..."
echo
echo
echo -e "********RUNNING 'ifdown eth"$cc" "
echo
echo
echo -e "Press enter when ready"
echo
 read -n 1 aa
    if [ -z "$aa" -o "$aa" = "n" -o "$aa" = "N" ];
	     then
		 ifdown eth"$cc"
		 fi


sleep 2
echo
echo
echo -e " ********************D      O     N     E **********************"
echo
clear
echo
echo -e " *************STARTING THE NEWLY CREATED INTERFACE eth"$bb$"*******************"
echo
echo
echo -e "Press enter when ready"
echo

 read -n 1 aa
     if [ -z "$aa" -o "$aa" = "n" -o "$aa" = "N" ];
	          then
			           ifup eth"$bb"
					   sleep 2
					   service dhcpd restart
					   fi
clear

echo
echo
echo -n "WE ARE DONE !"
echo
sleep 1
echo
echo -n "HAVE THE STORE RESTART COMPUTERS"
echo
echo -n "Also, make sure the cable is moved over to the ONBOARD PORT"
echo
exit
