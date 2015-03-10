#!/bin/bash

# Change location to the NDK folder
if [ "$NDK" = "" ]; then
    export NDK=~/Development/SDKs/android-ndk-r10d    
fi

GIT_SSL_NO_VERIFY=true

function addAutomakeOpts() {
    if !(grep -Rq "AUTOMAKE_OPTIONS" Makefile.am)
    then
        sed -i '1iAUTOMAKE_OPTIONS=subdir-objects' Makefile.am
    fi
}

#git submodule update --init --recursive

# Because it is svn...
#svn checkout http://libyuv.googlecode.com/svn/trunk/ libyuv

# configure the environment
cd freetype2
echo "** Autogen freetype2 **"
sh ./autogen.sh
cd ..

# fribidi
cd fribidi
echo "** Automake fribidi **"
autoreconf -ivf
cd ..

# libass
cd libass
echo "** Automake libass **"
autoreconf -ivf
cd ..

# aacenc environment
cd vo-aacenc
echo "** Automake aacenc **"
addAutomakeOpts
autoreconf -ivf
cd ..

# vo-amrwbenc environment
cd vo-amrwbenc
echo "** Automake amrwbenc **"
addAutomakeOpts
autoreconf -ivf
cd ..

# Start the build!
echo "** Start buidl_android.sh **"
source $(pwd)/build_android.sh