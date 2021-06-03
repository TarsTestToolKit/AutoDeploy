#!/bin/bash

git clone https://github.com/TarsTestToolKit/ResFetcher.git
docker run -v $(pwd)/ResFetcher:/root/src tarscloud/compiler:latest sh -c "cd /root/src/ && rm -rf *.tgz && go env -w GOPROXY='https://goproxy.cn,direct' && make && make tar"
mv ResFetcher/ResFetcher.tgz patches/

git clone https://github.com/TarsTestToolKit/BackendApi.git
docker run -v $(pwd)/BackendApi:/root/src tarscloud/compiler:latest sh -c "cd /root/src/ && rm -rf *.tgz && go env -w GOPROXY='https://goproxy.cn,direct' && make && make tar"
mv BackendApi/BackendApi.tgz patches/

