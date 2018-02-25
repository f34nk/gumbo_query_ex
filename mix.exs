defmodule GumboQueryEx.MixProject do
  use Mix.Project

  def project do
    [
      app: :gumbo_query_ex,
      version: "0.1.0",
      elixir: "~> 1.5",
      compilers: [:gumbo_query_ex_make] ++ Mix.compilers,
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env() == :prod,
      name: "GumboQueryEx",
      description: """
        A library that provides CSS selectors for Google's Gumbo Html parser.
      """,
      docs: docs(),
      deps: deps(),
      package: package()
    ]
  end

  defp docs do
    [
      main: "GumboQueryEx"
    ]
  end

  def package do
    [
      maintainers: ["Frank Eickhoff"],
      licenses: ["GNU LGPL"],
      links: %{
        "Github" => "https://github.com/f34nk/gumbo_query_ex",
        "Issues" => "https://github.com/f34nk/gumbo_query_ex/issues",
        "gumbo-query" => "https://github.com/lazytiger/gumbo-query",
        "gumbo-parser" => "https://github.com/google/gumbo-parser"
      },
      files: [
        "lib",
        "cpp_src",
        "test",
        "compile.sh",
        "clean.sh",
        "mix.exs",
        "README.md",
        "LICENSE"
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # documentation helpers
      {:ex_doc, ">= 0.0.0", only: :docs},
      # benchmarking helpers
      {:benchfella, "~> 0.3.0", only: :dev},
      # cnode helpers
      {:nodex, "~> 0.1.1"},
      {:mix_test_watch, "~> 0.5", only: :dev, runtime: false}
    ]
  end
end

# https://stackoverflow.com/questions/35271939/how-to-capture-each-line-from-system-cmd-output
defmodule Shell do
  def exec(exe, args, opts \\ [:stream]) when is_list(args) do
    port = Port.open({:spawn_executable, exe}, opts ++ [{:args, args}, :binary, :exit_status, :hide, :use_stdio, :stderr_to_stdout])
    handle_output(port)
  end

  def handle_output(port) do
    receive do
      {^port, {:data, data}} ->
        IO.binwrite(data) # Replace this with the appropriate broadcast
        handle_output(port)
      {^port, {:exit_status, status}} ->
        status
    end
  end
end

defmodule Mix.Tasks.Compile.GumboQueryExMake do
  # @artifacts [
  #   "priv/gumbo_query_ex.so",
  #   "priv/gumbo_query_ex_worker"
  # ]

  def run(_) do
    if match? {:win32, _}, :os.type do
      IO.warn "Windows is not yet a target."
      exit(1)
    else
      Shell.exec(System.cwd() <> "/compile.sh", @artifacts)
      # {result, _error_code} = System.cmd(System.cwd() <> "/compile.sh",
      #   @artifacts,
      #   stderr_to_stdout: true,
      #   env: [{"MIX_ENV", to_string(Mix.env)}]
      # )
      # Mix.shell.info result
    end
    :ok
  end

  def clean() do
    Shell.exec(System.cwd() <> "/clean.sh", [])
    # {result, _error_code} = System.cmd(System.cwd() <> "/clean.sh", [], stderr_to_stdout: true)
    # Mix.shell.info result
    :ok
  end
end
