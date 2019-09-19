defmodule Linker do
  def generate_binary(assembler, assembly_path) do
	assembly_path = String.replace_trailing(assembly_path, ".c", ".s")
    assembly_file_name = Path.basename(assembly_path)
	IO.inspect(assembly_file_name)
    binary_file_name = Path.basename(assembly_path, ".s")
	IO.inspect(binary_file_name)
    output_dir_name = Path.dirname(assembly_path)
	IO.inspect(output_dir_name)
    assembly_path = output_dir_name <> "/" <> assembly_file_name
	IO.inspect(assembly_path)

    File.write!(assembly_path, assembler)
    System.cmd("gcc", [binary_file_name<>".c", "-o#{binary_file_name}"], cd: output_dir_name)

   #File.rm!(assembly_path)
  end

end
