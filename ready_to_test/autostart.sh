#!/bin/sh

# Program EDID if ADV7611 subdev node exists
DEVNAME=$(media-ctl -e "adv7611 4-004c")
if [ -c $DEVNAME ] 2> /dev/null
then
    echo "Programming EDID into ADV7611..."
    edid $DEVNAME 0 /usr/local/lib/firmware/edid.bin
fi

# Set Qt fonts path and start Qt application
export QT_QWS_FONTDIR=/usr/lib/fonts
export PATH=$PATH:/media/card/bin
echo "Starting Zynq Base TRD Application..."
run_video.sh -qt &

# Print info
echo "To re-run this application, type the following commands:"
echo "run_video.sh -qt"
