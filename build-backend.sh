#!/bin/bash

git clone https://github.com/TarsTestToolKit/ResFetcher.git
docker run -v $(pwd)/ResFetcher:/root/src mcfranklee/tars-buildenv:latest sh -c "cd /root/src/ResFetcher && rm -rf *.tgz && make && make tar"
mv ResFetcher/ResFetcher.tgz patches/

git clone https://github.com/TarsTestToolKit/BackendApi.git
docker run -v $(pwd)/BackendApi:/root/src mcfranklee/tars-buildenv:latest sh -c "cd /root/src/BackendApi && rm -rf *.tgz && make && make tar"
mv BackendApi/BackendApi.tgz patches/