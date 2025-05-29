#!/bin/bash
if pgrep -x "polybar" > /dev/null; then
    # if running, KILL IT
else
    polybar
fi    
