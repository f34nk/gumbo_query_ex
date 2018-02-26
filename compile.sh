#!/bin/bash

mix_env=$1
current=`pwd`
gumbo_query_client=gumbo_query_client
# gumbo_query_client=GQ_client

# check=`find /usr/local/lib -name libgumbso*`
check=`find target \( -name libgumbo.a -o -name libgumbo.so \)`
if [ -z "$check" ]
then
	if [ -z `which libtool` ]
	then
		echo "Please install libtool:
		sudo apt-get install libtool"
		exit 1
	fi
	echo "Compiling gumbo-parser..."
	# gumbo-parser
	# https://github.com/google/gumbo-parser#installation
	cd target/gumbo-parser
	./autogen.sh
	./configure
	make
	# sudo make install
	cd $current
	echo "done"
fi

check=`find target \( -name libgq.a -o -name libgq.so \)`
if [ -z "$check" ]
then
	if [ -z `which cmake` ]
	then
		echo "Please install cmake:
		sudo apt-get install cmake"
		exit 1
	fi
	echo "Compiling gumbo-query..."
	# gumbo-query
	# https://github.com/lazytiger/gumbo-query#installation
	mkdir -p target/gumbo-query/build
	cd target/gumbo-query/build
	cmake -IGumbo_INCLUDE_DIR="$current/target/gumbo-parser/src" -DGumbo_LIBRARY="$current/target/gumbo-parser/.libs/libgumbo.so" -DGumbo_static_LIBRARY="$current/target/gumbo-parser/.libs/libgumbo.a" ..
	make
	cd $current
	echo "done"
fi

# check=`find target \( -name libGQ.a -o -name libGQ.so \)`
check=`find target -name libGQ.a`
if [ -z "$check" ]
then
	if [ -z `which cmake` ]
	then
		echo "Please install cmake:
		sudo apt-get install cmake"
		exit 1
	fi

	echo "Compiling GQ..."
	# GQ
	# https://github.com/lazytiger/gumbo-query#installation
	#
	# uses -std=c++14
	# update to g++ v5
	# 	sudo apt-get install g++-5
	# set symlink /usr/bin/g++ -> /usr/bin/g++-5
	# 	sudo ln -sf /usr/bin/g++-5 /usr/bin/g++
	#
	mkdir -p target/GQ/build
	cd target/GQ/build
	rm -rf *
	cmake -IGUMBO_INCLUDE_DIRS="$current/target/gumbo-parser/src" -IGUMBO_LIBRARY_DIRS="$current/target/gumbo-parser/.libs" ..
	# cmake -IGUMBO_INCLUDE_DIRS="$current/target/gumbo-parser/src" -IGUMBO_INCLUDE_DIRS="$current/target/gumbo-parser/src" -DGumbo_LIBRARY="$current/target/gumbo-parser/.libs/libgumbo.so" -DGumbo_static_LIBRARY="$current/target/gumbo-parser/.libs/libgumbo.a" ..
	make
	cd $current
	echo "done"
fi

function compile_gumbo_query_client()
{
	echo "Compiling gumbo_query_client..."
	mkdir -p priv
	rm priv/gumbo_query_client
	mkdir -p target/$gumbo_query_client/build
	cd target/$gumbo_query_client/build
	rm -rf *
	cmake -DERLANG_PATH=`erl -eval 'io:format("~s", [lists:concat([code:root_dir(), "/erts-", erlang:system_info(version)])]), halt()' -s init stop -noshell` ..
	make
	mv gumbo_query_client $current/priv
	cd $current
	echo "done"
}

if [ "$mix_env" = "dev" ] || [ "$mix_env" = "test" ]
then
	echo $mix_env
	compile_gumbo_query_client
else
	check=`find priv -name gumbo_query_client`
	if [ -z "$check" ]
	then
		compile_gumbo_query_client
	fi
fi