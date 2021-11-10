# MacOS_Monterey_NTFS_mount
Mounty can not support mount NTFS and own WRITE permission on Monterey(12.0.1) now(Nov 10th, 2021). So I write this shell script 

usage:
-h help
-n hareware_name 
!!!Make sure your u-disk or hard drive name. You can use "**diskutil list**" to check.

If my disk is "TOSHIBA", this command wolud be like: `sudo ./mount_ntfs.sh -n TOSHIBA`  *REMEMBER sudo* .

**IMPORTANT: This script works for me, BUT I DO NOT GUARANTEE THIS SCRIPT RUNS SAFELY ON YOUR ENVIRONMENT. PLEASE THINK TWICE BEFORE USING. DATA IS PRICELESS!**
