defmodule Day02 do
  defp invalid1?(i) do
    {l, r} =
      Integer.to_string(i)
      |> then(fn s -> String.split_at(s, div(String.length(s), 2)) end)
    l == r
  end

  defp part1(input) do
    Enum.map(input, fn s ->
      [s, e] = String.split(s, "-", parts: 2) |> Enum.map(&String.to_integer/1)
      l = for n <- s..e, invalid1?(n), do: n
      Enum.sum(l)
    end)
    |> Enum.sum
  end

  defp periodic?(s, f) do
    chunk = binary_part(s, 0, f)
    check_period(s, chunk, f)
  end

  defp check_period(binary, chunk, f) do
    case binary do
      <<^chunk::binary-size(f), rest::binary>> -> check_period(rest, chunk, f)
      <<>> -> true
      _ -> false
    end
  end

  defp invalid2?(i) do
    s = Integer.to_string(i)
    len = byte_size(s)
    Enum.any?(1..div(len, 2), fn f ->
      rem(len,f) == 0 and periodic?(s, f)
    end)
  end


  defp part2(input) do
    Enum.map(input, fn s ->
      [s_str, e_str] = String.split(s, "-", parts: 2)
      s = String.to_integer(s_str)
      e = String.to_integer(e_str)

      s..e
      |> Task.async_stream(
        fn n ->
          if invalid2?(n), do: n, else: 0
        end,
        max_concurrency: System.schedulers_online(),
        timeout: :infinity
      )
      |> Enum.reduce(0, fn
        {:ok, val}, acc -> acc + val
        {:error, _reason}, acc -> acc
      end)
    end)
    |> Enum.sum
  end

  def solve do
    file = Reader.read_file("inputs/202502.txt")
    input = file |> String.trim |> String.split(",")
    # IO.inspect(part1(input))
    IO.inspect(part2(input))
  end
end
