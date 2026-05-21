defmodule Mix.Tasks.Pcrm.Gen.Live do
  use Mix.Task

  @shortdoc "Generates a LiveView resource with PCRM conventions"

  def run(args) do
    Mix.Task.run("phx.gen.live", args)
    [_context, schema, plural | _] = args
    inject_routes(schema, plural)
  end

  defp inject_routes(schema, plural) do
    router_path = "lib/pcrm_web/router.ex"
    routes = build_routes(schema, plural)
    content = File.read!(router_path)

    case find_auth_scope_end(content) do
      {:ok, offset} ->
        {before, rest} = String.split_at(content, offset)
        File.write!(router_path, before <> routes <> rest)
        Mix.shell().info([:green, "* injecting ", :reset, router_path])

      :error ->
        Mix.shell().error(
          "Could not find authenticated scope in #{router_path}. Add these routes manually:\n\n#{routes}"
        )
    end
  end

  defp build_routes(schema, plural) do
    alias_name = schema <> "Live"
    prefix = "/" <> plural

    [
      ~s|    live "#{prefix}", #{alias_name}.Index, :index|,
      ~s|    live "#{prefix}/new", #{alias_name}.Form, :new|,
      ~s|    live "#{prefix}/:id", #{alias_name}.Show, :show|,
      ~s|    live "#{prefix}/:id/edit", #{alias_name}.Form, :edit|,
      ""
    ]
    |> Enum.join("\n")
  end

  defp find_auth_scope_end(content) do
    lines = String.split(content, "\n")
    pipe_idx = Enum.find_index(lines, &String.contains?(&1, "pipe_through [:browser, :auth]"))

    with pipe_idx when not is_nil(pipe_idx) <- pipe_idx,
         scope_indent = leading_spaces(Enum.at(lines, pipe_idx)) - 2,
         {:ok, end_idx} <- find_closing_end(lines, pipe_idx + 1, scope_indent) do
      offset =
        lines
        |> Enum.take(end_idx)
        |> Enum.join("\n")
        |> byte_size()
        |> Kernel.+(1)

      {:ok, offset}
    else
      _ -> :error
    end
  end

  defp find_closing_end(lines, from, target_indent) do
    lines
    |> Enum.slice(from..-1//1)
    |> Enum.with_index(from)
    |> Enum.reduce_while({:error, 0}, fn {line, idx}, {:error, depth} ->
      trimmed = String.trim(line)
      spaces = leading_spaces(line)

      new_depth =
        cond do
          Regex.match?(~r/\bdo\s*$/, trimmed) -> depth + 1
          Regex.match?(~r/^end\s*$/, trimmed) and spaces == target_indent and depth == 0 -> -1
          Regex.match?(~r/^end\b/, trimmed) -> depth - 1
          true -> depth
        end

      if new_depth < 0,
        do: {:halt, {:ok, idx}},
        else: {:cont, {:error, max(new_depth, 0)}}
    end)
  end

  defp leading_spaces(line) do
    String.length(line) - String.length(String.trim_leading(line))
  end
end
