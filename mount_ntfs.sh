#!/bin/bash

function usage() {
    echo "      usage:        
        -h help
        -n hareware_name 
        !!!Make sure your u-disk or hard drive name. You can use \"diskutil list\" to check.
    "
}

function processs() {
    echo "This is main function " 
    disk_name=$1
    disk_path=""
    while read -r line ; do
       disk_path=$(echo $line | awk -F" " '{print $NF}')
       break
    done < <(diskutil list | grep $disk_name)
    if [ "$disk_path" == "" ]; then
        echo $disk_name" not found, please check your disk (or dev) name"
        exit 1
    fi
    disk_path="/dev/"$disk_path
    echo -e "\033[31;7mPLEASE DOUBLE CHECK THE NAME AND PATH, THIS IS VERY IMPORTANT!! \033[0m"
    echo -e "Is your disk (or dev) name:\033[31;4m"\"$disk_name\" "\033[0m's path :\033[31;4m"$disk_path"\033[0m"
    read -r -p "IF path is correct please press 'y/Y' to continue: " input
    case $input in
        [yY])
            echo "Yes continue"
            ;;

        *)
            echo "Not y or Y, exit"
            exit 1
            ;;
        
    esac

    #unmount this disk firstly
    diskutil unmountDisk $disk_path
    if [ $? -ne 0 ]; then
        exit 1
    fi

    #then create a path for mounting the disk on
    create_disk_path="/Volumes/"$disk_name
    mkdir -p $create_disk_path

    if [ $? -ne 0 ]; then
        echo "create" $create_disk_path "fail!"
        exit 1
    fi

    mount -t ntfs -o rw,auto,nobrowse $disk_path $create_disk_path
    if [ $? -ne 0 ]; then
        echo "mount disk"$disk_name "fail!"
        exit 1
    fi
    
    echo -e "mount ntfs filesystem successfully! directory is:\033[31;4m"$create_disk_path"\033[0m"
    echo "enjoy writting on this disk($disk_name)"
    exit 0
}

input=0
while getopts "n:h" arg
do
    case $arg in

    n)
        disk_name=$(echo -n $OPTARG)
        input=1
        #echo $OPTARG
        ;;
    h)
        usage
        exit 0
        ;;
    *)
        usage
        exit -1
        ;;
    esac
done

if [ $input -ne 1 ]; then
    # no opt? print usage and exit
    usage
    exit 1
fi

processs $disk_name

