## *Experimental. Not yet published.*

# GumboQueryEx

Elixir/Erlang bindings for lazytigers **gumbo-query** and TechnikEmpires **GQ**.

>A CSS selector engine for Google's Gumbo Html parser.

- [gumbo-parser](https://github.com/google/gumbo-parser)
	- HTML5 parsing library in pure C99
	- fully conformant with the HTML5 spec
- [gumbo-query](https://github.com/lazytiger/gumbo-query)
	- CSS selectors
- [GQ](https://github.com/TechnikEmpire/GQ)
	- CSS selectors

The binding is implemented as a **C-Node** following the excellent example in [@Overbryd](https://github.com/Overbryd/nodex) package **nodex**. If you want to learn how to set up bindings to C/C++, you should definitely check it out.

- [nodex](https://github.com/Overbryd/nodex)
	- distributed Elixir
	- save binding with C-Nodes

>C-Nodes are external os-processes that communicate with the Erlang VM through erlang messaging. That way you can implement native code and call into it from Elixir in a safe predictable way. The Erlang VM stays unaffected by crashes of the external process.

## Example

*Right now you can only clone the repo and execute tests...*

https://github.com/f34nk/gumbo_query_ex/blob/master/test/gumbo_query_client_test.exs

## Installation

	git clone git@github.com:f34nk/gumbo_query_ex.git
	cd gumbo_query_ex

<!-- If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `gumbo_query_ex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:gumbo_query_ex, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/gumbo_query_ex](https://hexdocs.pm/gumbo_query_ex).
 -->

## Update submodules

All binding targets are added as submodules in the `target/` folder.

	git submodule update --init --recursive --remote

## Target dependencies

	cmake version 3.x
	libtool (GNU libtool) 2.x
	g++ version 5.x

## Compile and test

Choose client (experimental):
https://github.com/f34nk/gumbo_query_ex/blob/master/compile.sh#L5-L6

	mix deps.get
	mix compile
	mix test
	mix test.target

## Cleanup

	mix clean

## Benchmark

	mix bench

## Roadmap

- [x] Bindings
	- [x] Call as C-Node
	- [ ] Call as dirty-nif
- [x] Tests
	- [x] Call as C-Node
	- [ ] Call as dirty-nif
	- [x] Target tests
	- [ ] Package test
- [ ] Features
	- [ ] Find nodes using selector
	- [ ] Parse a HTML-document into a tree
	- [ ] Expose node-retrieval functions
- [ ] Documentation
- [ ] Publish as hex package