# $Id$

# 536e0636c00231.84551647:20140512070900

alias via="vim  /root/bash_aliases"
alias a="source /root/.bashrc; alias"
alias newhome="HOME=$PWD"

alias connie="cd /home/connie; HOME=/home/connie; . /home/connie/.bashrc"


BLANK80="\\040\\040\\040\\040\\040\\040\\040\\040\\040\\040\\040\\040\\040\\040\\040\\040\\040\\040\\040"
BLANK80="${BLANK80}${BLANK80}${BLANK80}${BLANK80}"

LEFTMAR="\\040\\040\\040\\040\\040\\040\\040\\040\\040"


function stow () {


	# Place the file in the local repository
	ci .RCS/${1},v ${1}
	co -l  .RCS/${1},v ${1}
	
	# Place the file in the user account repository
	# ci ~/.cfs/RCS/${1},v ${1}
	# co ~/.cfs/RCS/${1},v ${1}
}

function retrieve () {

	
	ci .RCS/${1},v ${1}
	co -l  .RCS/${1},v ${1}
	
	# ci ~/.cfs/RCS/${1},v ${1}
	# co ~/.cfs/RCS/${1},v ${1}
}

function cfs () {


	IFS=$'\t\n'
	DIRECTORY_TREE=(`ls /home/`)

	index=0
	
	for directory in ${DIRECTORY_TREE[@]}; do

		echo -e "${LEFTMAR}\\033[1;44m\\040${BLANK80}\\033[1;0m\\033[1A"
		echo -e "${LEFTMAR}\\033[1;44m$index  $directory\\033[1;0m"

		index=$(($index+1))
	done

	IFS=$' \t\n'

	read -p"Make a Selection" selection

	if [[ $selection -ge $BASE ]] || [[ $selection -le $index ]]; then

		echo ${DIRECTORY_TREE[$selection]}
	fi
}

# $Log$
