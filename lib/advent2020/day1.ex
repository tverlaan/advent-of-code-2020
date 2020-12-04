defmodule Advent2020.Day1 do
  @external_resource Path.join(:code.priv_dir(:advent2020), "input-day1.txt")
  @expenses @external_resource
            |> File.read!()
            |> String.split("\n", trim: true)
            |> Enum.map(&(&1 |> String.trim() |> String.to_integer()))

  def run() do
    Enum.reduce_while(expenses(), 0, fn expense, acc ->
      case Enum.find(expenses(), 0, &(&1 + expense == 2020)) do
        0 -> {:cont, acc}
        expense2 -> {:halt, expense * expense2}
      end
    end)
  end

  def run2() do
    for expense <- expenses(),
        expense2 <- expenses(),
        expense3 <- expenses(),
        expense + expense2 + expense3 == 2020 do
      throw(expense * expense2 * expense3)
    end
  catch
    value -> value
  end

  defp expenses(), do: @expenses
end
