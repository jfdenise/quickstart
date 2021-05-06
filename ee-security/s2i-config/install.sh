#!/usr/bin/env bash
injected_dir=$1
echo "Start server security configuration"

$JBOSS_HOME/bin/jboss-cli.sh --file="${injected_dir}/configure-security.cli"
$JBOSS_HOME/bin/add-user.sh -a -u myuser -p mypassword
echo "End Server configuration"