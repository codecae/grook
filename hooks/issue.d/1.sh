#!/bin/bash
# -----------------
# Issue Hook Script
# -----------------
#
# This script will be executed by grook when a valid issue 
# web hook request has been receieved.  Issue web hooks can
# be received when they are first created or when an issue's
# state has been modified.
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
# 2) Description	The description of the issue as entered in Gitlab
# 3) Assignee 		The person to whom the issue was assigned
# 4) Author		The person who submitted the issue
# 5) Project Name	Name of the project in Gitlab.
# 6) Repo Name		Repository name in Gitlab.
# 7) State		The state of the issue
#
