defmodule CODEX do
  @moduledoc """
  Documentation for CODEX.
  """

  @commands %{
      "help" => "Prints this help",
      "a" =>"Another option"
  }


    def help do
      IO.puts("\CODEX --help file_name \n")

      IO.puts("\nThe compiler supports following options:\n")

      @commands
      |> Enum.map(fn {command, description} -> IO.puts("  #{command} - #{description}") end)
    end 

    defp process_args({[help: true], _, _}) do
      help()
    end
  
end