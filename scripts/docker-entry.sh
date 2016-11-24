#!/bin/bash
set -e

# chown sphinx:sphinx /var/log/sphinx -R

# configure image for running

[ ! -z "$SPHINX_SEARCHD_PORT" ] && sed -i "/^[ \t#]*listen = 9312/clisten = $SPHINX_SEARCHD_PORT" /usr/local/sphinx/etc/searchd.conf

[ ! -z "$SPHINX_SEARCHD_MAX_CHILDREN" ] && sed -i "/^[ \t#]*max_children = 30/cmax_children = $SPHINX_SEARCHD_MAX_CHILDREN" /usr/local/sphinx/etc/searchd.conf

[ ! -z "$SPHINX_INDEXER_MEMORY_LIMIT" ] && sed -i "/^[ \t#]*mem_limit = 128M/mem_limit = $SPHINX_INDEXER_MEMORY_LIMIT" /usr/local/sphinx/etc/indexer.conf

# split config files
awk 'FNR==1{print ""}1' /usr/local/sphinx/etc/*.conf > /usr/local/etc/sphinx.conf

[ -d /usr/local/sphinx/etc/conf.d ] && awk 'FNR==1{print ""}1' /usr/local/sphinx/etc/conf.d/*.conf >> /usr/local/etc/sphinx.conf

exec "$@"