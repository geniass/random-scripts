#!/bin/bash

YT_CACHE_URL=173.194.55.0/24

block(){
    sudo iptables -I INPUT -s $YT_CACHE_URL -j REJECT
}

unblock(){
    sudo iptables -D INPUT -s $YT_CACHE_URL -j REJECT
}

func(){
    case $1 in
        b) echo "Blocking youtube cache... ($YT_CACHE_URL)" ; block ;;
        u) echo "Unblocking youtube cache... ($YT_CACHE_URL" ; unblock ;;
    *) echo "first argument must be 'b' (block) or 'u' (unblock)" ;;
        esac
}

func $1
