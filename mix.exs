defmodule GumboQueryEx.MixProject do
  use Mix.Project

  def project do
    [
      app: :gumbo_query_ex,
      version: "0.1.0",
      elixir: "~> 1.5",
      compilers: [:gumbo_query_ex_make] ++ Mix.compilers,
      start_permanent: Mix.env() == :prod,
      deps: deps()
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
      # cnode helpers
      {:nodex, "~> 0.1.1"},
      {:mix_test_watch, "~> 0.5", only: :dev, runtime: false}
    ]
  end
end

defmodule Mix.Tasks.Compile.MycssExMake do
  @artifacts [
    "priv/gumbo_query_ex.so",
    "priv/gumbo_query_ex_worker"
  ]

  def run(_) do
    if match? {:win32, _}, :os.type do
      IO.warn "Windows is not yet a target."
      exit(1)
    else
      {result, _error_code} = System.cmd("make",
        @artifacts,
        stderr_to_stdout: true,
        env: [{"MIX_ENV", to_string(Mix.env)}]
      )
      IO.binwrite result
    end
    :ok
  end

  def clean() do
    {result, _error_code} = System.cmd("make", ["clean"], stderr_to_stdout: true)
    Mix.shell.info result
    :ok
  end
end
