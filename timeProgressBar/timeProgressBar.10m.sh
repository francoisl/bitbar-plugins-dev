#!/bin/bash

# <bitbar.title>Time Progress Bar</bitbar.title>
# <bitbar.version>v0.5</bitbar.version>
# <bitbar.author>Francois L</bitbar.author>

# Constants
histogramWidth=20

function makeBar () {
    restLength=$(echo $2 - $1 | bc);
    for i in `seq 1 $1`; do
        echo -n █
    done
    for i in `seq 1 $restLength`; do
        echo -n  □
    done
}

# Get the day of year (0.. 365)
dayOfYear=$(date +%j)
dayOfMonth=$(date +%d)

# Percent of year that has passed
yearPercent=$(printf %.2f $(echo $dayOfYear/365*100 | bc -l))
yearBarWidth=$(printf %.0f $(echo $yearPercent*$histogramWidth/100 | bc -l))

# Percent of the month that has passed
daysInMonth=$(cal $(date +"%m %Y") | awk 'NF {DAYS = $NF}; END {print DAYS}')
monthPercent=$(printf %.2f $(echo $dayOfMonth/$daysInMonth*100 | bc -l))
monthBarWidth=$(printf %.0f $(echo $monthPercent*$histogramWidth/100 | bc -l))

# Menubar elements 
echo "Year: " $yearPercent%
echo "Month: " $monthPercent%

echo ---

# Sub menus, with loading bar
makeBar $yearBarWidth $histogramWidth
echo " Year: " $yearPercent%
makeBar $monthBarWidth $histogramWidth
echo " Month: " $monthPercent%

