#!/bin/bash

# <bitbar.title>Time Progress Bar</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author>Francois L</bitbar.author>

# Constants
histogramWidth=20

function makeBar () {
    restLength=$(echo $2 - $1 | bc);
    fullBar=""
    for i in `seq 1 $1`; do
        fullBar=$fullBar"▆"
    done
    if (($restLength > 0)); then
        for i in `seq 1 $restLength`; do
            fullBar=$fullBar"-"
        done
    fi
    echo [$fullBar]
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

# Percent of the day
minutesSpentToday=$(echo "$(date +%H) * 60 + $(date +%M)" | bc)
dayPercent=$(printf %.2f $(echo $minutesSpentToday/1440*100 | bc -l))
dayBarWidth=$(printf %.0f $(echo $dayPercent*$histogramWidth/100 | bc -l))

# Menubar elements 
echo "Year: $yearPercent% | dropdown=false"
echo "Month: $monthPercent% | dropdown=false"
echo "Day: $dayPercent% | dropdown=false"

echo ---

# Sub menus, with loading bar
yearBar=$(makeBar $yearBarWidth $histogramWidth)
echo "$yearBar Year:  $yearPercent% | font=Courier"
monthBar=$(makeBar $monthBarWidth $histogramWidth)
echo "$monthBar Month: $monthPercent% | font=Courier"
dayBar=$(makeBar $dayBarWidth $histogramWidth)
echo "$dayBar Day:   $dayPercent% | font=Courier"

