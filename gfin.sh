#!/bin/bash

cd $PWD

git add .
git commit
git checkout master
git merge dev
git push origin master


# Test line
