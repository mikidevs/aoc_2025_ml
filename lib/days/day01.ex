defmodule Day01 do
  defp parse(input) do
    input
    |> String.split
    |> Enum.map(fn st ->
      {f, s} = String.next_grapheme(st)
      {f, String.to_integer(s)}
     end)
  end

  defp part1(turns) do
    Enum.map(turns, fn {f, s} ->
      op = case f do
        "R" -> &+/2
        "L" -> &-/2
      end
      {op, s}
    end)
    |> Enum.reduce({50,0}, fn {op, am}, {c, n} ->
      m = Integer.mod(op.(c, am), 100)
      {m, n + Bool.to_int(m == 0)}
    end)
    |> elem(1)
  end

  defp part2(turns) do
    Enum.reduce(turns, {50,0}, fn {dir, am}, {c, n} ->
      case dir do
        "R" -> {rem(c + am, 100), n + div(c + am, 100)}
        "L" ->
          rots = cond do
            c == 0 -> div(am, 100)
            am >= c -> div(am - c, 100) + 1
            true -> 0
          end
          {Integer.mod(c - am, 100), n + rots}
      end
    end)
    |> elem(1)
  end

  def solve do
    input = parse(Reader.read_file("inputs/202501.txt"))
    IO.inspect(part1(input))
    IO.inspect(part2(input))
  end
end
