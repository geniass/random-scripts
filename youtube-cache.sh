#!/bin/bash

# Blocks some of youtube's caches because ISPs like telkom throttle them. I'm now streaming youtube at 3.5 Mb/s
# Source: http://www.reddit.com/r/technology/comments/13kmvd/have_time_warner_internet_but_can_barely_stream/

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
