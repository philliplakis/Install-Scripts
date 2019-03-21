# ==================================================================
# module list
# ------------------------------------------------------------------
# python        3.6    (apt)
# chainer       latest (pip)
# cntk          latest (pip)
# jupyter       latest (pip)
# mxnet         latest (pip)
# onnx          latest (pip)
# pytorch       1.0.1  (pip)
# tensorflow    latest (pip)
# theano        1.0.1  (git)
# keras         latest (pip)
# lasagne       latest (git)
# opencv        3.4.1  (git)
# sonnet        latest (pip)
# caffe         latest (git)
# caffe2        latest (git)
# ==================================================================

export APT_INSTALL="apt-get install -y --no-install-recommends "
export PIP_INSTALL="python -m pip --no-cache-dir install --upgrade "
export GIT_CLONE="git clone --depth 10 " 

echo "********************************************************************************"
echo "Update."
echo "********************************************************************************"
sleep 2

apt-get update 

echo "********************************************************************************"
echo "Tools."
echo "********************************************************************************"
sleep 2

    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        build-essential \
        ca-certificates \
        cmake \
        wget \
        git \
        vim \
        && \

echo "********************************************************************************"
echo "Python."
echo "********************************************************************************"
sleep 2

    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        software-properties-common \
        && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        python3.6 \
        python3.6-dev \
        && \
    wget -O ~/get-pip.py \
        https://bootstrap.pypa.io/get-pip.py && \
    python3.6 ~/get-pip.py && \
    ln -s /usr/bin/python3.6 /usr/local/bin/python3 && \
    ln -s /usr/bin/python3.6 /usr/local/bin/python && \
    $PIP_INSTALL \
        setuptools \
        && \
    $PIP_INSTALL \
        numpy \
        scipy \
        pandas \
        scikit-learn \
        matplotlib \
        Cython \
        && \

echo "********************************************************************************"
echo "Boost."
echo "********************************************************************************"
sleep 2

    wget -O ~/boost.tar.gz https://dl.bintray.com/boostorg/release/1.65.1/source/boost_1_65_1.tar.gz && \
    tar -zxf ~/boost.tar.gz -C ~ && \
    cd ~/boost_* && \
    ./bootstrap.sh --with-python=python3.6 && \
    ./b2 install --prefix=/usr/local && \

echo "********************************************************************************"
echo "Chainer."
echo "********************************************************************************"
sleep 2

    $PIP_INSTALL \
        cupy \
        chainer \
        && \

echo "********************************************************************************"
echo "cntk."
echo "********************************************************************************"
sleep 2

    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        openmpi-bin \
        libpng-dev \
        libtiff-dev \
        libjasper-dev \
        && \

    $PIP_INSTALL \
        cntk-gpu \
        && \

echo "********************************************************************************"
echo "Jupyter."
echo "********************************************************************************"
sleep 2

    $PIP_INSTALL \
        jupyter \
        && \

echo "********************************************************************************"
echo "MXNET."
echo "********************************************************************************"

    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        libatlas-base-dev \
        graphviz \
        && \

    $PIP_INSTALL \
        mxnet-cu90 \
        graphviz \
        && \

echo "********************************************************************************"
echo "onnx."
echo "********************************************************************************"

    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        protobuf-compiler \
        libprotoc-dev \
        && \

    $PIP_INSTALL \
        onnx \
        && \

echo "********************************************************************************"
echo "Pytorch."
echo "********************************************************************************"
sleep 2

    $PIP_INSTALL \
        https://download.pytorch.org/whl/cu100/torch-1.0.1.post2-cp36-cp36m-linux_x86_64.whl \
        torchvision \
        && \

echo "********************************************************************************"
echo "Tensorflow."
echo "********************************************************************************"
sleep 2

    $PIP_INSTALL \
        tensorflow-gpu \
        && \

echo "********************************************************************************"
echo "Theano."
echo "********************************************************************************"
sleep 2

    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        libblas-dev \
        && \

    wget -qO- https://github.com/Theano/Theano/archive/rel-1.0.1.tar.gz | tar xz -C ~ && \
    cd ~/Theano* && \
    $PIP_INSTALL \
        . && \

    $GIT_CLONE https://github.com/Theano/libgpuarray ~/gpuarray && \
    mkdir -p ~/gpuarray/build && cd ~/gpuarray/build && \
    cmake -D CMAKE_BUILD_TYPE=RELEASE \
          -D CMAKE_INSTALL_PREFIX=/usr/local \
          .. && \
    make -j"$(nproc)" install && \
    cd ~/gpuarray && \
    python setup.py build && \
    python setup.py install && \

    printf '[global]\nfloatX = float32\ndevice = cuda0\n\n[dnn]\ninclude_path = /usr/local/cuda/targets/x86_64-linux/include\n' > ~/.theanorc && \

echo "********************************************************************************"
echo "Keras."
echo "********************************************************************************"
sleep 2

    $PIP_INSTALL \
        h5py \
        keras \
        && \

echo "********************************************************************************"
echo "Lasagne."
echo "********************************************************************************"
sleep 2

    $GIT_CLONE https://github.com/Lasagne/Lasagne ~/lasagne && \
    cd ~/lasagne && \
    $PIP_INSTALL \
        . && \

