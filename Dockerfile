FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive

RUN  apt-get update && apt-get install -y ca-certificates

RUN sed -i 's/htt[p|ps]:\/\/archive.ubuntu.com\/ubuntu\//mirror:\/\/mirrors.ubuntu.com\/mirrors.txt/g' /etc/apt/sources.list

WORKDIR /root/workspace

RUN  apt-get update && apt-get install -y git wget cmake build-essential libopencv-dev software-properties-common

RUN add-apt-repository ppa:deadsnakes/ppa &&\
    add-apt-repository ppa:ubuntu-toolchain-r/test &&\
    apt-get update && apt update

RUN apt-get install -y g++-11 gcc++-11

RUN apt-get install -y python3.7 python3.7-distutils 3.10-distutils python3.10-dev

RUN ln -f /usr/bin/python3.7 /usr/bin/python3

RUN wget https://bootstrap.pypa.io/get-pip.py &&\
    python3 get-pip.py &&\
    rm get-pip.py

# RUN git clone https://github.com/open-mmlab/mmdeploy.git &&\
#     python3 ./mmdeploy/tools/scripts/build_ubuntu_x64_ort.py

COPY . .

ENV ONNXRUNTIME_DIR=/root/workspace/onnxruntime-linux-x64-1.8.1

ENV LD_LIBRARY_PATH=${ONNXRUNTIME_DIR}/lib:

RUN chmod +x *.sh

RUN ./build_mmdeploy.sh


# RUN chmod +x worker/build.sh &&\
#     ./worker/build.sh

# ENTRYPOINT [ "./worker/build/main" ]


