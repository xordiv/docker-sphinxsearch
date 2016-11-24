#!/bin/bash
set -e

#default command
/usr/local/bin/searchd --nodetach --config /usr/local/etc/sphinx.conf "$@"