# docker-sphinxsearch
Dockerfile and scripts for creating configurable sphinxsearch (http://sphinxsearch.com/) image

SPHINX_VERSION=2.3.2-beta   
RE2_VERSION=2016-11-01  
libstemmer_c FROM http://snowball.tartarus.org  
Supported DB: MySQL, PostgreSQL  

Clean and configurable sphinxsearch image builded from sources with custom libstemmer_c library and based on Debain Jessie.  

#### Environment variables:

SPHINX_SEARCHD_PORT - port for listening by sphinx searchd daemon (Default: 9312)  
SPHINX_SEARCHD_MAX_CHILDREN - maximum searchd children (Default: 30)  
SPHINX_INDEXER_MEMORY_LIMIT - memory limit for sphinx indexer (Default: 128Mb)  

#### Config files stored in:
- /usr/local/sphinx/etc/indexer.conf - indexer config file
- /usr/local/sphinx/etc/searchd.conf - searchd config
- /usr/local/sphinx/etc/common.conf - common settings
- /usr/local/sphinx/etc/conf.d - path for app Sources and Indexes config files

In my apps Source and Index config files deploy by Ansible from templates with correct environment variables.  

When image will be running, files in */usr/local/sphinx/etc/*.conf* and */usr/local/sphinx/etc/conf.d/*.conf* will be split to one */usr/local/etc/sphinx.conf* config.  

Log files stores in */var/log/sphinx*, it may be redirected to *stdout & stderr* by custom config.  

#### Persistent data:

Sphinx Index Files (such as \*.idx) and other persistent data for conteiners may be stored in path */usr/local/sphinx/data*  
Just mount your host directory on Docker Volume to */usr/local/sphinx/data*  
In a config file for Index you should set up *path* variable to */usr/local/sphinx/data/YourIndexName*  
Index config file for example placed in Gihub repo for this image.  

#### How I it use:
```
docker run --name="docker-sphinxsearch-sample" -d \
-v /path/to/app/conf/sphinx:/usr/local/sphinx/etc/conf.d \
-v /path/to/app/data/sphinx:usr/local/sphinx/data \
xordiv/docker-sphinxsearch
```

#### With logs and public port:
```
docker run --name="docker-sphinxsearch-sample" -d -p 9312:9312 \
-v /path/to/you/sources/conf:/usr/local/sphinx/etc/conf.d \
-v /path/to/app/data/sphinx:usr/local/sphinx/data \
-v /var/apps/sample/logs/sphinx:/var/log/sphinx xordiv/docker-sphinxsearch
```

#### Run indexer:
```
docker exec -it docker-sphinxsearch-sample indexer --all
```

#### Restart Searchd:
```
docker restart docker-sphinxsearch-sample
```
