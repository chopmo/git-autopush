#!/bin/sh

HOOKS_FOLDER=.git/hooks
POST_COMMIT=$HOOKS_FOLDER/post-commit

if [ -d $HOOKS_FOLDER ]; then
    if [ -f $POST_COMMIT ]; then
        echo "Post commit hook already exits, please add 'git push' manually in .git/hooks/post-commit"
        exit -1
    fi
    echo "git push" > $POST_COMMIT
    chmod 755 $POST_COMMIT
    exit 0
else
    echo "This command must be run in the root of a Git repository."
    exit -1
fi
