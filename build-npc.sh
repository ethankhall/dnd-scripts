#!/bin/sh

BASE_URL="https://donjon.bin.sh/fantasy/random/rpc-fantasy.fcgi"

function make_npc() {
    echo "---"
    echo "Keywords: NPC, ${NPC_TYPE}"
    echo "---"
    echo
    curl -s "$BASE_URL?type=NPC&race=&gender=&order=${NPC_TYPE}&culture=&n=20" | jq -r '.[] | "1. " + .'
}

mkdir -p npc || true

for NPC_TYPE in "Arcane" "Divine" "Martial" "Scoundrel" "Wild" "Common"; do
    make_npc > npc/$NPC_TYPE.md
done