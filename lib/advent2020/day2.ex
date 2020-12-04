defmodule Advent2020.Day2 do
  @external_resource Path.join(:code.priv_dir(:advent2020), "input-day2.txt")
  @passwords @external_resource
             |> File.read!()
             |> String.split("\n", trim: true)
             |> Enum.map(&String.split(&1, ["-", " ", ":"], trim: true))

  def run() do
    Enum.count(passwords(), &valid_password?/1)
  end

  def run2() do
    Enum.count(passwords(), &valid_password_new?/1)
  end

  defp valid_password?([min, max, policy_char, password]) do
    min = String.to_integer(min)
    max = String.to_integer(max)

    count =
      for <<char <- password>>,
          <<char>> == policy_char,
          reduce: 0 do
        acc -> acc + 1
      end

    count >= min and count <= max
  end

  def valid_password_new?([first, second, policy_char, password]) do
    first = String.to_integer(first) - 1
    second = String.to_integer(second) - 1

    (String.at(password, first) == policy_char and String.at(password, second) != policy_char) or
      (String.at(password, first) != policy_char and String.at(password, second) == policy_char)
  end

  defp passwords(), do: @passwords
end
