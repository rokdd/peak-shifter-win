# peak-shifter-win

Based on (this thread)[https://forums.lenovo.com/topic/view/2578/4345631] at the lenovo community, I thought it might helpful to have like a automatic mechanism to stop charging when the sun is not shining or electricity is more expensive.


## Installation

Download the (ChargeThreshold.exe)[https://download.lenovo.com/pccbbs//thinkvantage_en/metroapps/Vantage/ChargeThreshold/ChargeThreshold.exe] from here and copy it to the same folder like the batch files.

## Getting started

The concept is very simple..
So the easiest thing is open the batch examples I provided, edit by you desires and start the file once (or after each editing). The parameters for configure are:
- ´-time-peak=xx-yy´ xx=starting hour of the peak time in 24h format and with a leading zero (two digits),yy=ending hour of the peak time in 24h format and with a leading zero (two digits)


Afterwards it adds a Scheduled task in windows which will be triggered at the next given time, based on your inputs.
 
## Features

- 

## Future tasks

- check whether the thresholds are allowed
- when running should be no inputs any more
- explain how to stop or remove