open Jasmin.Printer
open Format

open Types


module type Target = sig 

  val export_body : Format.formatter -> 'a -> unit
  val exported_parameter : Format.formatter -> Types.exported_parameter -> unit
  val export_function : Format.formatter -> Types.exported_function -> unit
end


module NoopTarget = struct 

  let export_body fmt _ = ()

  let export_parameter (fmt:Format.formatter) ((id,ty): exported_parameter) : unit = 
    Format.fprintf fmt "Parameter: %s : %s" id (string_of_exported_type ty)

  let export_function (fmt:Format.formatter) (f: exported_function) : unit = 
    Format.fprintf fmt "%s(%a) -> %a" 
    f.name 
    (pp_print_list ~pp_sep:(fun fmt () -> Format.fprintf fmt ", ") export_parameter) f.params 
    (pp_print_list ~pp_sep:(fun fmt () -> Format.fprintf fmt ", ") (fun fmt x -> Format.fprintf fmt "%s" (string_of_exported_type x))) f.return_type
    

end


module TargetBuilder  (Target:Target) = struct 

  let build_program fmt (prog: exported_program) = 
    Format.fprintf fmt "Program: %s\n" prog.config_path;
    List.iter (fun f -> Target.export_function fmt f) prog.functions

end
