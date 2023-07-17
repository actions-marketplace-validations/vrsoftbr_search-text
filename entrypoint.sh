#!/bin/sh -l

NC='\033[0m'
RED='\033[0;31m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'

# echo -e "${BLUE}Finding text... ${NC}"
echo "Finding text..."

if [ -z "$3" ]; then
    grep -E -ron --include=$2 "$1" . | tee lines-with-text.out
else
    grep -E -ron --include=$2 --exclude-dir=$3 "$1" . | tee lines-with-text.out
fi

COUNT=$(wc -l lines-with-text.out | sed s/lines-with-text.out// | sed s/\ \//)
FILES=$(cat lines-with-text.out)

if [ ! -z "$COUNT" ] && ([ $4 = true ] || [ $4 = "true" ]); then
    echo -e "${RED}Text found, $COUNT incidences${NC}"
    exit 1
fi

echo -e "${GREEN}Text found, $COUNT incidences${NC}"

echo "count=$COUNT" >> $GITHUB_OUTPUT
# echo "files=$FILES" >> $GITHUB_OUTPUT

echo 'files<<EOF' >> $GITHUB_OUTPUT
$FILES >> $GITHUB_OUTPUT
echo 'EOF' >> $GITHUB_OUTPUT
