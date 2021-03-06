#!/bin/bash
# Created by martin on 24/01/2019

set -e

pushd $(dirname $0) > /dev/null
SCRIPTPATH=$(pwd -P)
popd > /dev/null
SCRIPTFILE=$(basename $0)

function log() {
    echo "================================================================================"
    echo "$(date +'%Y-%m-%d %H:%M:%S%z') [INFO] - $@"
    echo ""
}

function err() {
    echo "================================================================================"
    echo "$(date +'%Y-%m-%d %H:%M:%S%z') [ERRO] - $@" >&2
}

function stop(){
    docker container stats etcd

    docker stop etcd
    # 删除容器
    docker rm etcd
}

function start(){
    docker run  -d -p 2380:2380 -p 2379:2379 -p 4001:4001 \
    --name etcd -v /root/opt/etcd/config:/config quay.io/coreos/etcd:v3.3.10 \
    etcd -config-file="/config/etcd.yml"
}

#stop
start
