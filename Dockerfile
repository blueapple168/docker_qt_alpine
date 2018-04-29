FROM blueapple/alpine_glibc_basicimage
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
 && adduser -D -h /home/user user \
 && echo 'user ALL=(ALL) NOPASSWD: ALL' >/etc/sudoers.d/user

USER user
ENV HOME /home/user
WORKDIR /home/user
CMD ["/bin/bash"]
