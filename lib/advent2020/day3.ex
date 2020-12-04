defmodule Advent2020.Day3 do
  @external_resource Path.join(:code.priv_dir(:advent2020), "input-day3.txt")
  @map @external_resource
       |> File.read!()
       |> String.split("\n", trim: true)
       |> Enum.map(&String.split(&1, "", trim: true))
  @map_width @map
             |> hd()
             |> length()

  def run(horiz \\ 3, vert \\ 1) do
    {_, _, trees} =
      Enum.reduce(map(), {0, 0, 0}, fn row, {pos, skip, acc} ->
        cond do
          skip > 1 -> {pos, skip - 1, acc}
          Enum.at(row, pos) == "#" -> {new_pos(pos + horiz), vert, acc + 1}
          true -> {new_pos(pos + horiz), vert, acc}
        end
      end)

    trees
  end

  def run2() do
    run(1) * run(3) * run(5) * run(7) * run(1, 2)
  end

  defp new_pos(pos) when pos >= @map_width, do: pos - @map_width
  defp new_pos(pos), do: pos

  defp map(), do: @map
end
