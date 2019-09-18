defmodule ParserTest do
  use ExUnit.Case
  doctest Parser

  test "Multi_digit" do
    arbol= Lexer.lexear(File.read!("test/multi_digit.c")) 
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
    arbol= Lexer.lexear(File.read!("test/WrongCase.c")) 
    assert Parser.parse_program(arbol) == {:error, "Error: Hay mas elementos al finalizar la funcion."}
:ok
  end
  test "falta parentesis" do
    arbol= Lexer.lexear(File.read!("test/missingPar.c")) 
    assert Parser.parse_program(arbol) ==  {:error, "Error: Hay mas elementos al finalizar la funcion."}
:ok
  end
  test "falta valor retorno" do
    arbol= Lexer.lexear(File.read!("test/missingRetVal.c")) 
    assert Parser.parse_program(arbol) == {:error, "Error: Hay mas elementos al finalizar la funcion."}
:ok
  end
  test "sin espacios" do
    arbol= Lexer.lexear(File.read!("test/nSpace.c")) 
    assert Parser.parse_program(arbol) == {:error, "Error: Hay mas elementos al finalizar la funcion."}
:ok
  end

  test "con lineas" do
    arbol= Lexer.lexear(File.read!("test/newlines.c")) 
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
    arbol= Lexer.lexear(File.read!("test/noBrace.c")) 
    assert Parser.parse_program(arbol) == {:error, "Error: Hay mas elementos al finalizar la funcion."}
  end

  test "no semicolon" do
    arbol= Lexer.lexear(File.read!("test/noSemicolon.c")) 
    assert Parser.parse_program(arbol) == {:error, "Error: Hay mas elementos al finalizar la funcion."}
  end

  test "una linea" do
    arbol= Lexer.lexear(File.read!("test/oneline.c")) 
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
    arbol= Lexer.lexear(File.read!("test/return_2.c")) 
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
    arbol= Lexer.lexear(File.read!("test/valueZero.c")) 
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
    arbol= Lexer.lexear(File.read!("test/wSpaces.c")) 
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
