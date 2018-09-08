FROM blueapple/baseimage:base
MAINTAINER blueapple <blueapple1120@qq.com>
RUN apk add --no-cache \
    	bash \
	cmake \
	doxygen \
	g++ \
	gcc \
	git \
	graphviz \
	make \
	musl-dev \
	qt \
	qt5-qtbase-dev \
	sudo \
 && ln -s /usr/bin/qmake-qt5 /usr/bin/qmake \
 && adduser -D -h /home/admin admin \
 && echo 'admin ALL=(ALL) NOPASSWD: ALL' >/etc/sudoers.d/admin

USER admin
ENV HOME /home/admin
WORKDIR /home/admin
CMD ["/bin/bash"]
