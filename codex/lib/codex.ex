defmodule CODEX do
  @moduledoc """
  Documentation for CODEX.
  """
    def main (args) do

     case args do
      ["-h"] -> help() |> IO.puts();
      ["-t", path] -> t(path); 
      ["-a", path] -> a(path);
      ["-s", path] -> s(path);
	  ["-c", path] -> c(path);
	  ["-o", path,newPath] -> o(path,newPath);
      _ -> show_error(1) |> IO.puts;
           show_error(1)
    end 
  end
    def help() do
    IO.puts("\CODEX Ayuda")
    IO.puts("\nOpciones del compilador:\n")
    "
    -t [Path]            Muestra en pantalla la lista de tokens.
    -a [Path]            Muestra el Árbol Sintáctico Abstracto.
    -s [Path]            Genera el código fuente del ensamblador (x86).
    -c [Path]            Compila el programa .c genera el ejecutable.
    -o [Path] [NewName]  Compila el programa .c genera el ejecutable con nuevo nombre.

    "
    end

    def t(path) do
      IO.puts("\LISTA DE TOKENS \n")
      Lexer.lexear(File.read!(path))
      |>IO.inspect()
    end

    def a(path) do
      IO.puts("\ARBOL AST\n")
      Lexer.lexear(File.read!(path))
      |>Parser.parse_program()
      |>IO.inspect()
    end

    def s(path) do
      IO.puts("\CODIGO ENSAMBLADOR\n")
      Lexer.lexear(File.read!(path))
      |>Parser.parse_program()
      |>GENERADOR.generate_code()
      |>IO.puts()
	  
    end
	    
	def c(path) do
    IO.puts("Compilando archivo: " <> path)
    File.read!(path)
    |> Lexer.lexear()
    |> Parser.parse_program()
    |> GENERADOR.generate_code()
    |> Linker.generate_binary(path)    
    end
	
	
	def o(path,newPath) do
    IO.puts("Compilando archivo: " <> path)
	IO.puts("Generando archivos con el nuevo nombre: " <> newPath)
    File.read!(path)
    |> Lexer.lexear()
    |> Parser.parse_program()
    |> GENERADOR.generate_code()
    |> Linker.generate_new_binary(path,newPath)    
    end

    def show_error(num) do
      case num do
       1 -> "Compilador de C de Codex. Escriba -h para la ayuda." #no se puso argumento
       2 -> "Comando(s) no válido. Escriba -h para la ayuda." #mensaje de error
       3 -> "Archivo inválido o no existe en el directorio." #mensaje de archivo inválido
      end
    end
end
