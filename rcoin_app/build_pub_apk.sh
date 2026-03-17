#!/bin/sh

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

flutter build apk --target-platform=android-arm64

#scp app.apk -i ~/.ssh/bugu.pem root@bugu:/www/wwwroot/admin/dist
#
#echo "${GREEN}upload completed${NC}"
