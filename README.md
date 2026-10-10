# Simple Antivirus Daemon 

## Overview
* antivirusd.sh -> this is a shell script which runs on a directory (dir) to check for one of the following : 

  1- flagged extensions 

  2- flagged content

it works as follows :
  Each specific time interval it compares the previous directory information with the new directory information. if they are similar, it waits and repeats. if they are different, it scans the directory and quarantines the flagged files and updates the previous directory information with the new one.

* restore.sh-> this is a shell script which runs on malicious directory (Malicious_dir) to do the following :

    1- it prints a numbered list of files currently in the malicious directory

    2- it gives the user the following options :

     1-restore this file from malicious directory into the directory (useful if file was detected as malicious but it isn't)

     2-permanently delete the file 

     3-leave file as is 


* Makefile-> has 3 targets in it , A target is basically a function call but can have dependencies , what are dependencies? it means "before performing this task , make this first "

  target 1: the Pre-build step that creates  malicious_dir if it doesn't exist

  target 2: runs the antivirus script and depends on setup (target 1)

  target 3: runs the restore script and depends on setup (target 1)


## The folder hierarchy is as follows:

 9357-lab2/

  |--- antivirusd.sh
  
  |--- restore.sh
  
  |--- Makefile
  
  |--- README.md

## prerequisites
 - ubuntu/linux environment
 - Bash

  to install,write the following in terminal:

   sudo apt update

   sudo apt install bash
 
 - Make 

  to install, write the following in terminal:

   sudo apt update

   sudo apt install make 

## HOW TO RUN 
* in terminal write (make antivirus)


   1-setup creates malicious_dir if needed

   2-antivirusd.sh starts monitoring dir

   3-it checks at the interval defined in the Makefile

   4-press Ctrl+c to stop 

 * in the terminal write (make restore)


    1-setup creates malicious_dir if needed

    2-restore.sh checks if malicious_dir is empty it exits script

    3-if not empty, it prints numbered list with the file names

    4- a menu displayed with the options mentioned earlier 

    5-press Ctrl+c
    

## flagged extensions and keywords 
  flagged extensions and keywords are hardcoded in antivirusd.sh script lines 6 and 7 , they are put in an array (flagged_extensions,flagged_contents) to make it easier for looping for detection 

## Whitelist 
   whitelist idea is as follow , we create a file that has the name of all the files that were false positive or restored after detection and deletion so that when scanning again it checks that file first , if the file is in the whitelist then just skip it 


## cron job
 a cron job is basically a scheduled command that the user can control ,it can schedule any shell command , including running a script 

** antivirus-cron.sh -----> the same file as the antivirusd.sh , without the while loop , it runs every scheduled time edited in the crontab 

** how to run:

1- in the terminal run  

  crontab -e 

2- enter the values according to the format

   [minute] [hour] [day of month] [month] [day of week] path && command

3- to get path , write in terminal pwd 

4- command will be in the form:

  bash scriptname parameter parameter (in our case : bash antivirus-cron.sh dir malicious_dir) 

5- ctrl o to save 

6- enter to confirm file 

7-ctrl x to exit corntab editor 

8-to check if it has been saved 

  crontab -l

9-to check if running

  systemctl status cron 

  look for Active:active(running)


note: in lab , requirement  is every 1 minute and 23 seconds , no seconds field so we put (sleep 23) in the script 

