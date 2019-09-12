defmodule Parser do


#------------------PARSER PROGRAM--------------------
  def parse_program(listaTokens) do
	prueba = siguiente(listaTokens)
	listaTokensF = List.delete_at(listaTokens,0)
    funcion = parse_function(prueba,listaTokensF)

	case funcion do
      {function_node, listaTokensF} ->
        if listaTokensF == [] do
          %Arbol{nodopadre: :program, hijoIzq: function_node}
        else
          IO.puts("Error: Hay mas elementos al finalizar la funcion.")
        end
	end
	
  end

  def siguiente(listaTokensF) do
	  primero = Tuple.to_list(hd listaTokensF)
	  prueba = List.first(primero)

	  if prueba == :ident || prueba == :type || prueba == :num do
		primero = Tuple.to_list(hd listaTokensF)
	  	List.last(List.last(primero))
		
	  else
		primero = Tuple.to_list(hd listaTokensF)
	 	List.first(primero)
		
	  end
  end

#------------------PARSER FUNCTION---------------------
  def parse_function(nextToken,listaTokensF) do
  	if nextToken == :intKeyWord do
	  nextToken = siguiente(listaTokensF)

      if nextToken == :mainKeyWord do
	    listaTokensF = List.delete_at(listaTokensF,0)
        nextToken = siguiente(listaTokensF)

        if nextToken == :lParen do
	      listaTokensF = List.delete_at(listaTokensF,0)
          nextToken = siguiente(listaTokensF)

          if nextToken == :rParen do
			listaTokensF = List.delete_at(listaTokensF,0)
            nextToken = siguiente(listaTokensF)

            if nextToken == :lBrace do
			  listaTokensF = List.delete_at(listaTokensF,0)
			  nextToken = siguiente(listaTokensF)
              statement = parse_statement(nextToken,listaTokensF)

              case statement do
               nextToken ->
				listaTokensF = List.delete_at(listaTokensF,0)
				listaTokensF = List.delete_at(listaTokensF,0)
				listaTokensF = List.delete_at(listaTokensF,0)
				nextToken = siguiente(listaTokensF)
                  if nextToken == :rBrace do
					listaTokensF = List.delete_at(listaTokensF,0)
			  		
                    {%Arbol{nodopadre: :funcion, valor: :main, hijoIzq: nextToken},listaTokensF}
					#"Todo Bien"

                  else
                    {:error, "Error, Corchete faltante "}
                  end
              end

            else
              {:error, "Error: corchete faltante"}
            end
          else
            {:error, "Error:  parentesis faltante"}
          end
        else
          {:error, "Error:  parentesis derecho faltante "}
        end
      else
        {:error, "Error: main de la funcion"}
      end
    else
      {:error, "Error, valor de retorno"}
    end
  end

#----------------PARSER STATEMENT--------------------
  def parse_statement(nextToken,listaTokensF) do
    if nextToken == :returnKeyWord do
	  listaTokensF = List.delete_at(listaTokensF,0)
      nextToken = siguiente(listaTokensF)
      expression = parse_expression(nextToken,listaTokensF)

      case nextToken do
		nextToken->
		listaTokensF = List.delete_at(listaTokensF,0)
        nextToken = siguiente(listaTokensF)

          if nextToken == :semicolon do
            {%Arbol{nodopadre: :return, hijoIzq: nextToken},listaTokensF}
					
          end
      end


    end
  end

#----------------PARSER EXPRESSION--------------------
  def parse_expression(nextToken,listaTokensF) do
    case nextToken do
      _-> {%Arbol{nodopadre: :constant, valor: nextToken}, listaTokensF}
		
	end

  end

end
