#!/bin/sh

#  build.sh
#  GMGridView
#
#  Created by Jim Holt on 8/4/12.
#  Copyright (c) 2012 Jim Holt. All rights reserved.

set -ex

#INSTALL_PATH=$WORKSPACE/artifacts
INSTALL_PATH=../artifacts
[ -z $INSTALL_PATH ] || INSTALL_PATH=$PWD/artifacts

rm -rf $INSTALL_PATH
mkdir -p $INSTALL_PATH

PROJ=GMGridView.xcodeproj

xcodebuild -project $PROJ -sdk iphoneos INSTALL_ROOT=$INSTALL_PATH/device install
xcodebuild -project $PROJ -sdk iphonesimulator INSTALL_ROOT=$INSTALL_PATH/simulator install

lipo -create -output $INSTALL_PATH/libGMGridView.a $INSTALL_PATH/device/libGMGridView.a $INSTALL_PATH/simulator/libGMGridView.a
mv $INSTALL_PATH/device/Headers $INSTALL_PATH
rm -rf $INSTALL_PATH/device $INSTALL_PATH/simulator
(cd $INSTALL_PATH; zip -r ../GMGridView.zip libGMGridView.a Headers)