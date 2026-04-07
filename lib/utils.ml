open Core

let sum_ints = List.fold ~init:0 ~f:(+)

let sort_ints = List.sort ~compare:Int.compare

(* Find the first index * value in the list which satisfies f*)
let find_firsti t ~f =
  let rec loop = function
    | [], _-> None
    | x :: l, acc -> if f x then Some (acc, x) else loop (l, acc + 1)
  in
  loop (t, 0)

let find_firsti_exn =
  let not_found = Not_found_s (Atom "Util.find_firsti_exn: not found") in
  let find_firsti_exn t ~f =
    match find_firsti t ~f with
    | None -> raise not_found
    | Some x -> x
  in
  find_firsti_exn
