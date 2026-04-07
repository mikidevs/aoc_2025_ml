open Core
open Aoc

let input = In_channel.read_all "inputs/202501.txt"

let parse input =
  input
  |> String.split_lines
  |> List.map ~f:(fun s -> String.get s 0, int_of_string (String.drop_prefix s 1))

let mod_pos a m =
  let r = a mod m in
  if r < 0 then r + m else r

let part1 input =
  let turns =
    input
    |> parse
    |> List.map ~f:(fun (f, s) ->
        let op =
          match f with
          | 'L' -> (-)
          | 'R' -> (+)
          | _ -> failwith "invalid"
        in
        (op, s)
      )
  in
  List.fold turns ~init:(50, 0)
    ~f:(fun (curr, n) (op, am) ->
      let m = mod_pos (op curr am) 100 in
      (m, n + Bool.to_int(m = 0))
    )
  |> snd

let part2 input =
  let turns = parse input in
  List.fold turns ~init:(50, 0)
    ~f:(fun (curr, n) (dir, am) -> match dir with
      | 'R' -> let sum = curr + am in
               ((sum mod 100), n + (sum / 100))
      | 'L' -> let sum = curr - am in
               let w = if sum > 0 then 0 else 1 + ((am - curr) / 100) in
               (((sum mod 100) + 100) mod 100, n + w)
      | _ -> failwith "invalid"
    )
  |> snd

let solve =
  Printf.printf "p1: %d\np2: %d\n"
    (part1 input)
    (part2 input)
