#!/bin/bash

path=/opt/hyperion
x11=$path/bin/hyperion-x11
hyperiond=$path/bin/hyperiond


function start_fct() {
      pidof hyperiond || `$hyperiond $path/config/hyperion.config.json > /dev/null 2>&1 &`
      pidof hyperion-x11 || `$x11 --crop-right 1440 --skip-reply > /dev/null 2>&1 &`
}

function stop_fct() {
    `$path/bin/hyperion-remote -c black > /dev/null 2>&1 &` && sleep 1s
    pidof hyperiond && killall $hyperiond 
    pidof hyperion-x11 && killall $x11
}

if [[ "$#" != 1 ]]; then
    arg=start
else
    arg=$1
fi

case $arg in
    start) start_fct ;;
    stop) stop_fct ;;
esac


exit 0;
