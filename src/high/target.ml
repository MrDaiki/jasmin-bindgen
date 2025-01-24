open Jasmin 
open Prog
open Format
open Types

module type Target = sig

  val write_derived_variables : Format.formatter -> (string * derivation_method) list -> unit
  val write_function_body : Format.formatter -> exported_function -> unit
  val write_function_argument : Format.formatter -> exported_parameter -> unit
  val write_caller_header :  Format.formatter -> exported_function -> unit
  val write_caller_body : Format.formatter -> exported_function -> unit
  val write_program : Format.formatter -> exported_program -> unit

end


module NoopTarget = struct 
  let write_derived_variables fmt derived = ()
  let write_function_body fmt f = ()
  let write_function_argument fmt (name, etype) = ()
  let write_caller_header fmt f = ()
  let write_caller_body fmt f = ()
  let write_program fmt p = ()
end



    

(* 
module Python : Target = struct
  let convert_primitive_type (pt : Functiontype.primitive_type) = "int"

  let convert_param (fmt : Format.formatter) (param : Functiontype.function_param) =
    match param with
    | Functiontype.Array pt,_,_   -> Format.format fmt "list[%s]" convert_primitive_type pt

  let convert_named_param (fmt : Format.formatter) (param : Functiontype.name_function_param) = 
    let name, param = param in
    Format.format fmt "%s : %a" name conver_param_type param

  let make_function_def name params returntype = 
    Format.asprintf "def %s(%a) -> %a :" name convert_named_param params convert_param returntype
  
  let convert_primitive_type (pt : Functiontype.primitive_type) =
    match pt with 
        | U8  -> "c_ubyte"
        | U16 -> "c_ushort"
        | U32 -> "c_ulong"
        | U64 -> "c_ulonglong"
        | _ -> assert false

    let convert_type (tname,ptype) =
    match ptype with 
    | Array pt,i,b -> 
      let type_name = convert_primitive_type pt in
      Format.asprintf "c_%s = (ctypes.%s * %d) (*%s)" tname typename i tname
    | Primitive pt ->
      let type_name = convert_primitive_type pt in
      Format.asprintf "c_%s = ctypes.%s(%s)" tname type_name tname

    let make_call name params = 
      let interior = List.fold ( function str, elem -> Format.asprintf "%s, %s" str elem) "" (List.map (function (pn,_) -> Format.asprintf "c_%s" pn)) in
      Format.asprintf "loaded_lib.%s(%s)" ftype.name interior

  let convert_function {name; params; returnType} =
    let header = make_function_def name params return_type in 
    let inits = List.map convert_type params in
    let call = make_call name params in
    Format.asprintf "@[%s@.@t%s@.@t%s@.@t%s]@." header %call *)


    

