#!/bin/bash
set -e
CURRENT_VER=$(/usr/local/go/bin/go version | awk 'BEGIN {FS="go";}{print $3}' | awk '{print $1}')
VER=$(wget -q -O - https://golang.org/dl/ | grep "/dl/go" -m 1 | awk 'BEGIN {FS="go";}{print $2}' | cut -d '.' -f1-3)

if [[ "$VER" == "$CURRENT_VER" ]];then
    echo "already on latest version $CURRENT_VER"
    exit 1
fi
if [[ $UID != 0 ]]; then
    echo "Please run this script with sudo:"
    echo "sudo $0 $*"
    exit 1
fi

echo "updating from $CURRENT_VER to version $VER"

FILE="go${VER}.linux-amd64.tar.gz"

#download new version
dlURL="https://golang.org/dl/${FILE}"
wget $dlURL

# delete old version
rm -rf /usr/local/go

# extract new version
sudo tar -C /usr/local -xzf $FILE 

# cleaup
rm $FILE
echo "=============Install Complete============="
echo ""
/usr/local/go/bin/go version
