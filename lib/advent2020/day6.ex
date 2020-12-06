defmodule Advent2020.Day6 do
  @external_resource Path.join(:code.priv_dir(:advent2020), "input-day6.txt")
  @declarations @external_resource
                |> File.read!()
                |> String.split("\n\n", trim: true)
                |> Enum.map(&String.split(&1, "\n", trim: true))

  def run() do
    declarations()
    |> Enum.map(&count_yes/1)
    |> Enum.sum()
  end

  def run2() do
    declarations()
    |> Enum.map(&group_count_yes/1)
    |> Enum.sum()
  end

  def count_yes(group_declaration) do
    group_declaration
    |> Enum.flat_map(&String.codepoints/1)
    |> Enum.uniq()
    |> Enum.count()
  end

  def group_count_yes(group_declaration) do
    group_declaration
    |> Enum.sort(&(byte_size(&1) <= byte_size(&2)))
    |> Enum.map(&String.codepoints/1)
    |> count_each_group()
  end

  def count_each_group([first | others]) do
    Enum.reduce(first, 0, fn char, acc ->
      others
      |> Enum.all?(&(char in &1))
      |> plus_one(acc)
    end)
  end

  def plus_one(true, v), do: v + 1
  def plus_one(_, v), do: v

  defp declarations(), do: @declarations
end
