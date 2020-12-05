defmodule Advent2020.Day4 do
  @external_resource Path.join(:code.priv_dir(:advent2020), "input-day4.txt")
  @passports @external_resource
             |> File.read!()
             |> String.split("\n\n", trim: true)
             |> Enum.map(&String.split(&1, [" ", "\n"], trim: true))

  defmodule Passport do
    defstruct [:byr, :iyr, :eyr, :hgt, :hcl, :ecl, :pid, :cid]

    def new(passport) do
      passport
      |> Enum.reduce(%__MODULE__{}, fn <<key::binary-size(3), ":", value::binary>>, acc ->
        key = String.to_existing_atom(key)
        Map.put(acc, key, value)
      end)
    end

    defguard is_valid?(p)
             when not is_nil(p.byr) and not is_nil(p.iyr) and not is_nil(p.eyr) and
                    not is_nil(p.hgt) and not is_nil(p.hcl) and not is_nil(p.ecl) and
                    not is_nil(p.pid)

    def valid?(p), do: is_valid?(p)

    def valid2?(p) when is_valid?(p) do
      byr_valid?(p) and iyr_valid?(p) and eyr_valid?(p) and hgt_valid?(p) and hcl_valid?(p) and
        ecl_valid?(p) and pid_valid?(p)
    end

    def valid2?(_), do: false

    defp byr_valid?(%{byr: byr}) do
      byr = String.to_integer(byr)
      byr >= 1920 and byr <= 2002
    end

    defp iyr_valid?(%{iyr: iyr}) do
      iyr = String.to_integer(iyr)
      iyr >= 2010 and iyr <= 2020
    end

    defp eyr_valid?(%{eyr: eyr}) do
      eyr = String.to_integer(eyr)
      eyr >= 2020 and eyr <= 2030
    end

    defp hgt_valid?(%{hgt: height}) do
      {length, unit} = Integer.parse(height)

      case unit do
        "cm" -> length >= 150 and length <= 193
        "in" -> length >= 59 and length <= 76
        _ -> false
      end
    end

    defp hcl_valid?(%{hcl: hcl}) do
      Regex.match?(~r/^#[0-9a-f]{6}$/, hcl)
    end

    defp ecl_valid?(%{ecl: ecl}) do
      ecl in ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
    end

    defp pid_valid?(%{pid: pid}) do
      String.length(pid) == 9 and is_integer(String.to_integer(pid))
    end
  end

  def run() do
    run(&Passport.valid?/1)
  end

  def run2() do
    run(&Passport.valid2?/1)
  end

  def run(validator) do
    passports()
    |> Enum.map(&Passport.new/1)
    |> Enum.count(validator)
  end

  defp passports(), do: @passports
end
