#!/bin/bash


handler()
{
    for p in $PID
    do
        #echo "killing $p"
        kill -s TERM $p
    done
    wait $PID
}

trap handler SIGINT

for joy in /dev/input/js*
do
    echo "testing $joy"
    jstest $joy > /dev/null &
    PID="$! $PID"
done

echo "waiting for sigint"
wait $PID
echo "done waiting on PIDs"

echo "exiting"

