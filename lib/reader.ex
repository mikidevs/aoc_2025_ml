defmodule Reader do
  def read_file(name) do
    case File.read(name) do
      {:ok, content} ->
        content

      {:error, reason} ->
        IO.puts("Could not read file: #{reason}")
    end
  end
end
