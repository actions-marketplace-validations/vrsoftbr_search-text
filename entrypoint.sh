#!/bin/sh -l

RED='\033[0;31m'
NC='\033[0m'

if [ -z "$3" ]; then
    grep -E -ron --include=$2 "$1" . | tee lines-with-text.out
else
    grep -E -ron --include=$2 --exclude-dir=$3 "$1" . | tee lines-with-text.out
fi

COUNT=$(wc -l lines-with-text.out | sed s/lines-with-text.out// | sed s/\ \//)
FILES=$(cat lines-with-text.out)

if [ ! -z "$COUNT" ] && ([ $4 = true ] || [ $4 = "true" ]); then
    echo "${RED}Text found, $COUNT incidences:${NC}"
    exit 1
fi

echo "Text found, $COUNT incidences!"

echo "count=$COUNT" >> $GITHUB_OUTPUT
# echo "files=$FILES" >> $GITHUB_OUTPUT

echo 'files<<EOF' >> $GITHUB_OUTPUT
$FILES >> $GITHUB_OUTPUT
echo 'EOF' >> $GITHUB_OUTPUT
