#!/bin/bash

openslide_prefix="/home"
export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"

# Install openslide
git clone "https://github.com/openslide/openslide.git" "$openslide_prefix/openslide"
cd "$openslide_prefix/openslide"
libtoolize --force && aclocal && autoheader > /dev/null
automake --force-missing --add-missing > /dev/null 
autoconf && ./configure && make && make install > /dev/null

# Install openslide-java
git clone "https://github.com/openslide/openslide-java.git" "$openslide_prefix/openslide-java"
cd "$openslide_prefix/openslide-java"
libtoolize --force && aclocal && autoheader > /dev/null
automake --force-missing --add-missing > /dev/null 
autoconf && ./configure && make && make install > /dev/null

# Install openslide-python
pip install openslide-python

# Fix the link issue
ln -s /usr/local/lib/openslide-java/libopenslide-jni.so /usr/local/lib/openslide-java/libopenslide-jni.jnilib 

# 5 Create a reference to use in nidan-wsi-core
echo "export OPENSLIDE_JAVA='/usr/local/lib/openslide-java'" >> ~/.bashrc
echo ">> $0 script done"
exit 0
