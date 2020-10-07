#!/bin/bash

PRINT_FMT="%-30s %-8s %s\n"

PROG=$(basename $0)

usage()
{
    echo "NAME"
    echo "  $PROG - print git commiter stats"
    echo
    echo "SYNOPSIS"
    echo "  $PROG [OPTION] COMMITTERS"
    echo
    echo "DESCRIPTION"
    echo "  List commit statistics for commiters"
    echo
    echo "  -v, --verbose"
    echo "       print more information"
    echo
    echo "  -l, --help"
    echo "       print this help text"
    echo 
    echo "  -gd <DIR>, --git-directory <DIR>"
    echo "       read git stats from <DIR>. Default is current directory "
    echo 
    echo "COMMITERS - space separated list of commiters"
    echo
    echo "EXAMPLE"
    echo
    echo "  $PROG lonleyhacker awesomehacker"
    echo
    echo "  $PROG -v lonleyhacker awesomehacker"
    echo
}

GIT_DIR=.
while [ "$1" != "" ]
do
    case "$1" in
        "--verbose"|"-v")
            VERBOSE=true
            ;;
        "--help"|"-h")
            usage
            exit 0
            ;;
        "--git-directory"|"-gt")
            GIT_DIR=$2
            shift
            ;;
        *)
            break
            ;;
    esac
    shift
done

repo_stat()
{
    TOTAL_COMMITS=$(git rev-list --all --count)
    REPOSITORY=$(git config --get remote.origin.url)
}

if [ "$1" = "" ]
then
    echo "You need to supply at least one commiter expression"
    echo ""
    echo "Example:  $0 Hackername"
    exit 1
fi


user_stat()
{
    COMMITER_COMMITS=$(git shortlog -s -n --all | egrep "$COMMITER" | awk '{ print $1 }')
    COMMITER_PERCENT="$(echo "scale=2; $COMMITER_COMMITS / $TOTAL_COMMITS * 100 " | bc -l )"
}


pretty_print()
{
    printf "$PRINT_FMT" "$1" "$2" "$3"
}

print_stat()
{
    COMMITER=$1
    user_stat
    if [ "$VERBOSE" = "true" ]
    then
        pretty_print  "$COMMITER" "$COMMITER_COMMITS" "${COMMITER_PERCENT}%"
    else
        pretty_print "$COMMITER" "$COMMITER_COMMITS" "${COMMITER_PERCENT}%"
    fi
}


cd $GIT_DIR

repo_stat
if [ "$VERBOSE" = "true" ]
then
    pretty_print "Repository:" "$REPOSITORY"
    pretty_print "Commits:"    "$TOTAL_COMMITS" "%"
    echo "------------------------------------------------------"
fi
while [ "$1" != "" ]
do
    git shortlog -s -n --all | egrep "$1" | awk ' { $1=""; printf "%s\n" , $0}' | sed -e 's,\[[a-zA-Z0-9]*\],,g' | while read commiter
    do
        
        print_stat "$commiter"
    done
    shift
done

