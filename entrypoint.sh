#!/bin/sh -l

NC='\033[0m'
RED='\033[0;31m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'

BOLD=$(tput bold)
NORMAL=$(tput sgr0)

# echo -e "${BLUE}Finding text... ${NC}"
echo "${BOLD} ${BLUE}Finding text...${NC} ${NORMAL}"

if [ -z "$3" ]; then
    grep -E -ron --include=$2 "$1" . | tee lines-with-text.out
else
    grep -E -ron --include=$2 --exclude-dir=$3 "$1" . | tee lines-with-text.out
fi

COUNT=$(wc -l lines-with-text.out | sed s/lines-with-text.out// | sed s/\ \//)
FILES=$(cat lines-with-text.out)

echo "count=$COUNT" >> $GITHUB_OUTPUT

if [ ! -z "$COUNT" ]; then
    echo -e "${BOLD} ${RED}Text ($1) found, $COUNT incidences${NC} ${NORMAL}"
    
    if ([ $4 = true ] || [ $4 = "true" ]): then
        exit 1
    fi
else
    echo -e "${BOLD} ${GREEN}Text ($1) not found!${NC} ${NORMAL}"
fi



# echo "files=$FILES" >> $GITHUB_OUTPUT

# echo 'files<<EOF' >> $GITHUB_OUTPUT
# $FILES >> $GITHUB_OUTPUT
# echo 'EOF' >> $GITHUB_OUTPUT