echo "********************************************************************************"
echo "OpenCV."
echo "********************************************************************************"
sleep 2

    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        libatlas-base-dev \
        libgflags-dev \
        libgoogle-glog-dev \
        libhdf5-serial-dev \
        libleveldb-dev \
        liblmdb-dev \
        libprotobuf-dev \
        libsnappy-dev \
        protobuf-compiler \
        && \

    $GIT_CLONE --branch 3.4.1 https://github.com/opencv/opencv ~/opencv && \
    mkdir -p ~/opencv/build && cd ~/opencv/build && \
    cmake -D CMAKE_BUILD_TYPE=RELEASE \
          -D CMAKE_INSTALL_PREFIX=/usr/local \
          -D WITH_IPP=OFF \
          -D WITH_CUDA=OFF \
          -D WITH_OPENCL=OFF \
          -D BUILD_TESTS=OFF \
          -D BUILD_PERF_TESTS=OFF \
          .. && \
    make -j"$(nproc)" install && \

echo "********************************************************************************"
echo "Sonnet."
echo "********************************************************************************"
sleep 2

    $PIP_INSTALL \
        dm-sonnet \
        && \

echo "********************************************************************************"
echo "Caffe."
echo "********************************************************************************"
sleep 2

    $GIT_CLONE https://github.com/NVIDIA/nccl ~/nccl && \
    cd ~/nccl && \
    make -j"$(nproc)" install && \

    $GIT_CLONE https://github.com/BVLC/caffe ~/caffe && \
    cp ~/caffe/Makefile.config.example ~/caffe/Makefile.config && \
    sed -i 's/# USE_CUDNN/USE_CUDNN/g' ~/caffe/Makefile.config && \
    sed -i 's/# PYTHON_LIBRARIES/PYTHON_LIBRARIES/g' ~/caffe/Makefile.config && \
    sed -i 's/# WITH_PYTHON_LAYER/WITH_PYTHON_LAYER/g' ~/caffe/Makefile.config && \
    sed -i 's/# OPENCV_VERSION/OPENCV_VERSION/g' ~/caffe/Makefile.config && \
    sed -i 's/# USE_NCCL/USE_NCCL/g' ~/caffe/Makefile.config && \
    sed -i 's/-gencode arch=compute_20,code=sm_20//g' ~/caffe/Makefile.config && \
    sed -i 's/-gencode arch=compute_20,code=sm_21//g' ~/caffe/Makefile.config && \
    sed -i 's/2\.7/3\.6/g' ~/caffe/Makefile.config && \
    sed -i 's/3\.5/3\.6/g' ~/caffe/Makefile.config && \
    sed -i 's/\/usr\/lib\/python/\/usr\/local\/lib\/python/g' ~/caffe/Makefile.config && \
    sed -i 's/\/usr\/local\/include/\/usr\/local\/include \/usr\/include\/hdf5\/serial/g' ~/caffe/Makefile.config && \
    sed -i 's/hdf5/hdf5_serial/g' ~/caffe/Makefile && \
    cd ~/caffe && \
    make -j"$(nproc)" -Wno-deprecated-gpu-targets distribute && \

    # fix ValueError caused by python-dateutil 1.x
    sed -i 's/,<2//g' ~/caffe/python/requirements.txt && \

    $PIP_INSTALL \
        -r ~/caffe/python/requirements.txt && \

    cd ~/caffe/distribute/bin && \
    for file in *.bin; do mv "$file" "${file%%.bin}"; done && \
    cd ~/caffe/distribute && \
    cp -r bin include lib proto /usr/local/ && \
    cp -r python/caffe /usr/local/lib/python3.6/dist-packages/ && \

echo "********************************************************************************"
echo "Caffe2."
echo "********************************************************************************"
sleep 2

    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        libprotobuf-dev \
        protobuf-compiler \
        && \

    $PIP_INSTALL \
        future \
        numpy \
        protobuf \
        enum34 \
        pyyaml \
        typing \
        && \

    $GIT_CLONE https://github.com/pytorch/pytorch.git \
        ~/caffe2 --recursive && \
    cd ~/caffe2 && \
    git submodule update --init && \

    sed -i "s/prefix=''/prefix='', standard_lib=True) \
        + '\/dist-packages'/g" CMakeLists.txt && \

    mkdir build && cd build && \
    cmake -D CMAKE_BUILD_TYPE=RELEASE \
          -D CMAKE_INSTALL_PREFIX=/usr/local \
          -D USE_CUDA=ON \
          -D USE_MPI=OFF \
          .. && \
    make -j"$(nproc)" install && \
    mv /usr/local/lib/python3/dist-packages/caffe2 \
        /usr/local/lib/python3.6/dist-packages && \

echo "********************************************************************************"
echo "Config & Clean."
echo "********************************************************************************"
sleep 2

    ldconfig && \
    apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* ~/*
    
    jupyter notebook --generate-config --allow-root
    echo "c.NotebookApp.ip = '0.0.0.0'" >> ~/.jupyter/jupyter_notebook_config.py
    echo "c.NotebookApp.open_browser = False" >> ~/.jupyter/jupyter_notebook_config.py
    # The below line is for Rendsolve's Jupyter Portal. Can be removed if running local
    echo "c.NotebookApp.base_url = '/jupyter/'" >> ~/.jupyter/jupyter_notebook_config.py
