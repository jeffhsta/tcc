#!/bin/bash

echo Compiling Latex...

cd proposta
./compile.sh
mv proposta.pdf ../Proposta.pdf
cd ..

echo Compile done

CHECK_BRANCH=`git branch --all | grep gh-pages`

if [ BRANCH_GH_PAGES ]; then
  echo Deleting gh-pages...
  git branch -D gh-pages
fi

echo Deploying to Github pages...

git checkout -b gh-pages
rm -rf .gitignore proposta/

git commit -a -m "Deploying TCC latest version"
git push --force origin gh-pages

echo Deploy done
echo Cleaning up...

git checkout master
git branch -D gh-pages
git clean -fd .
git checkout .

echo Done!
