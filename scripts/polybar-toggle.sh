#!/bin/bash
if pgrep -x "polybar" > /dev/null; then
    # if running, KILL IT
    pkill polybar
else
    polybar
fi    
