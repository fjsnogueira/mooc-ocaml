(* --- Given prelude --- *)

exception NotFound ;;

type 'e rel = 'e -> 'e list ;;
type 'e prop = 'e -> bool ;;

type ('a, 'set) set_operations = {
  empty : 'set;              (* The empty set. *)
  mem : 'a -> 'set -> bool;  (* [mem x s = true] iff [x] is in [s]. *)
  add : 'a -> 'set -> 'set;  (* [add s x] is the set [s] union {x}. *)
} ;;

type ('configuration, 'move) puzzle = {
  move : 'configuration -> 'move -> 'configuration;
  possible_moves : 'configuration -> 'move list;
  final : 'configuration -> bool
} ;;

type piece_kind = S | H | V | C | X ;;
type piece = piece_kind * int ;;
let x = (X, 0) and s = (S, 0) and h = (H, 0) ;;
let (c0, c1, c2, c3) = ((C, 0), (C, 1), (C, 2), (C, 3)) ;;
let (v0, v1, v2, v3) = ((V, 0), (V, 1), (V, 2), (V, 3)) ;;
let all_pieces : piece list = [ s; h; c0; c1; c2; c3; v0; v1; v2; v3 ] ;;

type board = piece array array ;;
let initial_board =
  [| [| v0 ; s  ; s  ; v1 |];
     [| v0 ; s  ; s  ; v1 |];
     [| v2 ; h  ; h  ; v3 |];
     [| v2 ; c0 ; c1 ; v3 |];
     [| c2 ; x  ; x  ; c3 |] |] ;;

let initial_board_simpler =
  [| [| c2 ; s  ; s  ; c1 |] ;
     [| c0 ; s  ; s  ; c3 |] ;
     [| v1 ; v2 ; v3 ; v0 |] ;
     [| v1 ; v2 ; v3 ; v0 |] ;
     [| x  ; x  ; x  ; x  |] |] ;;

let initial_board_trivial =
  [| [| x  ; s  ; s  ; x  |] ;
     [| x  ; s  ; s  ; x  |] ;
     [| x  ; x  ; x  ; x  |] ;
     [| x  ; x  ; x  ; x  |] ;
     [| x  ; x  ; x  ; x  |] |] ;;

type direction = { dcol : int; drow : int; } ;;
type move = Move of piece * direction * board ;;
let move _ (Move (_, _, b)) = b ;;


(* --- Preliminaries --- *)

let rec loop p f x =
  if p x
  then x
  else loop p f (f x) ;;

let rec find p = function
  | [] -> raise NotFound
  | hd :: tl when p hd = true -> hd
  | _ :: tl -> find p tl ;;

let rec exists p l =
  try
    ignore (find p l); true
  with NotFound -> false ;;


(* --- Part A: A Generic Problem Solver --- *)

let near : int rel =
  fun x -> [x - 2; x - 1; x; x + 1; x + 2] ;;

let flat_map (r : 'e rel) =
  fun l -> List.concat (List.map r l) ;;

let rec iter_rel (r : 'e rel) (n : int) =
  fun x -> match n with
    | 0 -> [x]
    | i -> flat_map r (iter_rel r (n - 1) x) ;;

let solve (r : 'a rel) (p : 'a prop)  x =
  let rec aux l =
    try
      find p l
    with NotFound -> aux (flat_map r l)
  in aux [x] ;;

let solve_path (r : 'a rel) (p : 'a prop) x =
  let rec aux next = function
    | [x] -> x :: (aux [] (r x))
    | [] -> aux [] next
    | hd :: tl when p hd -> [hd]
    | hd :: tl ->
      let partial = r hd in
      try
        [find p partial];
      with NotFound -> aux (next @ partial) tl
  in aux [] [x] ;;



let archive_map opset r (s, l) =
  "Replace this string with your implementation." ;;

let solve' opset r p x =
  "Replace this string with your implementation." ;;

let solve_path' opset r p x =
  "Replace this string with your implementation." ;;

let solve_puzzle p opset c =
  "Replace this string with your implementation." ;;

(* --- Part B: A Solver for Klotski --- *)

let final board =
  "Replace this string with your implementation." ;;

let move_piece board piece { drow; dcol } =
  "Replace this string with your implementation." ;;

let possible_moves board =
  "Replace this string with your implementation." ;;

module BoardSet = Set.Make (struct
    type t = board
    let compare b1 b2 =
      failwith "Replace this with your implementation." ;;
  end)

let solve_klotski initial_board =
  "Replace this string with your implementation." ;;