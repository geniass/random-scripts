#!/bin/bash
# run this script as root
# it will install the binary to /usr/local/bin

die () {
    echo >&2 "$@"
    exit 1
}

sudo apt-get install golang-go libmtp-dev
mkdir -p /tmp/go 
export GOPATH=/tmp/go
go get github.com/hanwen/go-mtpfs
sudo cp /tmp/go/bin/go-mtpfs /usr/local/bin
echo "Installed go-mtpfs to /usr/local/bin"

echo "Enter the device's Vendor ID (e.g., mtp-detect (VID)):"
read vID
echo $vID | grep -E -q '^[0-9a-z]+$' || die "Hex. argument required, $vID provided"

echo "Enter the device's Product ID (e.g., mtp-detect (PID)):"
read pID
echo $pID | grep -E -q '^[0-9]+$' || die "Numeric argument required, $pID provided"

rules='SUBSYSTEM=="usb", ATTR{idVendor}=="VENDORID", ATTR{idProduct}=="PRODUCTID", MODE="0666"'

rules=${rules/VENDORID/$vID}
rules=${rules/PRODUCTID/$pID}
echo $rules

echo $rules | sudo tee -a /etc/udev/rules.d/51-android.rules >/dev/null
echo "Written rules to /etc/udev/rules.d/51-android.rules"

sudo service udev restart
sudo adduser `whoami` fuse

allow=`sudo grep "user_allow_other" /etc/fuse.conf`
if [ -z $allow ]
then
    sudo `echo "user_allow_other" >> /etc/fuse.conf`
    echo "fuse is now configured"
else
    if [ `expr match "$allow" '\#'` -ne 0 ]
    then
        sudo sed -i 's/#user_allow_other/user_allow_other/g' /etc/fuse.conf
        echo "fuse is now configured"
    else
        echo "fuse already configured"
    fi
fi

echo "done"
