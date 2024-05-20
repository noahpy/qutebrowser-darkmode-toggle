#! /bin/sh

CONFIG_PATH=~/.config/qutebrowser/config.py

set_light(){
    sed -i "s/webpage\.darkmode\.enabled\",[ ]*\([a-zA-Z]*\)[ ]*)/webpage\.darkmode\.enabled\", False)/" $CONFIG_PATH
}

set_dark(){
    sed -i "s/webpage\.darkmode\.enabled\",[ ]*\([a-zA-Z]*\)[ ]*)/webpage\.darkmode\.enabled\", True)/" $CONFIG_PATH
}

MODE=$(cat $CONFIG_PATH | sed -n "s/.*webpage\.darkmode\.enabled\",[ ]*\([a-zA-Z]*\)[ ]*)/\1/p")


# stop and save qutebrowser if running
ps -A | grep -q 'qutebrowser' && qutebrowser :wq

if [[ $MODE = "True" ]]; then
    echo "Setting to light mode..."
    set_light
else
    echo "Setting to dark mode..."
    set_dark
fi

# restart qutebrowser
qutebrowser &
