# docker-sphinxsearch
Dockerfile and scripts for creating configurable sphinxsearch image

Clean and configurable sphinxsearch image builded from sources with custom libstemmer_c library and based on Debain Jessie.

#### Environment variables:

SPHINX_SEARCHD_PORT - port for listening by sphinx searchd daemon
SPHINX_SEARCHD_MAX_CHILDREN - maximum searchd children
SPHINX_INDEXER_MEMORY_LIMIT - memory limit for sphinx indexer

#### Config files stored in:
- /usr/local/sphinx/etc/indexer.conf - indexer config file
- /usr/local/sphinx/etc/searchd.conf - searchd config
- /usr/local/sphinx/etc/common.conf - common settings
- /usr/local/sphinx/etc/conf.d - path for user Sources and Indexes config files

When image will be running, files in */usr/local/sphinx/etc/*.conf* and */usr/local/sphinx/etc/conf.d/*.conf* will be split to one */usr/local/etc/sphinx.conf* config.

Log files stores in /var/log/sphinx, it may be redirected to *stdout & stderr* by custom config.

#### How I it use:
```
docker run --name="docker-sphinxsearch-sample" -d -p 9312:9312 \
-v /path/to/you/sources/conf:/usr/local/sphinx/etc/conf.d xordiv/docker-sphinxsearch
```


#### With logs:
```
docker run --name="docker-sphinxsearch-sample" -d -p 9312:9312 \
-v /path/to/you/sources/conf:/usr/local/sphinx/etc/conf.d \
-v /var/apps/sample/logs/sphinx:/var/log/sphinx xordiv/docker-sphinxsearch
```
