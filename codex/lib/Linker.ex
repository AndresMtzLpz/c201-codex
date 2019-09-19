ddefmodule Linker do
    def (cod_ensamblad, path) do
      nom_ensamblad = Path.basename(path)
      #basename (path):
          #3Devuelve el último componente de la ruta o la ruta #en sí misma si no contiene ningún separador de #directorio.
    # Se elimina la extensión .s
      bin_name = Path.basename(path, ".s")
      #basename(path, extension):
          #Devuelve el último componente de path con el extension despojado.
          ruta = Path.dirname(path)
          #dirname(path):
        # Devuelve el componente de directorio de path.
    path = "#{ruta} / #{nom_ensamblad}"
    File.write(path,cod_ensamblad)
      ## genera una #File.Errorexcepción si falla.
    System.cmd("gcc",[nom_ensamblad,"-o#{bin_name}"],cd:ruta)
  end
end
