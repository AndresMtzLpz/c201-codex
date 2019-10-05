defmodule Lexer do

  def lexear(lexico) do
	num_lines = 1
	lexer(lexico,num_lines)
  end

  #Se definen algunos tipos y se esepecifica la devolución de la función
  @type str_token :: {String.t(), tuple}
  @spec lexer(String.t(), integer) :: list

  def lexer(lexico,num_lines) do
	
    # Se crea una lista de keywords
    keywords = keywords()

    #Se definen las expresiones regulares
    ident_re = ~r(^[a-zA-Z]\w*)
    number_re = ~r(^[0-9]+)
    space_re = ~r(^[ \h]+)
    newline_re = ~r(^[\n\\|\r\n])

    cond do
      lexico == "" ->
       []

      # Se empiezan a comparar las cadenas para decidir que son
      Regex.match?(space_re, lexico) ->
        lexer(Regex.replace(space_re, lexico, "", global: false), num_lines)

      Regex.match?(newline_re, lexico) ->
        lexer(Regex.replace(newline_re, lexico, "", global: false), num_lines + 1)

      Regex.match?(number_re, lexico) ->
        num = String.to_integer(List.first(Regex.run(number_re, lexico)))

        [
          {:num, num_lines, num}
          | lexer(Regex.replace(number_re, lexico, "", global: false), num_lines)
        ]

      true ->
        {result, str_token} = containsKeyword(lexico, keywords)

        cond do
        #Se mostrara la llave del token en caso de tener o no
          result ->
            case str_token do
              {str, {a, b}} ->
                [{a, num_lines, [b]} | lexer(String.replace_leading(lexico, str, ""), num_lines)]

              {str, {a}} ->
                [{a, num_lines, []} | lexer(String.replace_leading(lexico, str, ""), num_lines)]
            end

		  # Si no coincide con ninguno se realiza el default (string)

          Regex.match?(ident_re, lexico) ->
            id = List.first(Regex.run(ident_re, lexico, [{:capture, :first}]))
            token = {:string, num_lines, [id]}
            [token | lexer(Regex.replace(ident_re, lexico, "", global: false), num_lines)]

          true ->
            raise "No se puede leer la cadena: #{lexico} en la linea #{num_lines}"
        end
    end
  end


  # Se muestra la representación de los token
  def show_token(token) do
    case token do
      # Numeros
      {:num, a} -> to_string(a)

      # String
      {:string, a} -> a

      # Tipo "int"
      {:type, :intKeyWord} -> "int "

      # Tipo return
      {:ident, :returnKeyWord} -> "return "

	  # Tipo return
      {:ident, :mainKeyWord} -> "main"


      # Syntax de llaves, parentesis y unarios
      {:lBrace} -> "{"
      {:rBrace} -> "}"
      {:lParen} -> "("
      {:rParen} -> ")"
      {:semicolon} -> ";"
      {:negation} -> "-"
      {:logicalNeg} -> "!"
      {:bitWise} -> "~"
    end
  end

  # Regresa lista de los keywords
  @spec keywords() :: [str_token]
  defp keywords() do
    tokens = [
      {:type, :intKeyWord},
      {:ident, :returnKeyWord},
      {:ident, :mainKeyWord},
      {:lBrace},
      {:rBrace},
      {:lParen},
      {:rParen},
      {:semicolon},
      {:negation},
      {:logicalNeg},
      {:bitWise}
    ]

    token_to_map = fn a -> {show_token(a), a} end
    Enum.map(tokens, token_to_map)
  end

  #Detener la lectura de las cadenas
  @spec containsKeyword(String.t(), list) :: {boolean, tuple}

  defp containsKeyword(input, keywords) do
    Enum.reduce_while(keywords, {}, fn {key, val}, _ ->
      if !String.starts_with?(input, key) do
        {:cont, {false, {}}}
      else
        {:halt, {true, {key, val}}}
      end
    end)
  end
end
