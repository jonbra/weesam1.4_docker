FROM ubuntu:20.04
LABEL Name=weesamdocker Version=0.0.1 maintainer="Jon Bråte jon.brate@fhi.no"
RUN apt-get update && apt-get -y upgrade && \
	apt-get install -y build-essential wget unzip \
		libncurses5-dev zlib1g-dev libbz2-dev liblzma-dev libcurl3-dev && \
	apt-get clean && apt-get purge && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /usr/src

# Install Samtools
RUN wget https://github.com/samtools/samtools/releases/download/1.15/samtools-1.15.tar.bz2 && \
	tar jxf samtools-1.15.tar.bz2 && \
	rm samtools-1.15.tar.bz2 && \
	cd samtools-1.15 && \
	./configure --prefix $(pwd) && \
	make

ENV PATH=${PATH}:/usr/src/samtools-1.15

# Install WeeSAMv1.4
RUN wget https://raw.githubusercontent.com/centre-for-virus-research/weeSAM/master/legacy_versions/weeSAMv1.4 \
    && cp weeSAMv1.4 /usr/bin/

RUN chmod +x /usr/bin/weeSAMv1.4

