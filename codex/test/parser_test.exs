defmodule ParserTest do
  use ExUnit.Case
  doctest Parser

  test "Multi_digit" do
    arbol= Lexer.lexear("int main() {
    return 100;
}

") 
    assert Parser.parse_program(arbol) == %Arbol{
              hijoIzq: %Arbol{
                hijoIzq: %Arbol{
                  hijoIzq: %Arbol{
                    hijoIzq: nil,
                    hijoder: nil,
                    nodopadre: :constant,
                    valor: 100
                  },
                  hijoder: nil,
                  nodopadre: :statement,
                  valor: :return
                },
                hijoder: nil,
                nodopadre: :funcion,
                valor: :main
              },
              hijoder: nil,
              nodopadre: :program,
              valor: nil
            }
  end

  test "Wrong Case" do
    arbol= Lexer.lexear("int main() {
    RETURN 0;
}") 
    assert Parser.parse_program(arbol) == {:error, "Error: Falta la Llave return"}
:ok
  end
  test "falta parentesis" do
    arbol= Lexer.lexear("int main( {
    return 0;
}") 
    assert Parser.parse_program(arbol) ==  {:error, "Error: Hay mas elementos al finalizar la funcion."}
:ok
  end
  test "falta valor retorno" do
    arbol= Lexer.lexear("int main() {
    return ;
}") 
    assert Parser.parse_program(arbol) == {:error, "Error: Falta valor de la constante"}
:ok
  end
  test "sin espacios" do
    arbol= Lexer.lexear("int main() {
    return0;
}") 
    assert Parser.parse_program(arbol) == {:error, "Error: Falta la Llave return"}
:ok
  end

  test "con lineas" do
    arbol= Lexer.lexear("int 
main
(   
)
{
return 
0
;
}") 
    assert Parser.parse_program(arbol) == %Arbol{
              hijoIzq: %Arbol{
                hijoIzq: %Arbol{
                  hijoIzq: %Arbol{
                    hijoIzq: nil,
                    hijoder: nil,
                    nodopadre: :constant,
                    valor: 0
                  },
                  hijoder: nil,
                  nodopadre: :statement,
                  valor: :return
                },
                hijoder: nil,
                nodopadre: :funcion,
                valor: :main
              },
              hijoder: nil,
              nodopadre: :program,
              valor: nil
            }
  end
  test "no brace" do
    arbol= Lexer.lexear("int main {
    return 0;") 
    assert Parser.parse_program(arbol) == {:error, "Error: Hay mas elementos al finalizar la funcion."}
  end

  test "no semicolon" do
    arbol= Lexer.lexear("int main {
    return 0
}") 
    assert Parser.parse_program(arbol) == {:error, "Error: Hay mas elementos al finalizar la funcion."}
  end

  test "una linea" do
    arbol= Lexer.lexear("int main(){return 0;}") 
    assert Parser.parse_program(arbol) == %Arbol{
              hijoIzq: %Arbol{
                hijoIzq: %Arbol{
                  hijoIzq: %Arbol{
                    hijoIzq: nil,
                    hijoder: nil,
                    nodopadre: :constant,
                    valor: 0
                  },
                  hijoder: nil,
                  nodopadre: :statement,
                  valor: :return
                },
                hijoder: nil,
                nodopadre: :funcion,
                valor: :main
              },
              hijoder: nil,
              nodopadre: :program,
              valor: nil
            }
  end

  test "return 2" do
    arbol= Lexer.lexear("int main() {
    return 2;
}") 
    assert Parser.parse_program(arbol) == %Arbol{
              hijoIzq: %Arbol{
                hijoIzq: %Arbol{
                  hijoIzq: %Arbol{
                    hijoIzq: nil,
                    hijoder: nil,
                    nodopadre: :constant,
                    valor: 2
                  },
                  hijoder: nil,
                  nodopadre: :statement,
                  valor: :return
                },
                hijoder: nil,
                nodopadre: :funcion,
                valor: :main
              },
              hijoder: nil,
              nodopadre: :program,
              valor: nil
            }
  end
  test "return 0" do
    arbol= Lexer.lexear("int main() {
    return 0;
}") 
    assert Parser.parse_program(arbol) == %Arbol{
              hijoIzq: %Arbol{
                hijoIzq: %Arbol{
                  hijoIzq: %Arbol{
                    hijoIzq: nil,
                    hijoder: nil,
                    nodopadre: :constant,
                    valor: 0
                  },
                  hijoder: nil,
                  nodopadre: :statement,
                  valor: :return
                },
                hijoder: nil,
                nodopadre: :funcion,
                valor: :main
              },
              hijoder: nil,
              nodopadre: :program,
              valor: nil
            }
  end
  test "con espacios" do
    arbol= Lexer.lexear("int   main    (  )  {   return  0 ; }") 
    assert Parser.parse_program(arbol) == %Arbol{
              hijoIzq: %Arbol{
                hijoIzq: %Arbol{
                  hijoIzq: %Arbol{
                    hijoIzq: nil,
                    hijoder: nil,
                    nodopadre: :constant,
                    valor: 0
                  },
                  hijoder: nil,
                  nodopadre: :statement,
                  valor: :return
                },
                hijoder: nil,
                nodopadre: :funcion,
                valor: :main
              },
              hijoder: nil,
              nodopadre: :program,
              valor: nil
            }
  end

end
