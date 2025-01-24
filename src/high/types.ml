open Jasmin
open Prog

type primitive_exported_type = 
| Uint of int
| Sint of int
| Bool

type exported_type = 
| Primitive of primitive_exported_type
| Array of primitive_exported_type * int 


type derivation_method = 
  | Size of string  

type exported_parameter =  
| Direct of string * exported_type
| Pointer of string * int * exported_type
| Derived of string * derivation_method

(* 
type bop = 
| Add
| Sub
| Mul
| Div

type uop =
| Neg

type compute_tree =
| Var of string 
| Const of int
| Bop of bop * compute_tree * compute_tree
| Uop of uop * compute_tree


type derivation_method = 
| Size of string
| Compute of compute_tree *)




type exported_function = {
  name: string;
  params: exported_parameter list;
  return_type: exported_type list;
}


type exported_program = {
  functions: exported_function list;
  (* config: (string * string) list;  will need to be define properly*)
  path: string;
}


