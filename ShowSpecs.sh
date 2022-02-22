#$/bin/bash

opts=`getopt -o acgrshd --long all::,cpu,gpu,ram,system,disk,help -- "$@"`
eval set -- "$opts"


function help {
	echo "$0 -h or $0 --help to help"
	echo "$0 -a or $0 --all to get all the information about your computer"
	echo "$0 -c or $0 --cpu to get all the information about your CPU"
	echo "$0 -g or $0 --gpu to get all the information about your GPU"
	echo "$0 -r or $0 --ram to get all the information about your RAM"
	echo "$0 -s or $0 --system to get the information about your Operating System"
	echo "$0 -d or $0 --disk to get the information about your disks"

}

function cpu {
	echo "CPU"
	echo "==========================================================="
	echo "$(lscpu | egrep 'Model name|Architecture|Socket|Thread|NUMA|CPU\(s\)')"
	echo 
}

function gpu {
	echo "GPU"
	echo "============================================================"
	echo "$(lspci | grep VGA)"
	echo "for laptops that have more than one gpu"
	echo "$(lspci | grep 3D)"
	echo
}

function system {
	echo "System"
	echo "============================================================"
	echo "$(egrep '^(VERSION|NAME)=' /etc/os-release)"
	echo "$(hostnamectl | grep Hardware)" | sed -e 's/^[[:space:]]*//'
	echo "$(hostnamectl | grep Chassis)" | sed -e 's/^[[:space:]]*//'
	echo "$(hostnamectl | grep Kernel)" | sed -e 's/^[[:space:]]*//'
	echo "$(hostnamectl | grep Architecture)" | sed -e 's/^[[:space:]]*//'

	echo 
}

function ram {
	echo "RAM(Memory)"
	echo "============================================================"
	MEMSIZE=$(cat /proc/meminfo | head -1 | sed 's/[^0-9]//g')
	MEMSIZEGB=$(bc <<<"scale=2; $MEMSIZE/1048576")
	echo "Memory Size: $MEMSIZEGB GB "
	echo 
}

function disk {
	echo "Disks(Storage)"
	echo "============================================================="
	echo "$(ls -l /dev/disk/by-id)"
	echo
}

function all {
	echo
	system
	cpu
	gpu
	ram
	disk
}


if [ $# -lt 2 ];then
        help
	exit 1
fi



while [ $# -gt 0 ];do
	case "$1" in
		-h | --help)
			help
			shift			
			;;
		-a | --all)
			all
			shift
			;;
		-c | --cpu)
			cpu
			shift
			;;
		-s | --system)
			system
			shift
			;;
		-r | --ram)
			ram
			shift
			;;
		-d | --disk)
			disk
			shift
			;;
		-g | --gpu)
			gpu
			shift
			;;
		--) 	
			shift
			;;
		*)	
			help
			;;
	esac
done
