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
RUN apk update
RUN apk add --no-cache libstdc++
RUN apk add --no-cache --virtual build-dependencies ca-certificates g++ make openssl pcre-dev wget cmake

# Get the AStyle source file
RUN wget -O  /tmp/${FILENAME} ${GETFROM}/astyle%20${VERSION}/${FILENAME}

# Unpack the file into /tmp
RUN tar -zxf /tmp/${FILENAME} -C /tmp

# Correct the source file
RUN sed -n '45,70p' ${MAINFILE}
RUN sed -i "s@#include <sys/stat.h>@#include <sys/stat.h>\n        #include <limits.h>@" ${MAINFILE}
RUN sed -n '45,70p' ${MAINFILE}

# Build the project
RUN cd /tmp/astyle && cmake .
RUN ls -l -R /tmp
RUN cd /tmp/astyle/build/gcc && make
RUN ls -l -R /tmp/astyle/build

# Check the executable is working
RUN /tmp/astyle/build/gcc/bin/astyle --version

# Copy the executable
RUN mkdir /astyle
RUN cp /tmp/astyle/build/gcc/bin/astyle /astyle/astyle

# Check the executable is working
RUN /astyle/astyle --version

# Clean up
RUN rm /tmp/${FILENAME}
RUN rm -rf /tmp/astyle
#RUN apk del build-dependencies

# Configs

#/bin/sh -c #(nop)  ENTRYPOINT ["astyle"]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   0B                  
#/bin/sh -c #(nop)  CMD []                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  0B                  
#/bin/sh -c #(nop) WORKDIR /data                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            0B                  
#/bin/sh -c #(nop)  VOLUME [/data]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          0B                  
#/bin/sh -c #(nop)  USER [user]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             0B                  
#T|2 UID=1000 VERSION=3.0.1 /bin/sh -c mkdir /home/$USER   && addgroup -g $UID -S $USER   && adduser -u $UID -D -S -G $USER $USER   && chown -R $USER:$USER /home/$USER                                                                                                                                                                                                                                                                                                                                                                                                      4.83kB              
#T/bin/sh -c #(nop)  ENV USER=user                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           0B                  
#T/bin/sh -c #(nop)  ARG UID=1000                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            0B                  
#T/bin/sh -c #(nop)  ARG USER=user                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           0B                  
#+T|1 VERSION=3.0.1 /bin/sh -c apk add --no-cache libstdc++                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   1.46MB              
#+T|1 VERSION=3.0.1 /bin/sh -c apk add --no-cache --virtual build-dependencies     ca-certificates     g++     make     openssl     pcre-dev     wget     && wget -O /tmp/astyle_${VERSION}_linux.tar.gz https://downloads.sourceforge.net/project/astyle/astyle/astyle%20${VERSION}/astyle_${VERSION}_linux.tar.gz     && tar -zxf /tmp/astyle_${VERSION}_linux.tar.gz -C /tmp     && cd /tmp/astyle/build/gcc     && make release     && USER=root make install     && rm /tmp/astyle_${VERSION}_linux.tar.gz     && rm -rf /tmp/astyle     && apk del build-dependencies   1.31MB              
#T/bin/sh -c #(nop)  ARG VERSION=3.0.1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       0B                  
#T/bin/sh -c #(nop)  LABEL Maintainer=Frank Wolf <FrankWolf@gmx.de> Name=astyle Version=3.0.1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                0B                  
#T/bin/sh -c #(nop)  CMD ["/bin/sh"]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         0B                  
#+T/bin/sh -c #(nop) ADD file:093f0723fa46f6cdbd6f7bd146448bb70ecce54254c35701feeceb956414622f in /                                                                                                                                                                                                                                                                                                                                                                                                                                                                           4.15MB              
