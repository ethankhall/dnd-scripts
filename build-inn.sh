#!/bin/sh

function build_inn() {
    echo "---"
    echo "Keywords: Inn, ${INN_TYPE} Inn"
    echo "---"
    echo
    echo "$INN_NAME"

    echo "## Location"
    curl -s "https://donjon.bin.sh/fantasy/random/rpc-fantasy.fcgi?type=$INN_TYPE+Inn+Location&n=1" | \
        jq '.[]' -r

    echo
    echo "## Description"
    curl -s "https://donjon.bin.sh/fantasy/random/rpc-fantasy.fcgi?type=$INN_TYPE+Inn+Description&n=1" | \
        jq '.[]' -r

    echo
    echo "## Inkeeper"
    curl -s "https://donjon.bin.sh/fantasy/random/rpc-fantasy.fcgi?type=${INN_TYPE}+Innkeeper&n=1" | \
        jq '.[]' -r

    echo
    echo "## Menu"
    curl -s "https://donjon.bin.sh/fantasy/random/rpc-fantasy.fcgi?type=$INN_TYPE+Inn+Fare&n=5" | \
    jq '.[] | "- " + .' -r

    echo
    echo "## Commoner NPC's"
    curl -s "https://donjon.bin.sh/fantasy/random/rpc-fantasy.fcgi?type=Inn+NPC&n=5&order=Common" | \
        jq '.[] | "- " + .' -r

    echo
    echo "## Adventurer NPC's"
    curl -s "https://donjon.bin.sh/fantasy/random/rpc-fantasy.fcgi?type=Inn+NPC&n=5&order=Adventurer" | \
        jq '.[] | "- " + .' -r

    echo
    echo "## Rumors"
    curl -s "https://donjon.bin.sh/fantasy/random/rpc-fantasy.fcgi?type=$INN_TYPE+Inn+Rumor&n=5" | \
        jq '.[] | "- " + .' -r
}

mkdir -p inn || true
for INN_TYPE in "Poor" "Common" "Good";
do
    INN_NAME="$(curl -s "https://donjon.bin.sh/fantasy/random/rpc-fantasy.fcgi?type=$INN_TYPE+Inn+Name&n=1" | jq -r '.[]' )"
    echo "Building ${INN_NAME}"
    build_inn > inn/${INN_NAME}.md
done