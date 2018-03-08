#!/bin/bash

SOURCE="$0"
while [ -h "$SOURCE"  ]; do
	DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd  )"
	SOURCE="$(readlink "$SOURCE")"
	[[ $SOURCE != /*  ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd  )"

BINARY_PATH=${DIR}/bin
SOURCE_PATH=${DIR}/src
USR_CONFIG_PATH=${DIR}/'.YXVim.d'

# remove bin
if [[ -d ${BINARY_PATH} ]]; then
    rm -r -f ${BINARY_PATH}
fi

# create binary dir
mkdir ${BINARY_PATH}

# create user config path if not exist
if [[ ! -d ${USR_CONFIG_PATH} ]]; then
    mkdir ${USR_CONFIG_PATH}
fi


# compile tellenc
clang++ -o2 ${SOURCE_PATH}/tellenc/tellenc.cpp -o ${BINARY_PATH}/tellenc


