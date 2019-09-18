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
    "
    end

    def t() do
      #IO.puts("\LISTA DE TOKENS \n")
      lista=Lexer.lexear(File.read!("multi_digit.c"))
      IO.inspect(lista)
    end

    def a() do
      IO.puts("\Genera Arbol\n")
      lista=Lexer.lexear(File.read!("multi_digit.c"))
      arbol=Parser.parse_program(lista)
      IO.inspect(arbol)
    end

    def s() do
      IO.puts("\Genera codigo ensamblador\n")
      IO.puts("\Genera Arbol\n")
      lista=Lexer.lexear(File.read!("multi_digit.c"))
      arbol=Parser.parse_program(lista)
      GENERADOR.generate_code(arbol)
    end
    def show_error(num) do
      case num do
       1 -> "Compilador de C de Codex. Escriba -h para la ayuda." #no se puso argumento
       2 -> "Comando(s) no válido. Escriba -h para la ayuda." #mensaje de error
       3 -> "Archivo inválido o no existe en el directorio." #mensaje de archivo inválido
      end
    end
end
