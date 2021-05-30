# Auto Deploy

```bash
sudo /bin/bash install.sh $MYSQL_HOST $MYSQL_PORT $MYSQL_USER $MYSQL_PASS $TARS_WEB_HOST $TARS_WEB_TOKEN $ADMIN_SERVER_IP $NODE_SERVER_IP
```

| Parameter       | Explain                                                                |
| --------------- | ---------------------------------------------------------------------- |
| MYSQL_HOST      | The host of your tars framework MYSQL                                  |
| MYSQL_PORT      | The port of your tars framework MYSQL                                  |
| MYSQL_USER      | The user to login and execute SQL(must have create database privilege) |
| MYSQL_PASS      | The password of the given user                                         |
| TARS_WEB_HOST   | The host of tars web, including IP and port. eg: 127.0.0.1:3000        |
| TARS_WEB_TOKEN  | The user token of tars web, to deploy servants                         |
| ADMIN_SERVER_IP | The node IP which use to deploy tars benchmark admin servant           |
| NODE_SERVER_IP  | The node IP which use to deploy tars benchmark client servant          |
| REBUILD         | if rebuild all deploy package                                          |

## Run on dev environment

1. start framework docker `cd docker && docker-compose up -d`
2. access http://127.0.0.1:3000 to obtain user token.
3. run install.sh to deploy
