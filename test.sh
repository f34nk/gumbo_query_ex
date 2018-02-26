#!/bin/bash

current=`pwd`

# check=`find target \( -name libgumbo.a -o -name libgumbo.so \)`
# if [ ! -z "$check" ]
# then

	# echo "Test gumbo-parser..."

	# To run the unit tests, you'll need to have [googletest][] downloaded and unzipped.

	# cd target/gumbo-parser
	# make test
	# cd $current
	# echo "done"
# fi

# check=`find target \( -name libgq.a -o -name libgq.so \)`
# if [ ! -z "$check" ]
# then
	# echo "Test gumbo-query..."

	# To run the unit test, you'll have to checkout the "test-fix" branch from this repo: git@github.com:f34nk/gumbo-query.git

	# cd target/gumbo-query/build
	# make test
	# cd $current
	# echo "done"
# fi

check=`find priv -name gumbo_query_client`
if [ ! -z "$check" ]
then
	echo "Test gumbo_query_client..."
	cd target/gumbo_query_client/build
	make test
	cd $current
	echo "done"
	echo "Test log: target/gumbo_query_client/build/Testing/Temporary"
fi