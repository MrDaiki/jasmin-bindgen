open Jasmin 
open Prog

open CoreIdent


type primitive_exported_type =
| Uint of int
| Bool 

type exported_type =
| Primitive of primitive_exported_type
| Array of primitive_exported_type * int


let rec string_of_exported_type = function 
| Primitive (Uint n) -> Printf.sprintf "u%d" n
| Primitive (Bool) -> Printf.sprintf "bool"
| Array (t, n) -> Printf.sprintf "%s[%d]" (string_of_exported_type (Primitive t)) n

type exported_parameter = string * exported_type

type exported_function = {
  name: string;
  params: exported_parameter list;
  return_type: exported_type list;
}

type exported_program = {
  functions: exported_function list;
  config_path : string;
}


let ws_to_size :Wsize.wsize -> int = function 
| U8 -> 8 
| U16 -> 16
| U32 -> 32
| U64 -> 64
| U128 -> 128
| U256 -> 256

let rty_to_bindgen (rty : ty) : exported_type = 
  match rty with 
  | Arr (ws,length) -> Array (Uint (ws_to_size ws), length)
  | Bty ty -> 
    match ty with 
    | Bool -> Primitive Bool
    | Int -> Primitive (Uint 32)
    | U ws -> Primitive (Uint (ws_to_size ws))

let param_to_bindgen (var : var) : exported_parameter = 
  let ty = rty_to_bindgen var.v_ty in
  (var.v_name, ty)

let func_to_bindgen (func :('info,'asm) func) : exported_function = 
  let params = List.map param_to_bindgen func.f_args in
  let return_types = List.map rty_to_bindgen func.f_tyout in
  {name = func.f_name.fn_name; params; return_type = return_types}

let prog_to_bindgen ((_,funcs): ('info,'asm) prog) (config_path : string) : exported_program = 
  let functions = List.filter_map (fun f -> 
    match f.f_cc with 
    | Export _ -> Some f
    | _ -> None
  ) funcs in
  let exported_functions = List.map func_to_bindgen functions in
  {functions = exported_functions; config_path}