#!/bin/sh

usage() 
{
cat << EOF
usage $0 [<options>] [-r <remoterepo>]

will add a post-commit function in the git repo
which will automaticly push to the default or remote repo

OPTIONS:
 -o	Overwrite post-commit
 -r 	Remote Repo
EOF
}
params="$@"

OVERWRITE=0

while getopts  "hor:" OPTION
do
	case $OPTION in 
		h)
			usage
			exit 1
		;;
		o)
			OVERWRITE=1
		;;
		r)
			REMOTEREPO="$OPTARG"
		;;
	esac
done
shift $(( $OPTIND - 1 ))

HOOKS_FOLDER=.git/hooks
POST_COMMIT=$HOOKS_FOLDER/post-commit

if [ -d $HOOKS_FOLDER ]; then
    if [ -f $POST_COMMIT ] && [ $OVERWRITE -eq 0 ]; then
        echo "Post commit hook already exits, please add 'git push' manually in .git/hooks/post-commit"
        exit 1
    fi
    if [ $OVERWRITE -eq 1 ]; then
	mv $POST_COMMIT "$POST_COMMIT.bak"
	echo "moved old hook to $POST_COMMIT.bak"
    fi
    echo "git push $REMOTEREPO" > $POST_COMMIT
    chmod 755 $POST_COMMIT
    REPOSITORY_BASENAME=$(basename "$PWD") 
    echo "added auto commit to $REPOSITORY_BASENAME"
    exit 0
else
    echo "This command must be run in the root of a Git repository."
    exit 1
fi
