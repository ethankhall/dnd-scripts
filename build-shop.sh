#!/bin/sh

BASE_URL="https://donjon.bin.sh/5e/random/rpc-5e.fcgi"

function make_shop() {
    NICE_SIZE=$(echo $TOWN_SIZE | tr '+' ' ')
    COUNT=$(( $RANDOM % 5 + 7 ))

    echo "---"
    echo "Keywords: Shop, ${NICE_SIZE}, ${SHOP_TYPE}"
    echo "---"
    echo
    echo "# $SHOP_NAME"

    echo
    echo "## Location"
    curl -s "$BASE_URL?type=Magic+Shop+Location&n=1&town_size=${TOWN_SIZE}&shop_type=${SHOP_TYPE}" | jq '.[]' -r

    echo
    echo "## Description"
    curl -s "$BASE_URL?type=Magic+Shop+Description&n=1&town_size=${TOWN_SIZE}&shop_type=${SHOP_TYPE}" | jq '.[]' -r

    echo
    echo "## Shopkeeper"
    curl -s "$BASE_URL?type=Magic+Shopkeeper&n=1&shop_type=${SHOP_TYPE}" | jq '.[]' -r

    echo
    echo "## Items"
    curl -s "$BASE_URL?type=Magic+Shop+Item&n=$COUNT&sort=1&town_size=${TOWN_SIZE}&shop_type=${SHOP_TYPE}" | jq '.[] | "- " + .' -r

}

mkdir -p shop || true

for TOWN_SIZE in "Small+Town" "Small+City" "Village" "Hamlet" "Thorp"; do
    for SHOP_TYPE in "Trader" "Weaponsmith" "Armorer" "Alchemist" "Scribe" "Wandwright";
    do
        SHOP_NAME="$(curl -s "$BASE_URL?type=Magic+Shop+Name&n=1&shop_type=${SHOP_TYPE}" | jq '.[]' -r )"

        echo "Building $TOWN_SIZE $SHOP_TYPE's $SHOP_NAME"
        make_shop > shop/${SHOP_NAME}.md
    done
done