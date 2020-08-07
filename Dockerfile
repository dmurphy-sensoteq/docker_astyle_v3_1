# Dockefile to create a Docker image using AStyle 3.1

# Base Image
FROM alpine

# Metadata
LABEL MAINTAINER Dermot Murphy <dermot.murphy@canembed.com> Name=AStyle Version=3.1

# Arguments
ARG VERSION=3.1
ARG FILENAME=astyle_${VERSION}_linux.tar.gz
ARG GETFROM=https://downloads.sourceforge.net/project/astyle/astyle
ARG MAINFILE=/tmp/astyle/src/astyle_main.cpp

# Dependencies
RUN apk update && \
    apk add --no-cache libstdc++ && \
    apk add --no-cache --virtual build-dependencies ca-certificates g++ make openssl pcre-dev wget cmake && \
# Get the AStyle source file && \
    wget -O  /tmp/${FILENAME} ${GETFROM}/astyle%20${VERSION}/${FILENAME} && \
# Unpack the file into /tmp && \
    tar -zxf /tmp/${FILENAME} -C /tmp && \
# Correct the source file && \
    sed -i "s@#include <sys/stat.h>@#include <sys/stat.h>\n        #include <limits.h>@" ${MAINFILE} && \
# Build the project && \
    cd /tmp/astyle && \
    cmake . && \
    cd /tmp/astyle/build/gcc && \
    make && \
# Copy the executable && \
   mkdir /astyle && \
   cp /tmp/astyle/build/gcc/bin/astyle /astyle/astyle && \
# Create the shared folder && \
   mkdir /data && \
# Clean up && \
   rm /tmp/${FILENAME} && \
   rm -rf /tmp/* && \
   apk del build-dependencies ca-certificates g++ make openssl pcre-dev wget cmake  && \
   rm -rf /var/lib/apt/lists/*

# Entry point
ENTRYPOINT ["/astyle/astyle"]
