## *Under active developmend. Not yet published.*

# GumboQueryEx

Elixir/Erlang bindings for lazytigers **gumbo-query**
>A library that provides CSS selectors for Google's Gumbo Html parser.

- [gumbo-parser](https://github.com/google/gumbo-parser): HTML5 parsing library in pure C99; fully conformant with the HTML5 spec
- [gumbo-query](https://github.com/lazytiger/gumbo-query): CSS selectors

The binding is implemented as a **C-Node** following the excellent example in [@Overbryd](https://github.com/Overbryd/nodex) package **nodex**.

- [nodex](https://github.com/Overbryd/nodex): distributed Elixir and C-Nodes

>C-Nodes are external os-processes that communicate with the Erlang VM through erlang messaging. That way you can implement native code and call into it from Elixir in a safe predictable way. The Erlang VM stays unaffected by crashes of the external process.

## Example

*Right now you can only clone the repo and execute tests...*

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

	git submodule update --init --recursive --remote

## Compile and test

	mix deps.get
	mix compile
	mix test

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
- [ ] Parse a HTML-document into a tree
- [ ] Find nodes using selector
- [ ] Expose node-retrieval functions