defmodule Advent2020.Day5 do
  @external_resource Path.join(:code.priv_dir(:advent2020), "input-day5.txt")
  @boarding_passes @external_resource
                   |> File.read!()
                   |> String.split("\n", trim: true)

  def run() do
    boarding_passes()
    |> Enum.map(&seat_id/1)
    |> Enum.max()
  end

  def run2() do
    all_seats =
      boarding_passes()
      |> Enum.map(&seat_id/1)

    {min, max} = Enum.min_max(all_seats)

    for seat_id <- min..max,
        seat_id not in all_seats do
      seat_id
    end
    |> hd()
  end

  def seat_id(boarding_pass) do
    boarding_pass
    |> String.replace(["F", "L"], "0")
    |> String.replace(["B", "R"], "1")
    |> String.to_integer(2)
  end

  defp boarding_passes(), do: @boarding_passes
end
