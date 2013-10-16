#!/bin/bash


function usage() {
   echo "Usage: release.sh <version number>"
   echo "  e.g:  release.sh V1.b1"
   exit 1
}

VERSION=$1

if [ "$VERSION" == "" ]
then 
   usage
fi

DIR="GraphiteLogFeeder_$VERSION"
DIR_TAR="$DIR.tar"
DIR_TGZ="$DIR_TAR.gz"

if [ -d "$DIR" ]
then
   echo "Deleting previous $DIR directory"
   rm -rf $DIR
   echo "ok"
fi

if [ -d "$DIR_TAR" ]
then
   echo "Deleting previous $DIR_TAR directory"
   rm -rf $DIR_TAR
fi

if [ -f "$DIR_TGZ" ]
then
   echo "Deleting previous $DIR_TGZ file"
   rm -rf $DIR_TGZ
fi

mkdir $DIR
cp doc/* $DIR
cp -R src/* $DIR
find $DIR | grep pyc$ | xargs rm > /dev/null 2>&1
find $DIR | grep class$ | xargs rm > /dev/null 2>&1

tar -cpf $DIR_TAR $DIR
gzip $DIR_TAR

rm -rf $DIR

