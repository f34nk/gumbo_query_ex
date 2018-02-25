#!/bin/bash

current=`pwd`

# check=`find /usr/local/lib -name libgumbso*`
check=`find cpp_src \( -name libgumbo.a -o -name libgumbo.so \)`
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
	cd cpp_src/gumbo-parser
	./autogen.sh
	./configure
	make
	# sudo make install
	cd $current
	echo "done"
fi

check=`find cpp_src \( -name libgq.a -o -name libgq.so \)`
if [ -z "$check" ]
then
	if [ -z `which cmake` ]
	then
		echo "Please install cmake:
		sudo apt-get install cmake"
		exit 1
	fi
	# gumbo-query
	# https://github.com/lazytiger/gumbo-query#installation
	echo "Compiling gumbo-query..."
	mkdir -p cpp_src/gumbo-query/build
	cd cpp_src/gumbo-query/build
	cmake -IGumbo_INCLUDE_DIR="$current/cpp_src/gumbo-parser/src" -DGumbo_LIBRARY="$current/cpp_src/gumbo-parser/.libs/libgumbo.so" -DGumbo_static_LIBRARY="$current/cpp_src/gumbo-parser/.libs/libgumbo.a" ..
	make
	cd $current
	echo "done"
fi

# check=`find cpp_src/example_client/build -name example_client`
check=`find priv -name example_client`
if [ -z "$check" ]
then
	echo "Compiling example_client..."
	mkdir -p priv
	mkdir -p cpp_src/example_client/build
	cd cpp_src/example_client/build
	rm -rf *
	cmake -DERLANG_PATH=`erl -eval 'io:format("~s", [lists:concat([code:root_dir(), "/erts-", erlang:system_info(version)])]), halt()' -s init stop -noshell` ..
	make
	mv example_client $current/priv
	cd $current
	echo "done"
fi

check=`find priv -name gumbo_query_client`
if [ -z "$check" ]
then
	echo "Compiling gumbo_query_client..."
	mkdir -p priv
	mkdir -p cpp_src/gumbo_query_client/build
	cd cpp_src/gumbo_query_client/build
	rm -rf *
	cmake -DERLANG_PATH=`erl -eval 'io:format("~s", [lists:concat([code:root_dir(), "/erts-", erlang:system_info(version)])]), halt()' -s init stop -noshell` ..
	make
	mv gumbo_query_client $current/priv
	cd $current
	echo "done"
fi