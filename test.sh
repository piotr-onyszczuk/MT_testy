#!/bin/bash

mkdir -p results

for a in $(cat tests.txt); do
    echo "Running test: $a"

    error=0

    mono $1 "tests/$a"

    if [ $? -eq 0 ]; then
        ilasm "tests/${a}.il" > /dev/null

        if [ $? -eq 0 ]; then
            peverify --verify all "tests/${a}.exe"

            if [ $? -eq 0 ]; then
                mono "tests/${a}.exe" > "results/${a}"

                if [ $? -ne 0 ]; then
                    error=2
                fi
            else
                error=2
            fi
        else
            error=2
        fi
    else
        error=1
    fi

    if [ $error -eq 1 ]; then
        echo -n "error" > "results/$a"
    elif [ $error -eq 2 ]; then
        echo -n "critical_error" > "results/$a"
    fi
done

echo "Errors detected:" > errors.txt

for a in $(cat tests.txt); do
    diff -b "expected_results/$a" "results/$a" > /dev/null
    if [ $? -ne 0 ]; then
        echo -e "\nTest: $a" >> errors.txt
        diff -b "expected_results/$a" "results/$a" >> errors.txt
    fi
done
