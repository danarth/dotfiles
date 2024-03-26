#!/bin/bash  
if [[ "$(setxkbmap -query | awk '/layout/ {print $2}')" == "gb" ]]; then  
  setxkbmap us  
else  
  setxkbmap gb  
fi  
