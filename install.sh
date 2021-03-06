#!/bin/bash
trap 'exit' SIGTERM SIGINT

#公共函数
function LOG_ERROR()
{
	if (( $# < 1 ))
	then
		echo -e "\033[33m usesage: LOG_ERROR msg \033[0m";
	fi

	local msg=$(date +%Y-%m-%d" "%H:%M:%S);

    msg="${msg} $@";

	echo -e "\033[31m $msg \033[0m";
}

function LOG_WARNING()
{
	if (( $# < 1 ))
	then
		echo -e "\033[33m usesage: LOG_WARNING msg \033[0m";
	fi

	local msg=$(date +%Y-%m-%d" "%H:%M:%S);

    msg="${msg} $@";

	echo -e "\033[33m $msg \033[0m";
}

function LOG_DEBUG()
{
	if (( $# < 1 ))
	then
		LOG_WARNING "Usage: LOG_DEBUG logmsg";
	fi

	local msg=$(date +%Y-%m-%d" "%H:%M:%S);

    msg="${msg} $@";

 	echo -e "\033[40;37m $msg \033[0m";
}

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

if (( $# < 8 ))
then
    echo $#
    echo "$0 MYSQL_HOST MYSQL_PORT MYSQL_USER MYSQL_PASS TARS_WEB_HOST TARS_WEB_TOKEN ADMIN_SERVER_IP NODE_SERVER_IP REBUILD"
    echo "./install.sh 10.0.0.40 3306 root Arm@12345 http://192.168.122.118:3000 97f723e96bee3543948e69aa6d62d660596ee1bd 192.168.122.118 192.168.122.191 true"
    exit 1
fi


MYSQL_HOST=$1
MYSQL_PORT=$2
MYSQL_USER=$3
MYSQL_PASS=$4
TARS_WEB_HOST=$5
TARS_WEB_TOKEN=$6
ADMIN_SERVER_IP=$7
NODE_SERVER_IP=$8
REBUILD=$9
LOG_INFO "Mysql user:${MYSQL_USER}"
LOG_INFO "Mysql pass:${MYSQL_PASS}"
LOG_INFO "Mysql host:${MYSQL_HOST}"
LOG_INFO "Mysql port:${MYSQL_PORT}"
LOG_INFO "Tars Web Host:${TARS_WEB_HOST}"
LOG_INFO "Tars Web Token:${TARS_WEB_TOKEN}"
LOG_INFO "Tars Admin IP:${ADMIN_SERVER_IP}"
LOG_INFO "Tars Node IP:${NODE_SERVER_IP}"
LOG_INFO "Rebuild:${REBUILD}"

LOG_INFO "Start to install TarsBenchmark"
## install TarsBenchmark
echo "./install-tb.sh ${TARS_WEB_HOST} ${TARS_WEB_TOKEN} ${ADMIN_SERVER_IP} ${ADMIN_SERVER_IP}"
./install-tb.sh "${TARS_WEB_HOST}" "${TARS_WEB_TOKEN}" "${ADMIN_SERVER_IP}" "${ADMIN_SERVER_IP}"

#exec sql
function exec_mysql_sql()
{
    LOG_DEBUG "mysql -h${MYSQL_HOST} -u${MYSQL_USER} -p${MYSQL_PASS} -P${MYSQL_PORT} --default-character-set=utf8 -D$1 < $2"
    mysql -h${MYSQL_HOST} -u${MYSQL_USER} -p${MYSQL_PASS} -P${MYSQL_PORT} --default-character-set=utf8 -D$1 < $2

    ret=$?
    LOG_DEBUG "mysql return:${ret}"

    return $ret
}

mkdir -p patches

cp -f sql/* patches/
sed -i "s/localip.tars.com/${NODE_SERVER_IP}/g" patches/services.sql
sed -i "s/localip.tarsadmin.com/${ADMIN_SERVER_IP}/g" patches/services.sql
exec_mysql_sql db_tars patches/services.sql
exec_mysql_sql db_tars patches/db_test_tool_kit.sql

cp -f config/* patches/
sed -i "s/mysql.user/${MYSQL_USER}/g" patches/db.json
sed -i "s/mysql.password/${MYSQL_PASS}/g" patches/db.json
sed -i "s/mysql.address/${MYSQL_HOST}:${MYSQL_PORT}/g" patches/db.json
sed -i "s#tars.web.host#${TARS_WEB_HOST}#g" patches/kv.json
sed -i "s/tars.web.token/${TARS_WEB_TOKEN}/g" patches/kv.json

curl -s -X POST -H "Content-Type: application/json" \
  ${TARS_WEB_HOST}/api/add_config_file?ticket=${TARS_WEB_TOKEN} \
  -d@patches/db.json|echo
curl -s -X POST -H "Content-Type: application/json" \
  ${TARS_WEB_HOST}/api/add_config_file?ticket=${TARS_WEB_TOKEN} \
  -d@patches/kv.json|echo

if [[ $REBUILD = "true" ]]; then
  ## start to build TestUnits
  git clone https://github.com/TarsTestToolKit/TestUnits.git
  cd TestUnits
  ./build-docker.sh
  mv ./patches/* ../patches
  cd ..

  ## build backend
  ./build-backend.sh
fi

## TestUnits.GolangTars
LOG_INFO "upload_and_publish TestUnits.GolangTars"
curl -i --request POST "${TARS_WEB_HOST}/api/upload_and_publish?ticket=${TARS_WEB_TOKEN}" \
  --form "suse=@./patches/GolangTars.tgz" \
  --form "application=TestUnits" \
  --form "module_name=GolangTars" \
  --form "comment=developer-auto-upload"

## TestUnits.PhpTars
LOG_INFO "upload_and_publish TestUnits.PhpTars"
curl -i --request POST "${TARS_WEB_HOST}/api/upload_and_publish?ticket=${TARS_WEB_TOKEN}" \
  --form "suse=@./patches/PhpTars.tar.gz" \
  --form "application=TestUnits" \
  --form "module_name=PhpTars" \
  --form "comment=developer-auto-upload"

## TestUnits.JavaTars
LOG_INFO "upload_and_publish TestUnits.JavaTars"
curl -i --request POST "${TARS_WEB_HOST}/api/upload_and_publish?ticket=${TARS_WEB_TOKEN}" \
  --form "suse=@./patches/JavaTars.jar" \
  --form "application=TestUnits" \
  --form "module_name=JavaTars" \
  --form "comment=developer-auto-upload"

## TestUnits.CppTars
LOG_INFO "upload_and_publish TestUnits.CppTars"
curl -i --request POST "${TARS_WEB_HOST}/api/upload_and_publish?ticket=${TARS_WEB_TOKEN}" \
  --form "suse=@./patches/CppTars.tgz" \
  --form "application=TestUnits" \
  --form "module_name=CppTars" \
  --form "comment=developer-auto-upload"

## TestUnits.NodejsTars
LOG_INFO "upload_and_publish TestUnits.NodejsTars"
curl -i --request POST "${TARS_WEB_HOST}/api/upload_and_publish?ticket=${TARS_WEB_TOKEN}" \
  --form "suse=@./patches/NodejsTars.tgz" \
  --form "application=TestUnits" \
  --form "module_name=NodejsTars" \
  --form "comment=developer-auto-upload"

## TarsTestToolKit.ResFetcher
LOG_INFO "upload_and_publish TarsTestToolKit.ResFetcher"
curl -i --request POST "${TARS_WEB_HOST}/api/upload_and_publish?ticket=${TARS_WEB_TOKEN}" \
  --form "suse=@./patches/ResFetcher.tgz" \
  --form "application=TarsTestToolKit" \
  --form "module_name=ResFetcher" \
  --form "comment=developer-auto-upload"

## TarsTestToolKit.BackendApi
LOG_INFO "upload_and_publish TarsTestToolKit.BackendApi"
curl -i --request POST "${TARS_WEB_HOST}/api/upload_and_publish?ticket=${TARS_WEB_TOKEN}" \
  --form "suse=@./patches/BackendApi.tgz" \
  --form "application=TarsTestToolKit" \
  --form "module_name=BackendApi" \
  --form "comment=developer-auto-upload"

## TarsTestToolKit.Frontend
LOG_INFO "upload_and_publish TarsTestToolKit.Frontend"
curl -i --request POST "${TARS_WEB_HOST}/api/upload_and_publish?ticket=${TARS_WEB_TOKEN}" \
  --form "suse=@./patches/Frontend.tgz" \
  --form "application=TarsTestToolKit" \
  --form "module_name=Frontend" \
  --form "comment=developer-auto-upload"
