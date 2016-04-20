#!/bin/bash

# mkdir -p ~/.ssh
# echo $SSH_KEY > ~/.ssh/id_rsa
# chmod 600 ~/.ssh/id_rsa

CHECK_BRANCH=`git branch --all | grep gh-pages`

if [ BRANCH_GH_PAGES ]; then
  echo Deleting gh-pages...
  git branch -D gh-pages
fi

git checkout -b gh-pages

echo Compiling Latex...

cd proposta
./compile.sh
mv proposta.pdf ../Proposta.pdf
cd ..

echo Compile done

rm -rf .gitignore
echo Deploying to Github pages...

git add .
git commit -m "Deploying TCC latest version"
git remote set-url origin git@github.com:jeffhsta/tcc.git
git push --force origin gh-pages

echo Deploy done
echo Cleaning up...

git checkout master
git branch -D gh-pages
git clean -fd .
git checkout .
rm *.pdf

echo Done!
