#!/bin/bash
# Check usage for the functionality.

warning(){
echo '                             _               
                               (_)              
    _ _ _   ____   ____  ____   _  ____    ____ 
   | | | | / _  | / ___)|  _ \ | ||  _ \  / _  |
   | | | |( ( | || |    | | | || || | | |( ( | |
    \____| \_||_||_|    |_| |_||_||_| |_| \_|| |
                                         (_____|
You are about to delete files on this system.
Please do a dry run first to know the files that would be deleted.
'
}

usage(){
	warning
    echo '
******************************* Usage ***************************************
**  Author      : Sandeep Chandragiri                                      **
**  Script      : findAndDelete.sh - Handy script to find and delete files **
**  Arguments   : Takes following arguments in order                       **
**  1. Path     : Absolute path to the localtion of the files              **
**  2. File     : Matching pattern of the files to be delete, in quotes    **
**  3. Days     : Files modified before these no of days to be delete      **
**  4. Action   : Provide any one action to perform                        **
**                find - will only list file that will be deleted          **
**                delete - will delete the file listed under dryrun        **
*****************************************************************************

# Example : 
#. ./findAndDelete.sh /opt/od/var/aem/crx-quickstart/repository/repository/datastore/tmp/ "*.tmp" 30 find
#. ./findAndDelete.sh /opt/od/var/aem/crx-quickstart/repository/repository/datastore/tmp/ "*.tmp" 30 delete'

}

find_files(){
	echo "Finding files....................."
	echo ' '
	find $path -type f -iname $File -mtime +$Days -printf "%TY-%Tm-%Td %TH:%TM %s KB %P \n"
}

delete_files(){
	echo ' '
	echo "Deleting files...................."
	find $path -type f -iname $File -mtime +$Days -delete
}

findAndDelete(){
usage
echo ' '
echo "Find and Delete files."
echo ' '
echo 'Path  : '$Path 
echo 'File  : '\"$File\" 
echo 'Days  : '$Days
echo 'Actn  : '$Actn
echo ' '
echo 'Files modified before '$Days' days, matching pattern '\"$File\"' in the location '$Path' will be deleted.'
find_files
if [ $Actn = "delete" ]
then
	delete_files
fi
echo ' '
echo 'done!!!' 
}

##Start
Path=$1
File=$2
Days=$3
Actn=$4
Time=$(date +"%y%m%d%H%M%S")
Log_File=~/findAndDelete-$Time.log

if [ $# -eq 4 ]
then 
    findAndDelete | tee -a "$Log_File" 
    echo ' '
    echo "You can find the logs here: [ $Log_File ]"
else 
    usage
fi
















