defmodule GumboQueryClientTest do
  use ExUnit.Case
  alias Nodex.Cnode
  doctest Cnode

  setup_all(_) do
    Nodex.Distributed.up
    {:ok, pid} = Cnode.start_link(%{exec_path: "priv/gumbo_query_client"})
    %{pid: pid}
  end

  test "greets the world", context do
    # {:ok, pid} = Cnode.start_link(%{exec_path: "priv/gumbo_query_client"})
    %{pid: pid} = context
    {:ok, reply} = Cnode.call(pid, {:find, "<h1><a>some link</a></h1>", "h1 a"})
    assert {:find, "<a>some link</a>"} = reply
  end

  test "find title", context do
    # {:ok, pid} = Cnode.start_link(%{exec_path: "priv/gumbo_query_client"})
    %{pid: pid} = context
    {:ok, reply} = Cnode.call(pid, {:find, File.read!("test/fixtures/lorem_ipsum.html"), "h1"})
    # |> IO.inspect
    assert {:find, "<h1>Lorem Ipsum</h1>"} = reply
  end

  test "find li:nth-child(1)", context do
    # {:ok, pid} = Cnode.start_link(%{exec_path: "priv/gumbo_query_client"})
    %{pid: pid} = context
    {:ok, reply} = Cnode.call(pid, {:find, File.read!("test/fixtures/lorem_ipsum.html"), "li:nth-child(1)"})
    assert {:find, "<li>Coffee</li>"} = reply
  end

  test "find li", context do
    # {:ok, pid} = Cnode.start_link(%{exec_path: "priv/gumbo_query_client"})
    %{pid: pid} = context
    {:ok, reply} = Cnode.call(pid, {:find, File.read!("test/fixtures/lorem_ipsum.html"), "li"})
    assert {:find, "<li>Coffee</li>,<li>Tea</li>,<li><span>Milk</span></li>"} = reply
  end

  test "can be started with an already started cnode" do
    cnode = :"foobar@127.0.0.1"
    {:ok, _state} = Cnode.spawn_cnode(%{
      exec_path: "priv/gumbo_query_client",
      cnode: cnode,
      sname: "foobar",
      hostname: "127.0.0.1",
      ready_line: "foobar@127.0.0.1 ready"
    })
    {:ok, pid} = Cnode.start_link(%{
      exec_path: "priv/gumbo_query_client",
      cnode: cnode
    })
    {:ok, reply} = Cnode.call(pid, {:find, "<h1><a>some link</a></h1>", "h1 a"})
    assert {:find, "some link"} = reply
  end

  test "fails when executable does not activate within spawn_inactive_timeout" do
    assert {:stop, :spawn_inactive_timeout} = Cnode.init(%{
      exec_path: "priv/gumbo_query_client",
      spawn_inactive_timeout: 0
    })
  end

  test "fails when connection cannot be established" do
    assert {:stop, :unable_to_establish_connection} = Cnode.init(%{
      exec_path: "priv/gumbo_query_client",
      sname: "unconnectable",
      ready_line: "initialising unconnectable@#{Nodex.host()}",
    })
  end

  # test "fails when cnode exits unexpectedly" do
  #   assert {:stop, :cnode_unexpected_exit} = Cnode.init(%{exec_path: "priv/just_exit"})
  # end
end

