#!/bin/bash
# run this script as root
# it will install the binary to /usr/local/bin

sudo apt-get install golang-go libmtp-dev
mkdir /tmp/go 
export GOPATH=/tmp/go
go get github.com/hanwen/go-mtpfs
sudo cp /tmp/go/bin/go-mtpfs /usr/local/bin
