#!/bin/sh

# Execute userhook if present
USERHOOK=/media/card/autostart.sh
if [ -f $USERHOOK ]
then
  sh $USERHOOK
fi
