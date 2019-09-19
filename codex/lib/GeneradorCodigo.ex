defmodule GENERADOR do
def generador_codigo(arbol) do
   	code = post_orden(arbol)
	IO.puts("\nSalida del Generador de Codigo:")
	IO.puts(code)
   end 
   def post_orden(nodo) do
	if(nodo == nil) do
	    nil
	else
	    encode = post_orden(nodo.hijoIzq)
	    asemble(nodo.nodopadre, nodo.valor, encode)	 
	end
    end
    def asemble(:constant, valor, _encode) do
	"$#{valor}"
    end
    def asemble(:return, valor, encode) do
	"""
            movl    #{encode}, %eax
            ret
	""" 
    end
    def asemble(:function, valor, encode) do
        """
            .globl  _main         ## -- Begin function main
        _main:                    ## @main
    	""" <>
      	encode
    end
    def asemble(:program, valor, encode) do
	"""
            .section        __TEXT,__text,regular,pure_instructions
            .p2align        4, 0x90
        """ <>
	encode
    end
end
