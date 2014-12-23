#!/bin/bash

if [ $# -ne 1 ]; then
  echo "usage: dist_file.sh host" 1>&2
  exit 1
fi

scp /usr/local/hadoop/etc/hadoop/yarn-site.xml $1:/usr/local/hadoop/etc/hadoop/
scp /usr/local/hadoop/etc/hadoop/mapred-site.xml $1:/usr/local/hadoop/etc/hadoop/
scp /usr/local/hadoop/etc/hadoop/core-site.xml $1:/usr/local/hadoop/etc/hadoop/
scp /usr/local/hadoop/etc/hadoop/hdfs-site.xml $1:/usr/local/hadoop/etc/hadoop/
scp /usr/local/hadoop/etc/hadoop/slaves $1:/usr/local/hadoop/etc/hadoop/
scp /etc/hosts $1:/etc/

exit 0
