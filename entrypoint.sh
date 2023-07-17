#!/bin/sh -l

NC='\033[0m'
RED='\033[0;31m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'

echo -e "${BLUE}--------------------------------------------------------------------------------${NC}"
echo -e "${BLUE}Finding text...${NC}"

if [ -z "$3" ]; then
    grep -E -ron --include=$2 "$1" . | tee lines-with-text.out
else
    grep -E -ron --include=$2 --exclude-dir=$3 "$1" . | tee lines-with-text.out
fi

COUNT=$(wc -l lines-with-text.out | sed s/lines-with-text.out// | sed s/\ \//)
FILES=$(cat lines-with-text.out)

echo "count=$COUNT" >> $GITHUB_OUTPUT

if [ ! -z "$COUNT" ]; then
    echo -e "${RED}Text ($1) found, $COUNT incidences${NC}"
    
    if ([ $4 = true ] || [ $4 = "true" ]); then
        exit 1
    fi
else
    echo -e "${GREEN}Text ($1) not found!${NC}"
fi
