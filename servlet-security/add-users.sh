#!/bin/bash
set -e
./target/server/bin/add-user.sh -a -u "quickstartUser" -p "quickstartPwd1!" -g "quickstarts"
./target/server/bin/add-user.sh -a -u "guest" -p "guestPwd1!" -g "notauthorized"