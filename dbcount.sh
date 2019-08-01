#!/bin/bash
#Gives you a list of model types for the debit pads that are working at a particular store
FILESYS="/user"
ETROOT="$FILESYS/sms"
ETTMP="$ETROOT/tmp"
ETBIN="$FILESYS/etbin"
pingcon=""
possible1="00:03:81"
possible2="54:7f:54"

#Broadcast ping
ping -c4 10.20.30.255

# This gets a list of a the listed IPs and unit types

i=`$ETBIN/makedoti.x kdevext | grep ttyR | egrep '(6580)|(iSC25)' | awk -F ":" '{print $10, $11}'`
echo $i > $ETTMP/myresult.txt

# This actually prints the list of all of the IPs in KDEVEXT datafile

IP1=`cat $ETTMP/myresult.txt | awk '{print $1}'`
echo $IP1
IP2=`cat $ETTMP/myresult.txt | awk '{print $3}'`
echo $IP2
IP3=`cat $ETTMP/myresult.txt | awk '{print $5}'`
echo $IP3
IP4=`cat $ETTMP/myresult.txt | awk '{print $7}'`
echo $IP4
IP5=`cat $ETTMP/myresult.txt | awk '{print $9}'`
echo $IP5
IP6=`cat $ETTMP/myresult.txt | awk '{print $11}'`
echo $IP6
IP7=`cat $ETTMP/myresult.txt | awk '{print $13}'`
echo $IP7
IP8=`cat $ETTMP/myresult.txt | awk '{print $15}'`
echo $IP8
IP9=`cat $ETTMP/myresult.txt | awk '{print $17}'`
echo $IP9
IP10=`cat $ETTMP/myresult.txt | awk '{print $19}'`
echo $IP10


maclist1=`arp | grep $IP1`
maclist2=`arp | grep $IP2`
maclist3=`arp | grep $IP3`
maclist4=`arp | grep $IP4`
maclist5=`arp | grep $IP5`
maclist6=`arp | grep $IP6`
maclist7=`arp | grep $IP7`
maclist8=`arp | grep $IP8`
maclist9=`arp | grep $IP9`
maclist10=`arp | grep $IP10`


echo $maclist1
echo $maclist2
echo $maclist3
echo $maclist4
echo $maclist5
echo $maclist6
echo $maclist7
echo $maclist8
echo $maclist9
echo $maclist10







#This pings the IPS that came from the results files to see if these IPs are alive or not

pingres1=`ping -c3 $IP1 | grep -i unreachable` 
pingres2=`ping -c3 $IP2 | grep -i unreachable` 
pingres3=`ping -c3 $IP3 | grep -i unreachable` 
pingres4=`ping -c3 $IP4 | grep -i unreachable`
pingres5=`ping -c3 $IP5 | grep -i unreachable`
pingres6=`ping -c3 $IP6 | grep -i unreachable`
pingres7=`ping -c3 $IP7 | grep -i unreachable`
pingres8=`ping -c3 $IP8 | grep -i unreachable`
pingres9=`ping -c3 $IP9 | grep -i unreachable`
pingres10=`ping -c3 $IP10 | grep -i unreachable`



info2=`cat "$ETTMP"/myresult.txt | awk '{ print $2}'`
echo $info2
info4=`cat "$ETTMP"/myresult.txt | awk '{ print $4}'`
echo $info4
info6=`cat $ETTMP/myresult.txt | awk '{ print $6}'`
echo $info6
info8=`cat $ETTMP/myresult.txt | awk '{ print $8}'`
echo $info8
info10=`cat $ETTMP/myresult.txt | awk '{ print $10}'`
echo $info10
info12=`cat $ETTMP/myresult.txt | awk '{ print $12}'`
echo $info12
info14=`cat $ETTMP/myresult.txt | awk '{ print $14}'`
echo $info14
info16=`cat $ETTMP/myresult.txt | awk '{ print $16}'`
echo $info16
inf018=`cat $ETTMP/myresult.txt | awk '{ print $18}'`
echo $info18
info20=`cat $ETTMP/myresult.txt | awk '{ print $20}'`
echo $info20

if [ "$pingres1" = "" ];

then
cat $ETTMP/myresult.txt | awk '{ print $2}'
else
echo "Debit pad IP-"$IP1" MODEL-"$info2" isn't on the network. "
fi



if [ "$pingres2" = "" ];

then
cat $ETTMP/myresult.txt | awk '{ print $4}'
else
echo "Debit pad IP-"$IP2" MODEL-"$info4" isn't on the network. "
fi


if [ "$pingres3" = "" ];

then
cat $ETTMP/myresult.txt | awk '{ print $6}'
else
echo "Debit pad IP-"$IP3" MODEL-"$info6" isn't on the network. "
fi


if [ "$pingres4" = "" ];

then
cat $ETTMP/myresult.txt | awk '{ print $8}'
else
echo "Debit pad IP-"$IP4" MODEL-"$info8" isn't on the network. "
fi


if [ "$pingres5" = "" ];

then
cat $ETTMP/myresult.txt | awk '{ print $10}'
else
echo "Debit pad IP-"$IP5" MODEL-"$info10" isn't on the network. "
fi


if [ "$pingres6" = "" ];

then
cat $ETTMP/myresult.txt | awk '{ print $12}'
else
echo "Debit pad IP-"$IP6" MODEL-"$info12" isn't on the network. "
fi


if [ "$pingres7" = "" ];

then
cat $ETTMP/myresult.txt | awk '{ print $14}'
else
echo "Debit pad IP-"$IP7" MODEL-"$info14" isn't on the network. "
fi


if [ "$pingres8" = "" ];

then
cat $ETTMP/myresult.txt | awk '{ print $16}'
else
echo "Debit pad IP-"$IP8" MODEL-"$info16" isn't on the network. "
fi


if [ "$pingres9" = "" ];

then
cat $ETTMP/myresult.txt | awk '{ print $18}'
else
echo "Debit pad IP-"$IP9" MODEL-"$info18" isn't on the network. "
fi


if [ "$pingres10" = "" ];

then
cat $ETTMP/myresult.txt | awk '{ print $20}'
else
echo "Debit pad IP-"$IP10" MODEL-"$info20" isn't on the network. "
fi
exit
