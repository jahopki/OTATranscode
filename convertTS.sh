#! /bin/bash

#Plex DVR Postprocessing script
#primarily used to convert OTA MPEG2 format to Apple mp4

# sleep to allow copy of comskipped video to copy over original video
sleep 3

# SUPER important!  handbrake won't work with the version of (something?) packaged with Plex
export LD_LIBRARY_PATH="/usr/lib/x86_64-linux-gnu"

log=/Plex/transcode_tmp/logs/postProcess.$$.out
time=`date '+%Y-%m-%d %H:%M:%s'`
inFile="$1"
output="${inFile%.*}.mp4"
handbrake=/usr/bin/HandBrakeCLI

echo "will attempt to execute ${handbrake} -i \"${inFile}\" -v --preset \"Devices/Apple 1080p30 Surround\" --encoder x265 --encoder-preset \"faster\" -s \"none\" -o \"${output}\" -O" | tee -a ${log}

echo "'$time' transcode starting input [${inFile}] output [${output}]" | tee -a ${log}

${handbrake} -i "${inFile}" -v --preset "Devices/Apple 1080p30 Surround" --encoder x265 --encoder-preset "faster" -s "none" -o "${output}" -O >> ${log} 2>&1

echo "'$time' transcode finished.  removing ${inFile}" | tee -a ${log}

rm "${inFile}"

exit 0
