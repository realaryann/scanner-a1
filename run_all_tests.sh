#!/bin/bash

for testfile in ./tests/good*.bminor
do
    if ./scan "$testfile" > "$testfile.out"
    then
        echo "$testfile success (as expected)"
    else
        echo "$testfile failure (INCORRECT)"
    fi
    rm "$testfile.out"
done

for testfile in ./tests/bad*.bminor
do
    if ./scan "$testfile" > "$testfile.out"
    then
        echo "$testfile success (INCORRECT)"
    else
        echo "$testfile failure (as expected)"
    fi
    rm "$testfile.out"
done