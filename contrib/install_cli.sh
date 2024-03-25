 #!/usr/bin/env bash

 # Execute this file to install the aipg cli tools into your path on OS X

 CURRENT_LOC="$( cd "$(dirname "$0")" ; pwd -P )"
 LOCATION=${CURRENT_LOC%Aipg-Qt.app*}

 # Ensure that the directory to symlink to exists
 sudo mkdir -p /usr/local/bin

 # Create symlinks to the cli tools
 sudo ln -s ${LOCATION}/Aipg-Qt.app/Contents/MacOS/esad /usr/local/bin/esad
 sudo ln -s ${LOCATION}/Aipg-Qt.app/Contents/MacOS/aipg-cli /usr/local/bin/aipg-cli
