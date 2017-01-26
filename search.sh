#!/bin/bash -x

# This is for easy searching files
WHICH="/usr/bin/which"
FIND="/usr/bin/find"
PWD="/bin/pwd"
SEARCHPATTERN=${@:$#}
SEARCHPATH=$($PWD)
OPTION="-iname"

#Colors#
CRESTORE='\033[0m'
CRED='\033[00;31m'
######################

print_help() {
echo -e "
Usage: search.sh [OPTION] [SEARCHPATTERN]

        -h      show this help
        -p      [SEARCHPATH] search only this Path
        -e      Search exactly this Filename
        -s      Search for the Path of a Programm or Script (like which)
"
}

############ SEARCH MODES #################
exact_search() {
$FIND $SEARCHPATH $OPTION $SEARCHPATTERN
}

script_search() {

$WHICH $SEARCHPATTERN
}

find_search() {

$FIND $SEARCHPATH $OPTION "*$SEARCHPATTERN*"
}

if [[ -z $SEARCHPATTERN ]]; then
        print_help
        exit 1
fi
###########################################

############## OPTIONS ####################
while getopts 'hp:esn' opt
do
        case $opt in
                h)
                        print_help
                        exit 0
                        ;;
                p)
                        SEARCHPATH="$OPTARG"
                        ;;
                e)
                        MODE="exact"
                        OPTION="-name"
                        ;;
                s)
                        MODE="script"
                        ;;
                *)
                        find_search
                        exit 0
                        ;;
        esac
done
##########################################

if [[ -z $MODE ]]; then
        find_search
        exit 0
elif [[ $MODE -eq "exact" ]];then
        exact_search
        exit 0
elif [[ $MODE -eq "script"  ]];then
        script_search
        exit 0
fi


exit 10
