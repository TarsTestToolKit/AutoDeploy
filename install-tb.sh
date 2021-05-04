#!/bin/bash

function LOG_INFO()
{
	if (( $# < 1 ))
	then
		LOG_WARNING "Usage: LOG_INFO logmsg";
	fi

	local msg=$(date +%Y-%m-%d" "%H:%M:%S);

	for p in $@
	do
		msg=${msg}" "${p};
	done

	echo -e "\033[32m $msg \033[0m"
}

WEB_HOST=$1
WEB_TOKEN=$2
ADMINS_IP=$3
NODE_IP=$4
LOG_INFO "Web host:${WEB_HOST}"
LOG_INFO "Web token:${WEB_TOKEN}"
LOG_INFO "Admins IP:${ADMINS_IP}"
LOG_INFO "Node IP:${NODE_IP}"

git clone https://github.com/TarsCloud/TarsBenchmark.git
docker run -v $(pwd)/TarsBenchmark:/root/src mcfranklee/tars-buildenv:latest sh -c "cd /root/src/TarsBenchmark && rm -rf build && mkdir build && cd build && cmake .. && make all && make tar"

cd TarsBenchmark
LOG_INFO "===>install benchmark template:\n";
curl -s -X POST -H "Content-Type: application/json" http://${TARS_WEB_HOST}/api/add_profile_template?ticket=${TARS_WEB_TOKEN} -d@assets/template.json|echo

LOG_INFO "===>install nodeserver:\n";
sed -i "s/host_ip/$NODE_SERVER_IP/g" assets/nodeserver.json
curl -s -X POST -H "Content-Type: application/json" http://${TARS_WEB_HOST}/api/deploy_server?ticket=${TARS_WEB_TOKEN} -d@assets/nodeserver.json|echo
LOG_INFO "===>install adminserver:\n";
sed -i "s/host_ip/$ADMIN_SERVER_IP/g" assets/adminserver.json
curl -s -X POST -H "Content-Type: application/json" http://${TARS_WEB_HOST}/api/deploy_server?ticket=${TARS_WEB_TOKEN} -d@assets/adminserver.json|echo

cd build
LOG_INFO "===>upload adminserver:\n"
curl -s http://${TARS_WEB_HOST}/api/upload_and_publish?ticket=${TARS_WEB_TOKEN} -Fsuse=@AdminServer.tgz -Fapplication=benchmark -Fmodule_name=AdminServer -Fcomment=auto-upload|echo
LOG_INFO "===>upload nodeserver:\n"
curl -s http://${TARS_WEB_HOST}/api/upload_and_publish?ticket=${TARS_WEB_TOKEN} -Fsuse=@NodeServer.tgz -Fapplication=benchmark -Fmodule_name=NodeServer -Fcomment=auto-upload