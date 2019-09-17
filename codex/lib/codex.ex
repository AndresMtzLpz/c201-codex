defmodule Principal do
  @moduledoc """
  Documentation for CODEX.
  """
  @commands %{
      "help" => "Ayuda",
      "a" =>"imprime lista tokens",
      "s" => "genera arbol",
      "e" => "genera codigo ensamblador"
  }


    def help do
      IO.puts("\CODEX Ayuda \n")

      IO.puts("\nOpciones del compilador:\n")

      @commands
      |> Enum.map(fn {command, description} -> IO.puts("  #{command} - #{description}") end)
    end 

    def a do
      IO.puts("\LISTA DE TOKENS \n")
      lista=Codex.lexear(File.read!("valueZero.c"))
    end
    def s do
      IO.puts("\Genera Arbol\n")
      lista=Codex.lexear(File.read!("valueZero.c"))
      arbol=Parser.parse_program(lista)
    end

    def e do
      IO.puts("\Genera codigo ensamblador\n")
      IO.puts("\Genera Arbol\n")
      lista=Codex.lexear(File.read!("valueZero.c"))
      arbol=Parser.parse_program(lista)
      GENERADOR.generate_code(arbol)
    end
    defp process_args({[help: true], _, _}) do
      help()
    end
    defp process_args({[a: true], _, _}) do
      a()
    end
     defp process_args({[s: true], _, _}) do
      s()
    end
    defp process_args({[e: true], _, _}) do
      e()
    end
end
