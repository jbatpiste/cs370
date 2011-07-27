#!/bin/bash

server=${1-localhost:8085}


function unknown_files {
	unknown_file_count=`git status --porcelain | grep "^??" | wc -l`
	[[ "$unknown_file_count" -gt 0 ]]
}

function uncommited_changes_ {
	changes_commited=`git diff HEAD --shortstat | wc -l `
	[[ "$changes_commited" -gt 0 ]]
}

if unknown_files; then
	echo 'unknown files in project'
	exit 1
fi

if uncommited_changes_; then
	echo 'Uncommited files in project'
	exit 1
fi 


echo 'exit...'
exit 0

curl -s -H 'Content-Type:application/json' -d '["one"]' http://$server/checkclearing

history=`curl http://$server/checkclearing`

echo 'history data:'
echo $history

response=`curl -H 'Content-Type:application/json' -d "$history" http://$server/checkclearing`

echo $response

if [ "$response" != '{"one":100}' ]; then

		echo "Test Failed!!"
		exit 1
else
	echo "Test OK"
fi








