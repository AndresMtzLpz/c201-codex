defmodule Parser do


#------------------PARSER PROGRAM--------------------
  def parse_program(listaTokens) do
	prueba = siguiente(listaTokens)
	listaTokensF = List.delete_at(listaTokens,0)
    funcion = parse_function(prueba,listaTokensF)
	
	case funcion do
      {{:error, error_message}, _listaTokensF} ->
        {:error, error_message}


      {function_node, listaTokensF} ->
        if listaTokensF == [] do
          %Arbol{nodopadre: :program, hijoIzq: function_node}
        else
          {:error,"Error: Hay mas elementos al finalizar la funcion."}
        end
	end
	
  end
#-------------Obtiene el siguiente token ---------- 

  def siguiente(listaTokensF) do
	  primero = Tuple.to_list(hd listaTokensF)
	  prueba = List.first(primero)

	  if prueba == :ident || prueba == :type || prueba == :num do
		
	  	if prueba == :num do
			List.last(primero)
		else
			primero = Tuple.to_list(hd listaTokensF)
	  		List.last(List.last(primero))
		end
		
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
                {{:error, error_message}, listaTokensF} ->
                  {{:error, error_message}, listaTokensF}

               {statement, listaTokensF} ->
				listaTokensF = List.delete_at(listaTokensF,0)
				nextToken = siguiente(listaTokensF)

                  if nextToken == :rBrace do
					listaTokensF = List.delete_at(listaTokensF,0)
                    {%Arbol{nodopadre: :funcion, valor: :main, hijoIzq: statement},listaTokensF}

                  else
                    {:error, "Error, Corchete faltante ", listaTokensF}
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

      case expression do
		  {{:error, error_message}, listaTokensF} ->
          {{:error, error_message}, listaTokensF}

		{expression,listaTokensF} ->

		listaTokensF = List.delete_at(listaTokensF,0)
      	nextToken = siguiente(listaTokensF)
          if nextToken == :semicolon do
            {%Arbol{nodopadre: :statement, valor: :return,hijoIzq: expression},listaTokensF}
          else
            {{:error, "Error: semicolon faltante despues de la constante"}, listaTokensF}
			inspect(listaTokensF)
					
          end
      end
	else
		{{:error, "Error: Falta la Llave return"}, listaTokensF}

    end
  end

#----------------PARSER EXPRESSION--------------------
  def parse_expression(nextToken,listaTokensF) do

	unaries =parse_unaries(nextToken,listaTokensF)

	case unaries do
	{{:error, error_message}, listaTokensF} -> 
	{{:error, error_message}, listaTokensF}

    
	{unaries,listaTokensF}->

		listaTokensF = List.delete_at(listaTokensF,0)
      	nextToken = siguiente(listaTokensF)

		if nextToken != 3 do
				parse_expression(nextToken,listaTokensF)
				listaTokensF = List.delete_at(listaTokensF,0)
				{%Arbol{nodopadre: :unary, valor: nextToken,hijoIzq: unaries},listaTokensF}
				
				

		else   
			{%Arbol{nodopadre: :constant, valor: nextToken,hijoIzq: unaries},listaTokensF}
			##{{:error, "Error: Falta valor de la constante"}, listaTokensF}
				
				

		end
	

	end

  end


#----------------PARSER OUNARY---------------
  def parse_unaries(nextToken,listaTokensF) do

	with  nextToken <- :negation,
		  nextToken <- :logicalNeg
	do  
		{%Arbol{nodopadre: :unary, valor: nextToken},listaTokensF}
		##parse_expression(nextToken,listaTokensF)
	
	else
		_-> {{:error, "Error: Falta unario"}, listaTokensF}
		
	end


##
	##case nextToken do
	##{{:error, error_message}, listaTokensF} -> 
	##{{:error, error_message}, listaTokensF}

  ##  :negation -> 
	##	parse_expression(nextToken,listaTokensF) 
	##	{%Arbol{nodopadre: :unary_negation, valor: nextToken},listaTokensF}
		
	##:logicalNeg ->
	##	parse_expression(nextToken,listaTokensF) 
	##	{%Arbol{nodopadre: :unary_logicalneg, valor: nextToken},listaTokensF}
		
	##:bitWise ->
	##	parse_expression(nextToken,listaTokensF) 
	##	{%Arbol{nodopadre: :unary_complement, valor: nextToken},listaTokensF}
	##_ ->
	##	{{:error, "Error: Falta unario"}, listaTokensF}
	##
	##end


  
end







end
