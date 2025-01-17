#!/bin/sh
git remote add target https://${INPUT_TARGET_USERNAME}:${INPUT_TARGET_TOKEN}@${INPUT_TARGET_URL#https://}

case "${GITHUB_EVENT_NAME}" in
    push)
        git push -f --all target
        git push -f --tags target
        ;;
    delete)
        git push -d target ${GITHUB_EVENT_REF}
        ;;
    workflow_dispatch)
        git push -f --all target
        git push -f --tags target
        ;;
    *)
        echo "Action type mismatch"
        exit 1
        ;;
esac
git remote remove target
