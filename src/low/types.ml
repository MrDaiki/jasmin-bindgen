open Jasmin 
open Prog


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
  params:  exported_parameter list;
  return_type: exported_type list;
}

type exported_program = {
  functions: exported_function list;
  config_path : string;
}

