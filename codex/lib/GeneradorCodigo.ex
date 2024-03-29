defmodule GENERADOR do
  def generate_code(arbol) do
	post_order(arbol)
  end

  def post_order(node) do
	#IO.inspect(node)
    case node do
  	nil ->
        nil

      anode ->
        code_snippet = post_order(anode.hijoIzq)
        emit_code(anode.nodopadre, code_snippet, anode.valor)
    end
  end
def emit_code(:program, code_snippet, _) do
    """
        .section        __TEXT,__text,regular,pure_instructions
        .p2align        4, 0x90
    """ <>
	
      code_snippet
  end

  def emit_code(:funcion, code_snippet, :main) do
    """
        .globl  _main         ## -- Begin function main
    _main:                    ## @main
    """ <>
      code_snippet
	<>
    """
        ret
    """
  end

  def emit_code(:statement, code_snippet, :return) do
    """
        movl    #{code_snippet}, %eax
    """
  end
  
  def emit_code(:unary, code_snippet, :negation) do
    code_snippet 
	<>
    """

        neg    %eax
    """ 
  end

  def emit_code(:unary, code_snippet, :logicalNeg) do
    code_snippet
	<>
    """
        not    %eax
    """
  end
  
  def emit_code(:unary, code_snippet, :bitWise) do
    code_snippet
	<>
    """
        not    %eax
    """
  end

  def emit_code(:constant, _code_snippet, valor) do
    "$#{valor}"
  end
end
