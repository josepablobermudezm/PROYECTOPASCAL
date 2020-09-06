program PROYECTO1;
     Uses crt,Lista;
     
     var nombreaux : string;
     VAR L_PALABRA :TIPO_LISTA;
     L_Cab :TIPO_LISTA;
     PALABRA :STRING[100];
     caso :boolean;
     casoLLaves :integer;
     comentario :boolean;
     metodo :string;
     isMetodo: boolean; 

     VAR ListaLenguaje :TIPO_LISTA;
         ListaAux :TIPO_LISTA;

     function traducir(cadena :string) : string;
          var palabraAux :string;
          flag :boolean;
          j : integer;
     begin
          
          for j := 1 to Length(cadena) do
          cadena[j] := UpCase(cadena[j]);
          
          if(cadena = 'CPB') then
               begin
               palabraAux :='program';
               flag :=true;
               end
          else if(isMetodo) then 
               begin
                    if (cadena = ')') then
                         begin
                              (*Se llama a traducir para obtener el tipo de metodo que necesita la funcion*)
                              isMetodo:=false;
                              palabraAux :='):'+traducir(metodo)+';';
                              writeLn(palabraAux);
                              flag :=true;
                              metodo:='';
                         end
                    else if(( (cadena ='ENTERO') OR (cadena ='FLOTANTE')) AND (metodo='')) then
                         begin
                              (*Se guarda en una variable global el tipo de metodo*)
                              metodo := cadena;
                              palabraAux :='';
                              flag :=true;
                         end
                    else if (((cadena ='CARACTER') OR (cadena ='CADENA') OR (cadena ='LOGICO')) AND (metodo=' '))  then
                         begin
                              (*Se guarda en una variable global el tipo de metodo*)
                              metodo := cadena;
                              palabraAux :='';
                              flag :=true;
                         end 
                    else if(( (cadena ='ENTERO') OR (cadena ='FLOTANTE'))) then
                         begin
                              (*Se guarda en una variable global el tipo de metodo*)
                              isMetodo:=false;
                              palabraAux :=traducir(cadena);
                              isMetodo:=true;
                              flag :=true;
                         end
                    else if (((cadena ='CARACTER') OR (cadena ='CADENA') OR (cadena ='LOGICO')))  then
                         begin
                              (*Se guarda en una variable global el tipo de metodo*)
                              isMetodo:=false;
                              palabraAux :=traducir(cadena);
                              isMetodo:=true;
                              flag :=true;
                         end      
                    else 
                         begin
                              flag:=false; 
                         end
                                  
               end                      
          else if ((cadena = 'ENTERO')) then
               begin
               palabraAux :='Integer';
               flag :=true;
               end
              
          else if ((cadena = 'CADENA')) then
               begin
               palabraAux :='string';
               flag :=true;
               end
          else if ((cadena = 'LOGICO') ) then
               begin
               palabraAux :='boolean';
               flag :=true;
               end     
          else if ((cadena = 'FLOTANTE')) then
               begin
               palabraAux :='real';
               flag :=true;
               end
          else if ((cadena = 'CARACTER')) then
               begin
               palabraAux :='char';
               flag :=true;
               end 
          else if (cadena = 'PROCEDIMIENTO') then
               begin
               palabraAux :='procedure';
               flag :=true;
               end  
          else if (cadena = 'SISTEMA.ESPERAR();') then
               begin
               palabraAux :='repeat until key pressed;';
               flag :=true;
               end   
          else if (cadena = 'SISTEMA.LIMPIAR();') then
               begin
               palabraAux :='clrscr;';
               flag :=true;
               end       
          else if (cadena = 'SISTEMA.OBTENER') then
               begin
               palabraAux :='readLn';
               flag :=true;
               end    
          else if (cadena = 'SISTEMA.MOSTRAR') then
               begin
               palabraAux :='writeLn';
               flag :=true;
               end       
          else if (cadena = 'SISTEMA.LLAMAR.') then
               begin
               palabraAux :=' ';
               flag :=true;
               end 
          else if (cadena = 'REPETIR{') then
               begin
               palabraAux :='repeat';
               flag :=true;
               end   
          else if (cadena = '}HASTA') then
               begin
               palabraAux :='until';
               flag :=true;
               end
          else if ((cadena = '{') and (caso) and (casoLLaves = 0) ) then
               begin
               palabraAux :='';
               casoLLaves := casoLLaves + 1;
               caso := true;
               flag :=true;
               end    
          else if ((cadena = '{') and (caso) and (casoLLaves = 1) ) then
               begin
               palabraAux :='BEGIN';
               casoLLaves := casoLLaves + 1;
               caso := true;
               flag :=true;
               end  
          else if ((cadena = '}') and (caso) and (casoLLaves = 2) ) then
               begin
               palabraAux :='END;';
               casoLLaves := casoLLaves - 1;
               caso := true;
               flag :=true;
               end 
          else if ((cadena = '}') and (caso) and (casoLLaves = 1) ) then
               begin
               palabraAux :='';
               
               casoLLaves := casoLLaves - 1;
               caso := false;
               flag :=true;
               end
          {else if (cadena = 'DEVOLVER') then  Analizar
               begin
               palabraAux :='until';
               flag :=true;
               end }                
          else if (cadena = '{') then
               begin
               palabraAux :='BEGIN';
               flag :=true;
               end
          else if (cadena = '}') then
               begin
               palabraAux :='END';
               flag :=true;
               end  
          else if (cadena = '};') then
               begin
               palabraAux :='END.';
               flag :=true;
               end  
          else if (cadena = '==') then
               begin
               palabraAux :='=';
               flag :=true;
               end            
          else if (cadena = '=') then
               begin
               palabraAux :=':=';
               flag :=true;
               end
          else if (cadena = '=') then
               begin
               palabraAux :=':=';
               flag :=true;
               end
          else if (cadena = '}.METODO') then
               begin
               palabraAux :='END;';
               flag :=true;
               end
               
          else if (cadena = 'PROGRAMA') then
               begin
               palabraAux :='';
               flag :=true;
               end  
          else if (cadena = 'AGREGAR.SISTEMA;') then
               begin
               palabraAux :='Uses crt;';
               flag :=true;
               end    
          else if (cadena = 'DECLARACION') then
               begin
               palabraAux :='var';
               flag :=true;
               end     
          else if (cadena = 'CASO') then
               begin
               palabraAux :='case';
               caso := true;
               flag :=true;
               end
          else if ((cadena = '(') and (caso) ) then
               begin
               palabraAux :='';
               caso := true;
               flag :=true;
               end   
          else if ((cadena = '(') and ( not caso) ) then
               begin
               palabraAux :='(';
               caso := false;
               flag :=true;
               end 
          else if ((cadena = ')') and (caso) and NOT (isMetodo)) then
               begin
               palabraAux :=' of';
               caso := true;
               flag :=true;
               end 
          else if ((cadena = ')') and ( not caso) and NOT (isMetodo)) then
               begin
               palabraAux :=')';
               caso := true;
               flag :=true;
               end   
          else if ((cadena = '!') and ( comentario) ) then
               begin
               palabraAux :='}';
               comentario := false;
               flag :=true;
               end 
          else if ((cadena = '!')) then
               begin
               palabraAux :='{';
               comentario := true;
               flag :=true;
               end 
          else if(cadena = 'METODO') then
               begin
               {Pone la bandera de tipo metodo true, para determinar que existe un metodo}
               isMetodo := true;
               palabraAux :='function';
               flag :=true;
               end            
          else
               flag :=false;          

          
                              
          if flag then
               traducir:=palabraAux
          else
               traducir:=cadena;
     end;

     procedure Compilar;
     var Archiv : text;
     var nombreArc : string;
     aux :TIPO_LISTA;
     Begin
          clrscr;
          Validarllaves(ListaAux);
          if valido then
               begin
                    write('FUNCIONA');
               end
          else
               begin
                    write('NO CUMPLE');
               end;
          
          writeln('                     --------Compilando--------');
          nombreArc := nombreaux+'.pas';
          writeln('                     Nombre Del archivo: ' + nombreArc);
          Assign(Archiv,nombreArc); {Asigna variable "Archiv" a Pueba.txt}
          ReWrite(Archiv); {Crea el archivo}
          aux := ListaLenguaje;
          while aux <> nil do 
          BEGIN
               write( Archiv, aux^.PALABRA );
               aux := aux^.SGTE;
          END;
          writeln('                     Archivo Compilado!');
          close( Archiv );
          writeln(' '); 
          writeln('                     Digite una tecla para continuar...'); 
          repeat until keypressed;
     End;

     function FileExists(nombre: String): boolean;
     var
     f: text;
     begin
     assign(f,nombre);
     reset(f);
     IF IORESULT <> 0 THEN
     begin
          close(f);
          FileExists:=true;
     end
     else
          FileExists:=false;
     end;

     Procedure Cargar;
     var f: text;       (* Un fichero de texto *) 
     Var nombreArchivo:string[30];
     caracter : char;
     var palabra :string;
     var parametro: string;
     var espacio :string;
     Begin
          clrscr;
          writeln('                     --------Cargando Archivo--------');
          write('                     Digite el nombre del archivo: ');
          readln(nombreaux);
          nombreArchivo := nombreaux + '.cpb';
          assign(f,nombreArchivo);
          reset(f);
          Inicializar (ListaLenguaje);
          Inicializar(ListaAux);

          IF IORESULT <> 0 THEN
          begin
               writeLn('                     El archivo no existe');
          end
          else
          begin
               palabra :='';
               writeLn('                     Procesando...');
               while not eof( f) do
               begin
                    
                    Read( f, caracter );    (* Leemos un de caracter en caracter *)
                    
                    if((caracter <> ' ') AND (ord(caracter)<>10)) then
                         begin
                              palabra := palabra + caracter;
                         end
                    else if (ord(caracter ) =10 ) then
                         begin
                              espacio :=' ';
                              AGREGAR (ListaLenguaje, espacio);
                         end
                    else
                         begin   
                              espacio :=' '; 
                              parametro := traducir(palabra);
                              AGREGAR(ListaAux, palabra);
                              AGREGAR(ListaAux, espacio);
                              AGREGAR (ListaLenguaje, parametro);
                              AGREGAR (ListaLenguaje, espacio);
                              palabra :='';
                         end;
                    (*writeLn( Caracter );            (* Y la mostramos en pantalla*) 
               end;
               close(f);
          end;
          writeln('                     Archivo Cargado!'); 
          writeln(' '); 
          writeln('                     Digite una tecla para continuar...'); 
          repeat until keypressed;
     End;

     procedure menu;
     Var i:integer;
     Begin
          repeat
          clrscr;
          writeln('                     --------Menu Principal--------');
		writeln('                     --------1- Cargar Archivo-----');
		writeln('                     --------2- Compilar-----------');
          writeln('                     --------3- Salir--------------');
          writeln('                     ------------------------------');
          writeln(' ');
          write('                     Selecciona una opcion: ');
          readln(i);
          case i of
               1: Cargar;
               2: Compilar;
          End;
          clrscr;
          until(i = 3);
     End;

        function termina:boolean;
        Var j:integer;

        Begin

        End;

begin
     caso := false;
     comentario := false;
     casoLLaves := 0;
     metodo:='';
     menu;
     clrscr;
     INICIALIZAR(L_PALABRA);
     repeat until keypressed;
end.