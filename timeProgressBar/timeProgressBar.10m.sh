#!/bin/bash

# <bitbar.title>Life Progress Bar</bitbar.title>
# <bitbar.version>v0.1</bitbar.version>
# <bitbar.author>Francois L</bitbar.author>

# Constants
histogramWidth=20

function makeBar () {
    restLength=$(echo $2 - $1 | bc);
    for i in `seq 1 $1`; do
        echo -n █
    done
    for i in `seq 1 $restLength`; do
        #echo -n ▓
        echo -n  □
    done
}

# Get the day of year (0.. 365)
dayOfYear=$(date +%j)

# Percent of year that has passed
yearPercent=$(printf %.2f $(echo $dayOfYear/365*100 | bc -l))
yearBarWidth=$(printf %.0f $(echo $yearPercent*$histogramWidth/100 | bc -l))

# Menubar elements 
echo "Year: " $yearPercent%

echo ---

# Sub menus, with loading bar
makeBar $yearBarWidth $histogramWidth
echo " Year: " $yearPercent%

