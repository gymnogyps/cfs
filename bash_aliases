# $Id$

# File    : bash_aliases
# Purpose : Shell configuration file. 
# Date    : 5/12/14   
# GUFI: 
# 536e0636c00231.84551647:20140512070900

BUGGY=1

CFS_SELECTION=""
LINELENGTH=80
LEFTMARGINLENGTH=8

LOCALDIR_REPO='.RCS'
FILESYSTEM_REPO='/var/cache/cfs/rcs'

for (( x = 0 ; $x < $LINELENGTH; x++ )) ; do
	BLANKLINE=${BLANKLINE}"\\040"
done

for (( x = 0 ; $x < $LEFTMARGINLENGTH; x++ )) ; do
	LEFTMARGIN=${LEFTMARGIN}"\\040"
done

function stow () {

	for REPODIR in $LOCALDIR_REPO $FILESYSTEM_REPO; do 
		if [ -d $REPODIR ]; then
	
			if [ $REPODIR != $LOCALDIR_REPO ]; then	
				DESTDIR="$REPODIR$PWD"
			else
				DESTDIR=$LOCALDIR_REPO
			fi

			(($BUGGY)) && {
				echo "--+-*-+--"
				echo "REPO: "$REPODIR
				echo "COMMAND LINE: "$1
				echo "Destination: $DESTDIR"
				echo "++-*-++"
			}
			if ! [ -d "$DESTDIR" ]; then

				(($BUGGY)) && echo "DEBUG: $DESTDIR being created"
				mkdir -p $DESTDIR
			else
				(($BUGGY)) && echo  "DEBUG: $DESTDIR appears intact"
			fi

			# cp $1 temp 
			ci $DESTDIR/${1},v ${1}
			co -l  $DESTDIR/${1},v ${1}
			# cp temp $1
		fi
	
	done
}

function retrieve () {
	
	if [ -f $LOCALREPO ]; then
		ci .RCS/${1},v ${1}
		co -l  .RCS/${1},v ${1}
	fi
	
	# ci ~/.cfs/RCS/${1},v ${1}
	# co ~/.cfs/RCS/${1},v ${1}
}

function cfs_select () {

	# echo ${@}

	IFS=$'\t\n'
	
	SELECTIONS=( 'Exit' ${@} )
	LAST_ASSIGNED_INDEX=${#SELECTIONS[@]}
	

	SELECTION_PROCESS='INCOMPLETE'


	while [[ $SELECTION_PROCESS == 'INCOMPLETE' ]]; do 
		index=0
	
			echo -e "${LEFTMARGIN}\\033[1;44m\\040${BLANKLINE}\\033[1;0m"
		for directory in ${SELECTIONS[@]}; do

			echo -e "${LEFTMARGIN}\\033[1;44m\\040${BLANKLINE}\\033[1;0m\\033[1A"
			echo -e "${LEFTMARGIN}\\033[1;44;36m $index  \\033[1;37m$directory\\033[1;0m"

			index=$(($index+1))
		done

			echo -e "${LEFTMARGIN}\\033[1;44m\\040${BLANKLINE}\\033[1;0m"
			echo -en "${LEFTMARGIN}"

		read -p"Make a Selection: " selection

		if [[ $selection -ge $BASE ]] && [[ $selection -le $index ]]; then

			echo "DEBUG: selection within limits"

			SELECTION_PROCESS='COMPLETE'
			CFS_SELECTION=${SELECTIONS[$selection]}
		fi

		if [ $selection -eq $LAST_ASSIGNED_INDEX ]; then
			SELECTION_PROECESS='COMPLETE'
		fi
	done
	IFS=$' \t\n'
}

function sandbox_function () {

	# echo "Test Data"  ${TEST_DATA[@]}

	cfs_select "${TEST_DATA[@]}"
}

#
# $Log$
