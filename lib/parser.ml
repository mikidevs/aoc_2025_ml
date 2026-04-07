open Core

let seq_of_lines input =
  input
  |> String.split_lines
  |> Sequence.of_list
