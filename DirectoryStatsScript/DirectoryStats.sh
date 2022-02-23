#!/bin/bash

LOCATION=$(pwd)

LOCATIONV=0 # 0 No location was given | 1 location was given
STATSV=0 # 0 print with not stats | 1 print with stats

function help(){
	echo "$0 [-l --location] [-e --extension] [-s --stats] [-h --help]"
	echo "examples"
	echo "$0 -l /etc -e pdf -s"
	echo "$0 -l /etc"
	echo "$0 -l /etc -s"
	exit 1
}


if [ $# -lt 0 ];then
	help
fi

while [ $# -gt 0 ];do
	case $1 in
		-l | --location)
			if [ -z $2 ];then
				echo "provide location after -l or --location!"
				exit 1
			fi
			LOCATION=$2
			shift 2
			;;
		-e | --extension)
			if [ -z $2 ];then
                      		echo  "provide extension after -e or --extension!"
                        	exit 1
                        fi
			EXT=$2
			shift 2
			;;
		-s | --stats)
			STATSV=1
			shift
			;;
		-h | --help | *)
			help
			shift
			;;
	esac
done

#is EXT empty?
echo "Directory : $LOCATION"
echo "========================================="
if [ -d $LOCATION ];then
	if [ $? -ne 0 ];then
		echo "$LOCATION is not a directory"
	fi	
fi

if [ "$EXT" != ""  ];then 
	ls -l 	$LOCATION | awk '/^-/' | grep "\.$EXT" &> /dev/null #i am looking for files only => -
	if [ $? -ne 0 ];then
		echo "No file with Extension $EXT found in $LOCATION " #grep error checking
		exit 2
	fi
	ls -l $LOCATION | awk '/^-/' | grep "\.$EXT" | awk -v stats=$STATSV -f size.awk
else	
	if [ -d $LOCATION ];then
		ls -l $LOCATION | awk '/^-/' | awk -v stats=$STATSV -f size.awk
	else
		echo "$LOCATION is not a directory!"
		exit 3
	fi	
fi

