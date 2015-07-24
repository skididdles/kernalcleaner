# This script will remove all but the current kernal
###############################################
#List's all installed kernals
installed_kernals=`dpkg --list | grep linux-image | sed -n 's/.*\(linux-image-[0-9]*\.[0-9]*\.[0-9]*-[0-9]*\).*/\1/p'`
echo -e "\nInstalled kernals:\n$installed_kernals\n"
###############################################
#States current kernal
current_kernal=`uname -r | sed -e 's/\([0-9]*\.[0-9]*\.[0-9]*-[0-9]*\)\(.*\)/linux-image-\1/'`
echo -e "Current kernal in use:\n$current_kernal\n"
###############################################
#puts the list into an array
array=( $installed_kernals )
i=0
finalarray=()
for element in "${array[@]}"	#loop through array
do
	if [ "$element" == "$current_kernal" ]; then
		echo -e "Keeping $element because it is in use\n" #skip this guy
	elif [ ${element:(-1)} > ${current_kernal:(-1)} ]; then
		echo "New kernal is ready to be installed"
	else
		#echo "Will delete $element" #clear to delete kernal
		((i++))
		finalarray[$i]=$element
	fi
done
###############################################
s=" "
dumb=" "
echo "List to be deleted:"
for element in "${finalarray[@]}" #display list to be deleted
do
	echo $element
	s=$s$dumb$element
done
if [ ${#finalarray[@]} == 0 ]; then
	echo "No old kernals laying around right now."
else
	echo "deleting..."
	#sudo apt-get purge $s #Comment out to keep from deleting anything
fi
