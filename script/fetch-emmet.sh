#!/usr/bin/env bash -e

mkdir tmp
git clone git@github.com:emmetio/emmet.git tmp/emmet
cd tmp/emmet
npm i
$(npm bin)/gulp app
cp dist/emmet-app.js ../../app/js/emmet.js
cd ../..
rm -rf tmp
