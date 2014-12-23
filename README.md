#Apache Hadoop 2.6.0 Docker image

This is modified branch of [https://github.com/sequenceiq/hadoop-docker](https://github.com/sequenceiq/hadoop-docker)

# Build images

```
docker build -t showyou/hadoop-docker-name:2.6.0-s1 ./namenode/
docker build -t showyou/hadoop-docker-data:2.6.0-s1 ./datanode/
```

# Start datanode containers

In order to use the Docker image you have just build use:

**Make sure that SELinux is disabled on the host. If you are using boot2docker you don't need to do anything.**

```
docker run -i -t showyou/hadoop-docker-data:2.6.0-s1 /etc/bootstrap.sh -bash
# /sbin/ifconfig
# echo $HOSTNAME
```
Memo ip and hostname.
if you want to not only one container, please repeat to run and memo each containers.

# Start namenode container and assign
```
docker run -i -t showyou/hadoop-docker-name:2.6.0-s1 /etc/bootstrap.sh -bash
```
Write (each)hostname to slaves, and ip with hostname to /etc/hosts.
i.e. if you have two datanodes(ip, hostname)
```
172.17.0.135    bbf52007d6fc
172.17.0.134    ad1a9958ae7a
```
Add slaves file this:
```
bbf52007d6fc
ad1a9958ae7a
```
Add /etc/hosts file this:
```
172.17.0.135    bbf52007d6fc
172.17.0.134    ad1a9958ae7a
```

# Distribute config filesF
In order to copy setting files, you should do this script in the namenode:
```
/bin/bash /etc/dist_files.sh bbf52007d6fc
/bin/bash /etc/dist_files.sh ad1a9958ae7a
```

# Run hadoop cluster
In the namenode:
```
$HADOOP_PREFIX/sbin/stop-yarn.sh
$HADOOP_PREFIX/sbin/stop-hdfs.sh
$HADOOP_PREFIX/sbin/start-hdfs.sh
$HADOOP_PREFIX/sbin/start-yarn.sh

```

#old

_Note: this is the master branch - for a particular Hadoop version always check the related branch_

A few weeks ago we released an Apache Hadoop 2.3 Docker image - this quickly become the most [popular](https://registry.hub.docker.com/search?q=hadoop&s=downloads) Hadoop image in the Docker [registry](https://registry.hub.docker.com/).


Following the success of our previous Hadoop Docker [images](https://registry.hub.docker.com/u/sequenceiq/hadoop-docker/), the feedback and feature requests we received aligned with the Hadoop release cycle, so we have released an Apache Hadoop 2.6.0 Docker image - same as the previous version, it's available as a trusted and automated build on the official Docker [registry](https://registry.hub.docker.com/).


_FYI: All the former Hadoop releases (2.3, 2.4.0, 2.4.1, 2.5.0, 2.5.1, 2.5.2, 2.6.0) are available in the GitHub branches or our [Docker Registry](https://registry.hub.docker.com/u/sequenceiq/hadoop-docker/) - check the tags._

# Build the image

If you'd like to try directly from the Dockerfile you can build the image as:

```
docker build  -t sequenceiq/hadoop-docker:2.6.0 .
```
# Pull the image

The image is also released as an official Docker image from Docker's automated build repository - you can always pull or refer the image when launching containers.

```
docker pull sequenceiq/hadoop-docker:2.6.0
```

# Start a container

In order to use the Docker image you have just build or pulled use:

**Make sure that SELinux is disabled on the host. If you are using boot2docker you don't need to do anything.**

```
docker run -i -t sequenceiq/hadoop-docker:2.6.0 /etc/bootstrap.sh -bash
```

## Testing

You can run one of the stock examples:

```
cd $HADOOP_PREFIX
# run the mapreduce
bin/hadoop jar share/hadoop/mapreduce/hadoop-mapreduce-examples-2.6.0.jar grep input output 'dfs[a-z.]+'

# check the output
bin/hdfs dfs -cat output/*
```

## Hadoop native libraries, build, Bintray, etc

The Hadoop build process is no easy task - requires lots of libraries and their right version, protobuf, etc and takes some time - we have simplified all these, made the build and released a 64b version of Hadoop nativelibs on this [Bintray repo](https://bintray.com/sequenceiq/sequenceiq-bin/hadoop-native-64bit/2.6.0/view/files). Enjoy.

## Automate everything

As we have mentioned previousely, a Docker file was created and released in the official [Docker repository](https://registry.hub.docker.com/u/sequenceiq/hadoop-docker/)
