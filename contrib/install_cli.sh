 #!/usr/bin/env bash

 # Execute this file to install the esa cli tools into your path on OS X

 CURRENT_LOC="$( cd "$(dirname "$0")" ; pwd -P )"
 LOCATION=${CURRENT_LOC%Esa-Qt.app*}

 # Ensure that the directory to symlink to exists
 sudo mkdir -p /usr/local/bin

 # Create symlinks to the cli tools
 sudo ln -s ${LOCATION}/Esa-Qt.app/Contents/MacOS/esad /usr/local/bin/esad
 sudo ln -s ${LOCATION}/Esa-Qt.app/Contents/MacOS/esa-cli /usr/local/bin/esa-cli
