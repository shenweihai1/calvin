set -e
sudo apt install --assume-yes autoconf libtool-bin libreadline-dev libzmq3-dev

sudo apt-get install --assume-yes software-properties-common
sudo add-apt-repository ppa:ubuntu-toolchain-r/test
sudo apt update
sudo apt-get install --assume-yes gcc-6 g++-6 cmake

git clone https://github.com/shenweihai1/calvin.git
cd calvin

rm -rf ext
mkdir -p ext
cd ext

#zookeeper
FN=zookeeper-3.4.12.tar.gz
FV=zookeeper-3.4.12
wget https://archive.apache.org/dist/zookeeper/zookeeper-3.4.12/$FN
tar xzf $FN
rm $FN
mv $FV/src/c zookeeper
rm -fr $FV
cd zookeeper
./configure --prefix=$PWD
make -j
cd ..

# protobuf
git clone https://github.com/protocolbuffers/protobuf.git
cd protobuf
git checkout v3.6.1
./autogen.sh
./configure --prefix=$PWD
make -j
cd ..

# googletest
git clone https://github.com/google/googletest.git
cd googletest
git checkout release-1.6.0
cmake .
make -j
cd ..

cd ~/calvin
cp -r src_calvin src
cd src
make
cd ..

LD_LIBRARY_PATH=/home/azureuser/calvin/ext/protobuf/src/.libs/:/home/azureuser/calvin/ext/zookeeper/.libs/:/home/azureuser/calvin/ext/zeromq/build/lib
