#!/bin/bash
# Define the filenames for the output files
ACTIVE_JOBS_FILE="Active_jobs.txt"
Disabled_JOBS_FILE="Disabled_jobs.txt"

# Read the list of jobs from the file
LIST_OF_JOBS=$(cat listofjenkinsprodjobs.log)
# IFS=$'\n'
while read i; do
# for i in $LIST_OF_JOBS
# do
# Get the Jenkins job status
t=$(echo "${i}" | sed 's/ /%20/g')
STATUS=$(curl -k --silent https://jenkins.infotainment.prod.atieva.com/job/"$t"/api/json | jq -r '.color')
# Check the status and print a message
 case $STATUS in
    "blue")
        echo  "$i" >> "$ACTIVE_JOBS_FILE"
        ;;
    "blue_anime")
        echo "$i" >> "$ACTIVE_JOBS_FILE"
        ;;
    "yellow")
        echo "$i" >> "$ACTIVE_JOBS_FILE"
        ;;
    "red")
        echo " $i" >> "$ACTIVE_JOBS_FILE"
        ;;
    "disabled")
        echo "$i" >> "$Disabled_JOBS_FILE"
        ;;
    "notbuilt")
        echo "$i"  >> "$ACTIVE_JOBS_FILE"
        ;;
    "aborted")
        echo "$i" >> "$ACTIVE_JOBS_FILE"
        ;;
    *)
        echo "$i" >> "$Disabled_JOBS_FILE"
        ;;
esac
# done 
done <<< "$(cat listofjenkinsprodjobs.log)"
