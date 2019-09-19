defmodule LexerTest do
  use ExUnit.Case
  doctest Lexer

  test "multi_digit" do
    assert Lexer.lexear(File.read!("test/multi_digit.c")) == 
   [
              {:type, 1, [:intKeyWord]},
              {:ident, 1, [:mainKeyWord]},
              {:lParen, 1, []},
              {:rParen, 1, []},
              {:lBrace, 1, []},
              {:ident, 3, [:returnKeyWord]},
              {:num, 3, 100},
              {:semicolon, 3, []},
              {:rBrace, 5, []}
            ]
  end

  test "new lines" do
    assert Lexer.lexear(File.read!("test/newlines.c")) == 
    [
              {:type, 1, [:intKeyWord]},
              {:ident, 3, [:mainKeyWord]},
              {:lParen, 5, []},
              {:rParen, 7, []},
              {:lBrace, 9, []},
              {:ident, 11, [:returnKeyWord]},
              {:num, 13, 0},
              {:semicolon, 15, []},
              {:rBrace, 17, []}
            ]
  end

  test "return 0" do
    assert Lexer.lexear(File.read!("test/valueZero.c")) == 
    [
              {:type, 1, [:intKeyWord]},
              {:ident, 1, [:mainKeyWord]},
              {:lParen, 1, []},
              {:rParen, 1, []},
              {:lBrace, 1, []},
              {:ident, 3, [:returnKeyWord]},
              {:num, 3, 0},
              {:semicolon, 3, []},
              {:rBrace, 5, []}
            ]
  end

  test "return 2" do
    assert Lexer.lexear(File.read!("test/return_2.c")) ==[
              {:type, 3, [:intKeyWord]},
              {:ident, 3, [:mainKeyWord]},
              {:lParen, 3, []},
              {:rParen, 3, []},
              {:lBrace, 3, []},
              {:ident, 5, [:returnKeyWord]},
              {:num, 5, 2},
              {:semicolon, 5, []},
              {:rBrace, 7, []}
            ]
  end

  test "con espacios" do
    assert Lexer.lexear(File.read!("test/wSpaces.c")) == 
    [
              {:type, 1, [:intKeyWord]},
              {:ident, 1, [:mainKeyWord]},
              {:lParen, 1, []},
              {:rParen, 1, []},
              {:lBrace, 1, []},
              {:ident, 1, [:returnKeyWord]},
              {:num, 1, 0},
              {:semicolon, 1, []},
              {:rBrace, 1, []}
            ]
  end

  test "falta parentesis" do
    assert Lexer.lexear(File.read!("test/missingPar.c")) == 
    [
              {:type, 1, [:intKeyWord]},
              {:ident, 1, [:mainKeyWord]},
              {:lParen, 1, []},
              {:lBrace, 1, []},
              {:ident, 3, [:returnKeyWord]},
              {:num, 3, 0},
              {:semicolon, 3, []},
              {:rBrace, 5, []}
            ]
  end
  test "una linea" do
    assert Lexer.lexear(File.read!("test/oneline.c")) == 
    [
              {:type, 1, [:intKeyWord]},
              {:ident, 1, [:mainKeyWord]},
              {:lParen, 1, []},
              {:rParen, 1, []},
              {:lBrace, 1, []},
              {:ident, 1, [:returnKeyWord]},
              {:num, 1, 0},
              {:semicolon, 1, []},
              {:rBrace, 1, []}
            ]
  end


  test "falta valor retorno" do
    assert Lexer.lexear(File.read!("test/missingRetVal.c")) == 
    [
              {:type, 3, [:intKeyWord]},
              {:ident, 3, [:mainKeyWord]},
              {:lParen, 3, []},
              {:rParen, 3, []},
              {:lBrace, 3, []},
              {:ident, 5, [:returnKeyWord]},
              {:semicolon, 5, []},
              {:rBrace, 7, []}
            ]
  end

  test "no brace" do
    assert Lexer.lexear(File.read!("test/noBrace.c")) == 
    [
              {:type, 1, [:intKeyWord]},
              {:ident, 1, [:mainKeyWord]},
              {:lBrace, 1, []},
              {:ident, 3, [:returnKeyWord]},
              {:num, 3, 0},
              {:semicolon, 3, []}
            ]
  end

  test "no semicolon" do
    assert Lexer.lexear(File.read!("test/noSemicolon.c")) == 
    [
              {:type, 1, [:intKeyWord]},
              {:ident, 1, [:mainKeyWord]},
              {:lBrace, 1, []},
              {:ident, 3, [:returnKeyWord]},
              {:num, 3, 0},
              {:rBrace, 5, []}
            ]
  end

  test "sin espacio" do
    assert Lexer.lexear(File.read!("test/nSpace.c")) == 
    [
  {:type, 3, [:intKeyWord]},
  {:ident, 3, [:mainKeyWord]},
  {:lParen, 3, []},
  {:rParen, 3, []},
  {:lBrace, 3, []},
  {:string, 5, ["return0"]},
  {:semicolon, 5, []},
  {:rBrace, 7, []}
  ]

  end

  test "wrong case" do
    assert Lexer.lexear(File.read!("test/WrongCase.c")) == 
    [
              {:type, 1, [:intKeyWord]},
              {:ident, 1, [:mainKeyWord]},
              {:lParen, 1, []},
              {:rParen, 1, []},
              {:lBrace, 1, []},
              {:string, 3, ["RETURN"]},
              {:num, 3, 0},
              {:semicolon, 3, []},
              {:rBrace, 5, []}
            ]
  end

end


