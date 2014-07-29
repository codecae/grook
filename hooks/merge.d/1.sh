#!/bin/bash
# -----------------
# Merge Hook Script
# -----------------
#
# This script will be executed by grook when a valid merge 
# web hook request has been receieved.  Merge web hooks can
# be received when they are first created or when an merge's
# state or status has been modified.
#
# You can create as many scripts in this directory as you want.
# 
# Keep in mind, though, the scripts will be executed in
# alphabetical order, so make sure they are are named in 
# such a way to handle any dependencies you may have on 
# other scripts.  For example, naming the files 001.sh, 
# 002.sh, 003.sh, etc will ensure their order of execution.
#
# The scripts can be any flavor you prefer.  This example
# file was created with a .sh extention purely for example
# purposes.
#
# Grook will pass the following parameters in the following 
# order to every script in this directory:
#
# 1) Title		The title of the issue as entered in Gitlab
# 2) Description	The description of the issue as entered in Gitlaba
# 3) Target Branch	Branch to which this merge should be applied
# 4) Source Branch	Branch from which the merge was requested
# 5) Target Project	Project to which this merge should be applied
# 6) Source Project	Project from which the merge was requested
# 7) Assignee 		The person to whom the issue was assigned
# 8) Author		The person who submitted the issue
# 9) State		The state of the merge
# 10) Status		The status of the merge
#
