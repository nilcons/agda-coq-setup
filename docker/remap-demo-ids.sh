#!/bin/bash

set -eu

sed -i -e "/^demo/s/:1000:1000:/:$DEMO_UID:$DEMO_GID:/" /etc/passwd
sed -i -e "/^demo/s/:1000:/:$DEMO_GID:/" /etc/group

chown -R $DEMO_UID:$DEMO_GID /home/demo
