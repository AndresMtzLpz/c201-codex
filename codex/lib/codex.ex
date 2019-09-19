defmodule CODEX do
  @moduledoc """
  Documentation for CODEX.
  """
  @commands %{
      "h" => "Muestra ayuda para la ejecución del compilador",
      "t" =>"Muestra lista tokens",
      "a" => "Genera arbol AST",
      "s" => "Genera el codigo fuente del ensamblador",
      "o" => "Especifica el nombre del ejecutable de nuestro compilador"
  }
    def main (args) do

     case args do
      ["-h"] -> help() |> IO.puts();
      ["-t"] -> t(); 
      ["-a"] -> a();
      ["-s"] -> s();
	  ["-o"] -> o();
      _ -> show_error(1) |> IO.puts;
           show_error(1)
    end 
  end
    def help() do
    IO.puts("\CODEX Ayuda")
    IO.puts("\nOpciones del compilador:\n")
    "
    -t      Muestra en pantalla la lista de tokens.
    -a      Muestra el Árbol Sintáctico Abstracto.
    -s      Genera el código fuente del ensamblador (x86).
	-o		Compila el programa .c genera el ejecutable
    "
    end

    def t() do
      #IO.puts("\LISTA DE TOKENS \n")
      lista=Lexer.lexear(File.read!("test/multi_digit.c"))
      IO.inspect(lista)
    end

    def a() do
      IO.puts("\Genera Arbol\n")
      lista=Lexer.lexear(File.read!("test/multi_digit.c"))
      arbol=Parser.parse_program(lista)
      IO.inspect(arbol)
    end

    def s() do
      IO.puts("\Genera codigo ensamblador\n")
      IO.puts("\Genera Arbol\n")
      lista=Lexer.lexear(File.read!("test/multi_digit.c"))
      arbol=Parser.parse_program(lista)
      IO.inspect(GENERADOR.generate_code(arbol))
	  
    end
	    
	def o() do
	file_path = "test/return_2.c"
    IO.puts("Compiling file: " <> file_path)
    #assembly_path = String.replace_trailing(file_path, ".c", ".s")
    File.read!(file_path)
    |> Lexer.lexear()
    |> Parser.parse_program()
    |> GENERADOR.generate_code()
    |> Linker.generate_binary(file_path)    
    end

    def show_error(num) do
      case num do
       1 -> "Compilador de C de Codex. Escriba -h para la ayuda." #no se puso argumento
       2 -> "Comando(s) no válido. Escriba -h para la ayuda." #mensaje de error
       3 -> "Archivo inválido o no existe en el directorio." #mensaje de archivo inválido
      end
    end
end
