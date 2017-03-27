#!/bin/bash
:
'
        Copyright (C) 2017 Rafael Sene

        Licensed under the Apache License, Version 2.0 (the “License”);
        you may not use this file except in compliance with the License.
        You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

        Unless required by applicable law or agreed to in writing, software
        distributed under the License is distributed on an “AS IS” BASIS,
        WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
        See the License for the specific language governing permissions and
        limitations under the License.

        Contributors:
                * Rafael Sene <rpsene@gmail.com>

        This script was initially created on February 02, 2014. 
'


GERRIT_USER=<YOUR_GERRIT_USER>
GERRIT_SERVER=<YOUR_GERRIT_SERVER>
GERRIT_PROJECT_NAME=<YOUR_GERRIT_PROJECT_NAME>

function sshgerrit() {
        ssh -p 29418 ${GERRIT_USER}@${GERRIT_SERVER}
}

function gitDir() {
        gitdir=$(git rev-parse --git-dir); scp -p -P 29418 $GERRIT_USER@$GERRIT_SERVER:hooks/commit-msg ${gitdir}/hooks/commit-msg 
}

function appendGitConfigure() {
        echo "[remote \"review\"]
        url = ssh://$GERRIT_USER@$GERRIT_SERVER:29418/$GERRIT_PROJECT_NAME.git
        push = HEAD:refs/for/master" >> .git/config
}

#main execution
sshgerrit
gitDir
appendGitConfigure

echo "done !"
