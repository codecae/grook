#!/bin/bash
# -----------------
# Push Hook Script
# -----------------
#
# This script will be executed by grook when a valid push 
# web hook request has been receieved.
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
# Grook will pass the following parameters in the following in 
# order to every script in this directory:
#
# 1) Before ref hash	The git ref to which the push was applied. 
#			(ex: 2b3905f6ab2ae6807b1d247b9b1037e2e9b00d33)
# 2) After ref hash	The git ref of the latest commit in the push 
#			(ex: same as above)
# 3) Branch ref		The branch ref being pushed.
#			(ex: refs/heads/master)
# 4) User		The person who pushed the commit.
# 5) Project Name	Name of the project in Gitlab.
# 6) Repo Name		Repository name in Gitlab.
# 7) Repo URL		Web URL of the Gitlab repository.
# 8) Total commits	Number of commits in the push.
#

. ~/biee.env

STAGE_RPD=/u01/metadata/stage/RPD/stage.rpd
PATCHED_RPD=/u01/metadata/deploy/RPD/patched.rpd
PATCH_XML=/u01/metadata/stage/patches/clus5.xml

patchrpd -P Admin123 -C $STAGE_RPD -Q Admin123 -G $STAGE_RPD -I $PATCH_XML -O $PATCHED_RPD

