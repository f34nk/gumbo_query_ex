#!/bin/bash

current=`pwd`

check=`find target \( -name libgumbo.a -o -name libgumbo.so \)`
if [ ! -z "$check" ]
then
	echo "Clean gumbo-parser..."
	cd target/gumbo-parser
	make clean
	cd $current
	echo "done"
fi

check=`find target \( -name libgq.a -o -name libgq.so \)`
if [ ! -z "$check" ]
then
	echo "Clean gumbo-query..."
	cd target/gumbo-query/build
	make clean
	rm -rf *
	cd $current
	echo "done"
fi

check=`find priv -name gumbo_query_client`
if [ ! -z "$check" ]
then
	echo "Clean gumbo_query_client..."
	cd target/gumbo_query_client/build
	make clean
	rm -rf *
	cd $current
	echo "remove gumbo_query_client..."
	cd priv
	rm gumbo_query_client
	cd $current
	echo "done"
fi