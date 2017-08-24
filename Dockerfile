FROM ubuntu:16.04

MAINTAINER caspell84

#sudo apt-get install python3-software-properties
#sudo apt-get install python-software-properties

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y git wget unzip subversion && \
    apt-get install -y python3 python3.5-dev python3-pip && \
    apt-get install -y ipython3 && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:fkrull/deadsnakes && \    
    apt-get install -y  build-essential cmake pkg-config && \
    apt-get install -y  libjpeg8-dev libtiff5-dev libjasper-dev libpng12-dev && \
    apt-get install -y  libavcodec-dev libavformat-dev libswscale-dev libv4l-dev && \
    apt-get install -y  libxvidcore-dev libx264-dev && \
    apt-get install -y  libgtk-3-dev libcupti-dev  && \
    apt-get install -y  libatlas-base-dev gfortran 

# RUN apt-get update
# RUN apt-get upgrade -y
# RUN apt-get install -y git wget unzip subversion
# RUN apt-get install -y python3 python3.5-dev python3-pip
# RUN apt-get install -y ipython3
# RUN apt-get install -y software-properties-common
# RUN add-apt-repository ppa:fkrull/deadsnakes    
# RUN apt-get install -y  build-essential cmake pkg-config
# RUN apt-get install -y  libjpeg8-dev libtiff5-dev libjasper-dev libpng12-dev
# RUN apt-get install -y  libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
# RUN apt-get install -y  libxvidcore-dev libx264-dev
# RUN apt-get install -y  libgtk-3-dev libcupti-dev 
# RUN apt-get install -y  libatlas-base-dev gfortran 

RUN pip3 install --upgrade pip && \
    pip3 install numpy && \
    pip3 install --upgrade tensorflow

RUN cd ~ && wget -O opencv.zip https://github.com/Itseez/opencv/archive/3.3.0.zip && \ 
    unzip opencv.zip -d ~/opencv && \
    mv ~/opencv/opencv-3.3.0/* ~/opencv/ && rm -rf ~/opencv/opencv-3.3.0 && \
    cd ~ && wget -O opencv_contrib.zip https://github.com/Itseez/opencv_contrib/archive/3.3.0.zip && \ 
    unzip opencv_contrib.zip -d ~/opencv_contrib && \
    mv ~/opencv_contrib/opencv_contrib-3.3.0/* ~/opencv_contrib/ && rm -rf ~/opencv_contrib/opencv_contrib-3.3.0 

RUN cd ~/opencv && mkdir ~/opencv/build && \ 
    cd ~/opencv/build && cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D INSTALL_C_EXAMPLES=ON -D INSTALL_PYTHON_EXAMPLES=ON -D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib/modules -D BUILD_EXAMPLES=ON .. && \
    make -j8 && make install && ldconfig

EXPOSE 22 80
