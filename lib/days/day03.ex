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

  def greatest2(s) do
    str_ls = String.graphemes(s)
    loop(str_ls, "", 12)
  end

  def loop(_, acc, 0) do
    acc
  end

  def loop(str_ls, acc, i) do
    max_elem = str_ls
      |> Enum.take(str_ls |> length |> then(&(&1 - i + 1)))
      |> Enum.max

    idx = Enum.find_index(str_ls, &(&1 == max_elem))

    slice = str_ls |> Enum.slice((idx+1)..length(str_ls))

    loop(slice, acc <> max_elem, i - 1)
  end

  defp part1(input) do
    Enum.map(input, &(&1 |> greatest |> String.to_integer))
    |> Enum.sum
  end

  defp part2(input) do
    Enum.map(input, &(&1 |> greatest2 |> String.to_integer))
    |> Enum.sum
  end

  def solve do
    input = Reader.read_file("inputs/202503.txt")
    # input =
    # """
    # 987654321111111
    # 811111111111119
    # 818181911112111
    # 234234234234278
    # """
    IO.inspect(input |> String.split |> part2, charlists: :as_lists, limit: :infinity)
  end
end
