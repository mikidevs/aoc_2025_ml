defmodule Day03 do
  defp cmp({s1, _}, {s2, _}) do
    s1 >= s2
  end

  def greatest(s) do
    idxd = s
      |> String.graphemes
      |> Enum.with_index

    {fst, ri} = idxd
      |> Enum.take(idxd |> length |> then(&(&1 - 1)))
      |> Enum.max(&cmp/2)

    {snd, _} = idxd
      |> Enum.slice((ri+1)..length(idxd))
      |> Enum.max(&cmp/2)

    fst <> snd
  end

  defp part1(input) do
    Enum.map(input, &(&1 |> greatest |> String.to_integer))
    |> Enum.sum
  end

  defp part2(input) do

  end

  def solve do
    input = Reader.read_file("inputs/202503.txt")
    # input =
    # """
    # 987654321111111
    # 811111111111119
    # 234234234234278
    # 818181911112111
    # """
    IO.inspect(input |> String.split |> part1, charlists: :as_lists, limit: :infinity)
    # IO.inspect(part2(input))
  end
end
