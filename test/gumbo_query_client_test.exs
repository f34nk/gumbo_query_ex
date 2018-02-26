defmodule GumboQueryClientTest do
  use ExUnit.Case
  alias Nodex.Cnode
  doctest Cnode

  @html_short """
  <h1>Lorem Ipsum</h1>
  <p>"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."</p>
  """

  @html_long """
  <!DOCTYPE html>
  <html>

  <head>
    <style type="text/css">
    h1 {
      color: blue;
    }

    li:nth-child(1) {
      background: red;
    }
    table {
      width: 100%;
    }
    table td{
      width: 50%;
    }
    table tr, table td{
      border: 1px solid black;
      text-align: center;
    }
    </style>
  </head>

  <body>
    <h1>Lorem Ipsum</h1>
    <h4>"Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit..."</h4>
    <h5>"There is no one who loves pain itself, who seeks after it and wants to have it, simply because it is pain..."</h5>

    <ul>
      <li>Coffee</li>
      <li>Tea</li>
      <li><span id="milk">Milk</span></li>
    </ul>

    <h3>The standard Lorem Ipsum passage, used since the 1500s</h3>
    <p>"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."</p>

    <table>
      <tr>
        <td>First cell in first table. The cell to the right has the second table in it.</td>
        <td>
          <table>
            <tr>
              <td>nested table</td>
            </tr>
            <tr>
              <td id="nested">nested table</td>
            </tr>
          </table>
        </td>
      </tr>
    </table>

    <h3>Section 1.10.32 of "de Finibus Bonorum et Malorum", written by Cicero in 45 BC</h3>
    <p>"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?"</p>

    <!--<input type="email" id="email" value="Email...">-->

    <h3>1914 translation by H. Rackham</h3>
    <p>"But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful. Nor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but because occasionally circumstances occur in which toil and pain can procure him some great pleasure. To take a trivial example, which of us ever undertakes laborious physical exercise, except to obtain some advantage from it? But who has any right to find fault with a man who chooses to enjoy a pleasure that has no annoying consequences, or one who avoids a pain that produces no resultant pleasure?"</p>

    <h3>Section 1.10.33 of "de Finibus Bonorum et Malorum", written by Cicero in 45 BC</h3>
    <p>"At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat."</p>

    <h3>1914 translation by H. Rackham</h3>
    <p>"On the other hand, we denounce with righteous indignation and dislike men who are so beguiled and demoralized by the charms of pleasure of the moment, so blinded by desire, that they cannot foresee the pain and trouble that are bound to ensue; and equal blame belongs to those who fail in their duty through weakness of will, which is the same as saying through shrinking from toil and pain. These cases are perfectly simple and easy to distinguish. In a free hour, when our power of choice is untrammelled and when nothing prevents our being able to do what we like best, every pleasure is to be welcomed and every pain avoided. But in certain circumstances and owing to the claims of duty or the obligations of business it will frequently occur that pleasures have to be repudiated and annoyances accepted. The wise man therefore always holds in these matters to this principle of selection: he rejects pleasures to secure other greater pleasures, or else he endures pains to avoid worse pains."</p>
  </body>

  </html>
  """

  # https://elixir-lang.org/crash-course.html#lists-and-binaries
  # In Elixir, the word string means a UTF-8 binary and there is a String module that works on such data.

  # def raw_binary_to_string(raw) do
  #   codepoints = String.codepoints(raw)
  #   val = Enum.reduce(codepoints, fn(w, result) ->
  #     cond do
  #       String.valid?(w) ->
  #         result <> w
  #       true ->
  #         << parsed :: 8>> = w
  #         result <> << parsed :: utf8 >>
  #     end
  #   end)
  # end

  @doc """
    convert raw binary to string
  """
  def binary_to_string(raw) do
    codepoints = String.codepoints(raw)
    val = Enum.reduce(codepoints, fn(w, result) ->
      cond do
        String.valid?(w) ->
          result <> w
        true ->
          << parsed :: 8>> = w
          result <> << parsed :: utf8 >>
      end
    end)
  end

  setup_all(_) do
    Nodex.Distributed.up
    # {:ok, file} = File.open("test/fixtures/lorem_ipsum.html", [:read, :utf8])
    # content = IO.read(file, :all)
    # File.close(file)
    # [content: content]
    :ok
  end

  test "find link" do
    {:ok, pid} = Cnode.start_link(%{exec_path: "priv/gumbo_query_client"})
    {:ok, reply} = Cnode.call(pid, {:find, "<h1><a>some link</a></h1>", "h1 a"})
    assert {:find, "<a>some link</a>"} = reply
  end


  test "find title", context do
    # {:ok, file} = File.open("test/fixtures/lorem_ipsum.html", [:read, :utf8])
    # html = IO.read(file, :all)
    # File.close(file)

    # html = @html_short
    html = @html_long
    # html = html
    # |> binary_to_string()
    # |> String.replace(~r/\r/, "")
    # |> String.replace(~r/\n/, "")
    # |> String.replace(~r/  /, "")

    # html = File.read!("test/fixtures/lorem_ipsum.html")
    # |> binary_to_string()
    # |> String.replace(~r/\r|\n/, "")
    # |> IO.inspect

    # html = "<h1>Lorem Ipsum</h1><p>Dolor sit amet</p>"

    IO.inspect is_binary(html)

    {:ok, pid} = Cnode.start_link(%{exec_path: "priv/gumbo_query_client"})
    {:ok, reply} = Cnode.call(pid, {:find, html, "h1"})
    assert {:find, "<h1>Lorem Ipsum</h1>"} = reply
  end
  # setup_all(_) do
  #   Nodex.Distributed.up
  #   # stop slaves that might have not been cleaned up
  #   Node.list() |> Enum.each(&:slave.stop/1)
  #   {:ok, pid} = Cnode.start_link(%{exec_path: "priv/gumbo_query_client"})
  #   # {:ok, file} = File.open("test/fixtures/lorem_ipsum.html", [:read, :utf8])
  #   # content = IO.read(file, :all)
  #   # File.close(file)
  #   content = ""
  #   %{pid: pid, content: content}
  # end

  # test "find link", context do
  #   %{pid: pid} = context
  #   {:ok, reply} = Cnode.call(pid, {:find, "<h1><a>some link</a></h1>", "h1 a"})
  #   assert {:find, "<a>some link</a>"} = reply
  # end

  # test "find title", context do
  #   %{pid: pid, content: content} = context
  #   # {:ok, file} = File.open("test/fixtures/lorem_ipsum.html", [:read, :utf8])
  #   # content = IO.read(file, :all)
  #   # File.close(file)
  #   {:ok, reply} = Cnode.call(pid, {:find, "<h1>Lorem Ipsum</h1>", "h1"})
  #   assert {:find, "<h1>Lorem Ipsum</h1>"} = reply
  # end

  # test "find nth-child", context do
  #   %{pid: pid, content: content} = context
  #   {:ok, reply} = Cnode.call(pid, {:find, content, "li:nth-child(1)"})
  #   assert {:find, "<li>Coffee</li>"} = reply
  # end

  # test "find all nodes", context do
  #   %{pid: pid, content: content} = context
  #   {:ok, reply} = Cnode.call(pid, {:find, content, "li"})
  #   assert {:find, "<li>Coffee</li>,<li>Tea</li>,<li><span>Milk</span></li>"} = reply
  # end

  # test "find node with id", context do
  #   %{pid: pid, content: content} = context
  #   {:ok, reply} = Cnode.call(pid, {:find, content, "td#nested"})
  #   assert {:find, "<td id=\"nested\">nested table</td>"} = reply
  # end

  # test "find node with attribute and value", context do
  #   %{pid: pid, content: content} = context
  #   {:ok, reply} = Cnode.call(pid, {:find, content, "span[id='milk']"})
  #   assert {:find, "<span id=\"milk\">Milk</span>"} = reply
  # end

  # { u8"not", PseudoOp::Not },
  # { u8"has", PseudoOp::Has },
  # { u8"haschild", PseudoOp::HasChild },
  # { u8"contains", PseudoOp::Contains },
  # { u8"containsown", PseudoOp::ContainsOwn },
  # { u8"matches", PseudoOp::Matches },
  # { u8"matchesown", PseudoOp::MatchesOwn },
  # { u8"nth-child", PseudoOp::NthChild },
  # { u8"nth-last-child", PseudoOp::NthLastChild },
  # { u8"nth-of-type", PseudoOp::NthOfType },
  # { u8"nth-last-of-type", PseudoOp::NthLastOfType },
  # { u8"first-child", PseudoOp::FirstChild },
  # { u8"last-child", PseudoOp::LastChild },
  # { u8"first-of-type", PseudoOp::FirstOfType },
  # { u8"last-of-type", PseudoOp::LastOfType },
  # { u8"only-child", PseudoOp::OnlyChild },
  # { u8"only-of-type", PseudoOp::OnlyOfType },
  # { u8"empty", PseudoOp::Empty }

  # test "can be started with an already started cnode" do
  #   cnode = :"foobar@127.0.0.1"
  #   {:ok, _state} = Cnode.spawn_cnode(%{
  #     exec_path: "priv/gumbo_query_client",
  #     cnode: cnode,
  #     sname: "foobar",
  #     hostname: "127.0.0.1",
  #     ready_line: "foobar@127.0.0.1 ready"
  #   })
  #   {:ok, pid} = Cnode.start_link(%{
  #     exec_path: "priv/gumbo_query_client",
  #     cnode: cnode
  #   })
  #   {:ok, reply} = Cnode.call(pid, {:find, "<h1><a>some link</a></h1>", "h1 a"})
  #   assert {:find, "<a>some link</a>"} = reply
  # end

  # test "fails when executable does not activate within spawn_inactive_timeout" do
  #   assert {:stop, :spawn_inactive_timeout} = Cnode.init(%{
  #     exec_path: "priv/gumbo_query_client",
  #     spawn_inactive_timeout: 0
  #   })
  # end

  # test "fails when connection cannot be established" do
  #   assert {:stop, :unable_to_establish_connection} = Cnode.init(%{
  #     exec_path: "priv/gumbo_query_client",
  #     sname: "unconnectable",
  #     ready_line: "initialising unconnectable@#{Nodex.host()}",
  #   })
  # end

  # test "fails when cnode exits unexpectedly" do
  #   assert {:stop, :cnode_unexpected_exit} = Cnode.init(%{exec_path: "priv/just_exit"})
  # end
end

