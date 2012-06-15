#!/bin/sh

if [ "$1" = "--help" ] || [ "$1" = "-h" ] ; then
	echo "usage: $0 [<remoterepo>]"
	echo "will add a post-commit function in the git repo"
	echo "which will automaticly push to the default or remote repo"
	exit;
fi 

HOOKS_FOLDER=.git/hooks
POST_COMMIT=$HOOKS_FOLDER/post-commit

if [ -d $HOOKS_FOLDER ]; then
    if [ -f $POST_COMMIT ]; then
        echo "Post commit hook already exits, please add 'git push' manually in .git/hooks/post-commit"
        exit 1
	fi
	echo "git push $1" > $POST_COMMIT
	chmod 755 $POST_COMMIT
		REPOSITORY_BASENAME=$(basename "$PWD") 
	echo "added auto commit to $REPOSITORY_BASENAME"
    exit 0
else
    echo "This command must be run in the root of a Git repository."
    exit 1
fi
