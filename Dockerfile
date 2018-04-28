FROM centos:7
MAINTAINER blueapple <blueapple1120@qq.com>
LABEL description="nginx-v1.14,pagespeed-v1.13.35.2,openjdk1.8.0"

# Set zh_CN timezone
RUN yum -y update; yum clean all \
	&& yum install -y java-1.8.0-openjdk.x86_64 java-1.8.0-openjdk-devel.x86_64 gcc-c++ pcre-devel zlib-devel make unzip libuuid-devel cmake \
	&& yum clean all \
	&& cp -r -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
	&& yum install -y http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm \
	&& yum install -y https://extras.getpagespeed.com/redhat/7/noarch/RPMS/getpagespeed-extras-7-0.el7.gps.noarch.rpm \
	&& yum install -y nginx \
	&& yum install -y nginx-module-nps \
	&& rm -rf /tmp/* \
	# Forward request and error logs to docker log collector
	&& ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log

COPY ./conf.d /etc/nginx/conf.d
COPY ./nginx.conf /etc/nginx/nginx.conf

# Set java environment
ENV JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk.x86_64
ENV PATH $PATH:/usr/lib/jvm/java-1.8.0-openjdk.x86_64/jre/bin:/usr/lib/jvm/java-1.8.0-openjdk.x86_64/bin

VOLUME ["/var/cache/ngx_pagespeed"]
EXPOSE 80 443
CMD ["nginx", "-g", "daemon off;"]
