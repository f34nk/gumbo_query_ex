#!/bin/bash

current=`pwd`

check=`find cpp_src \( -name libgumbo.a -o -name libgumbo.so \)`
if [ ! -z "$check" ]
then
	echo "Clean gumbo-parser..."
	cd cpp_src/gumbo-parser
	make clean
	cd $current
	echo "done"
fi

check=`find cpp_src \( -name libgq.a -o -name libgq.so \)`
if [ ! -z "$check" ]
then
	echo "Clean gumbo-query..."
	cd ../gumbo-query/build
	make clean
	cd $current
	echo "done"
fi

check=`find priv -name example_client`
if [ ! -z "$check" ]
then
	echo "remove example_client..."
	cd priv
	rm example_client
	cd $current
	echo "done"
fi

check=`find priv -name gumbo_query_client`
if [ ! -z "$check" ]
then
	echo "remove gumbo_query_client..."
	cd priv
	rm gumbo_query_client
	cd $current
	echo "done"
fi