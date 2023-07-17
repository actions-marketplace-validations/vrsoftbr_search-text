#!/bin/sh -l

if [ -z "$3" ]; then
    grep -E -ron --include=$2 "$1" . | tee lines-with-text.out
else
    grep -E -ron --include=$2 --exclude-dir=$3 "$1" . | tee lines-with-text.out
fi

COUNT=$(wc -l lines-with-text.out | sed s/lines-with-text.out// | sed s/\ \//)

FILES=$(cat lines-with-text.out)

echo -e "$COUNT"

echo -e "Text found in:"
echo -e "$FILES"

echo -e "$4"

if [ -z "$COUNT" ] && ([ $4 == true ] || [ $4 == "true" ]); then
    echo -e "Text found, $COUNT incidences, throwing error!"
    exit 1
fi

echo -e "Text found, $COUNT incidences!"

echo "count=$COUNT" >> $GITHUB_OUTPUT
# echo "files=$FILES" >> $GITHUB_OUTPUT

echo 'files<<EOF' >> $GITHUB_OUTPUT
$FILES >> $GITHUB_OUTPUT
echo 'EOF' >> $GITHUB_OUTPUT
