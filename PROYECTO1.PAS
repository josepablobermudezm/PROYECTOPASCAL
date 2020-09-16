program PROYECTO1;
     Uses crt,Lista;
     
     VAR L_PALABRA :TIPO_LISTA;
     L_Cab :TIPO_LISTA;
     PALABRA :STRING[100];
     caso, comentario, isMetodo, isVariableB,isProceso,condicionalB,isInicio, isDeclaraB, isProcesoB, isMetodoB :boolean;
     metodo,metodoDevolver,nombreaux,palabraVariable :string;
     nombrePrograma,beginCount,casoLLaves,isVariable,contMetodo, contDeclaracion, contArhivo: integer;
     programaB, primerBegin : boolean;
     reservada, metAux1, procAux1, agreAux1 , progAux1 : integer;
     VAR ListaLenguaje :TIPO_LISTA;
         ListaAux :TIPO_LISTA;

     function traducir(cadena :string) : string;
          var palabraAux :string;
          flag :boolean; 
          j : integer;
          errorT:text;

     begin

          if((isDeclaraB) and not(isMetodoB) and not(programaB) and not(isProcesoB) and (cadena<>'') and (cadena<>' ') 
          and (Ord(cadena[1]) > 32) and(cadena<>';') ) then
          begin
               if((cadena='}') and (not(caso) or not(condicionalB))) then
               begin
                    write('');
               end
               else
               begin
                    if((cadena<>'METODO') and (cadena<>'PROCESO') and (cadena<>'PROGRAMA') and (cadena<>'DECLARACION') 
                         and (isVariable = 0)  )  then
                              begin 
                                   assign( errorT, 'ERRORS.TXT' );  
                                   append( errorT );
                                   writeLn( errorT, 'La palabra reservada: ', cadena,' no existe');      
                                   close( errorT ); 
                                   isDeclaraB:=false;
                                   {isProcesoB:=false;
                                   isMetodoB:=false;}
                                   writeln('Errores encontrados en la palabra reservada ', cadena);
                                   repeat until keypressed;
                                   HALT;
                    end;
               end;
          end;   
          if((metAux1=2) and (cadena<>'') and (cadena<>' ') 
          and (Ord(cadena[1]) > 32)) then
               begin
                    metAux1:=0;
                    if((cadena<>'METODO') and (cadena<>'PROCESO') and (cadena<>'PROGRAMA'))  then
                         begin 
                              assign( errorT, 'ERRORS.TXT' );  
                              append( errorT );
                              writeLn( errorT, 'La palabra reservada: ', cadena,' no existe');      
                              close( errorT ); 
                              HALT;
                         end;
               end;
          if((procAux1=2) and (cadena<>'') and (cadena<>' ')  
          and (Ord(cadena[1]) > 32)) then
               begin
                    procAux1:=0;
                    if((cadena<>'METODO') and (cadena<>'PROCESO') and (cadena<>'PROGRAMA'))  then
                         begin 
                              assign( errorT, 'ERRORS.TXT' );  
                              append( errorT );
                              writeLn( errorT, 'La palabra reservada: ', cadena,' no existe');      
                              close( errorT ); 
                              HALT;
                         end;
                    
               end;
           {una declaración de variables no puede estar dentro de un begin}
          if ((isInicio) and (cadena = 'DECLARACION')) then
               begin
                    isInicio :=false;
                    assign( errorT, 'ERRORS.TXT' );  
                    append( errorT );
                    writeLn( errorT, 'La palabra reservada: ', cadena,
                    ', se encuentra en un lugar incorrecto');      
                    close( errorT ); 
                    HALT;
               end;  
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
                              isMetodo:=false;{terminamos el metodo}
                              palabraAux :='):'+traducir(metodo)+';';
                              flag :=true;
                              metodo:='';
                              contMetodo:=0;
                         end
                    else if(( (cadena ='ENTERO') OR (cadena ='FLOTANTE')) AND (metodo='')) then
                         begin
                              (*Se guarda en una variable global el tipo de metodo*)
                              metodo := cadena;
                              palabraAux :='';
                              flag :=true;
                              contMetodo:=contMetodo+1;
                         end
                    else if (((cadena ='CARACTER') OR (cadena ='CADENA') OR (cadena ='LOGICO')) AND (metodo=' '))  then
                         begin
                              (*Se guarda en una variable global el tipo de metodo*)
                              metodo := cadena;
                              palabraAux :='';
                              flag :=true;
                              contMetodo:=contMetodo+1;
                         end 
                    else if(( (cadena ='ENTERO') OR (cadena ='FLOTANTE'))) then {Para los parametros de la funcion}
                         begin
                              (*Se guarda en una variable global el tipo de metodo*)
                              isMetodo:=false;
                              palabraAux :=traducir(cadena);
                              isMetodo:=true;
                              flag :=true;
                              
                         end
                    else if (((cadena ='CARACTER') OR (cadena ='CADENA') OR (cadena ='LOGICO')))  then 
                    {Para los parametros de la funcion}
                         begin
                              (*Se guarda en una variable global el tipo de metodo*)
                              isMetodo:=false;
                              palabraAux :=traducir(cadena);
                              isMetodo:=true;
                              flag :=true;
                         end      
                    else 
                         begin
                              contMetodo:=contMetodo+1;
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
          else if (cadena = 'SISTEMA.ESPERAR();') then
               begin
               palabraAux :='repeat until keypressed;';
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
               {si estamos dentro de un caso, y es la primer llave que nos encontramos}
               palabraAux :='';
               casoLLaves := casoLLaves + 1;
               caso := true;
               flag :=true;
               end    
          else if ((cadena = '{') and (caso) and (casoLLaves = 1) ) then
               begin
               {si estamos dentro de un caso, pero en este caso son los begin dentrod de los casos}
               palabraAux :='BEGIN';
               casoLLaves := casoLLaves + 1;
               caso := true;
               flag :=true;
               end  
          else if ((cadena = '}') and (caso) and (casoLLaves = 2) ) then
               begin
               {si estamos dentro de un caso, y es la primer llave final que nos encontramos}
               {son las que cierran dentro de los casos}
               palabraAux :='END;';
               casoLLaves := casoLLaves - 1;
               caso := true;
               flag :=true;
               end 
          else if ((cadena = '}') and (caso) and (casoLLaves = 1) ) then
               begin
               {llave final del case}
               palabraAux :='END;';
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

               if(condicionalB) then
               begin
                    palabraAux := 'then BEGIN';
                    condicionalB := false;
               end 
               else if (beginCount = 0) then
                    palabraAux := ''
               else
                    palabraAux :='BEGIN';
                    isInicio := true;
               flag :=true;
               beginCount := beginCount + 1;
               end
          else if (cadena = '}') then
               begin
                    palabraAux :='END';
                    isInicio := false;
                    flag :=true;
               end  
          else if (cadena = '};') then
               begin
                    palabraAux :='END.';
                    programaB := false;
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
          else if (cadena = '}.SI') then
               begin
                    palabraAux :='END;';
                    flag :=true;
               end
          else if (cadena = '}.METODO') then
               begin
                    metAux1:= 2;
                    palabraAux :='END;';
                    isInicio := false;
                    isMetodoB:=false;
                    flag :=true;
               end
          else if (cadena = '}.PROCESO') then
               begin
               procAux1:= 2;
               palabraAux :='END;';
               isInicio := false;
               flag :=true;
               isProcesoB:=false;
               end
          else if (cadena = 'PROGRAMA') then
               begin
                    programaB := true;
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
                    isVariableB := true;
                    flag :=true;
                    contDeclaracion:= contDeclaracion+1;
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
          else if ((cadena = ')') and (caso) and NOT (isMetodo) and NOT (isProceso)) then
               begin
                    palabraAux :=' of';
                    caso := true;
                    flag :=true;
               end 
          else if ((cadena = ')') and ( not caso) and NOT (isMetodo) and NOT (isProceso)) then
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
                    metAux1:= 1; {par saber que estamos en un método}
                    palabraAux :='function'; 
                    flag :=true;
                    isMetodoB:=true;
                    contMetodo:=contMetodo+1; {lo  usamos para saber en que parte del método estamos }
               end  
          else if(cadena = 'PROCESO') then
               begin
               {Pone la bandera de tipo metodo true, para determinar que existe un metodo}
               palabraAux :='PROCEDURE';
               isProceso := true; {sabemos que estamos en un proceso}
               isProcesoB:=true; {sabemos que estamos en un proceso pero en un auxiliar}
               isMetodoB:=false; {sabemos que NO estamos en un método}
               procAux1:=1; {para saber que entramos a la primera parte del proceso}
               flag :=true;
               end   
          else if(cadena = 'PARA') then
               begin
               {Pone la bandera de tipo metodo true, para determinar que existe un metodo}
               palabraAux :='FOR';
               flag :=true;
               end  
          else if(cadena = 'HASTA') then
               begin
               {Pone la bandera de tipo metodo true, para determinar que existe un metodo}
               palabraAux :='TO';
               flag :=true;
               end 
          else if(cadena = 'FINAL') then
               begin
               {Pone la bandera de tipo metodo true, para determinar que existe un metodo}
               palabraAux :='DO';
               flag :=true;
               end 
          else if(cadena = '}.PARA') then
               begin
               {Pone la bandera de tipo metodo true, para determinar que existe un metodo}
               palabraAux :='END;';
               flag :=true;
               end 
           else if(cadena = '}.MIENTRAS') then
               begin
               {Pone la bandera de tipo metodo true, para determinar que existe un metodo}
               palabraAux :='END;';
               flag :=true;
               end 
          else if(cadena = 'SI') then
               begin
               {Pone la bandera de tipo metodo true, para determinar que existe un metodo}
               palabraAux :='IF';
               condicionalB := true; {para saber que estamos dentro de un IF}
               flag :=true;
               end 
           else if(cadena = 'SINO') then
               begin
               {Pone la bandera de tipo metodo true, para determinar que existe un metodo}
               palabraAux :='ELSE';
               condicionalB := false; {para sabe que terminamos un IF y entramos a un ELSE}
               flag :=true;
               end 
          else if(cadena = 'OO') then
               begin
               {Pone la bandera de tipo metodo true, para determinar que existe un metodo}
               palabraAux :='OR';
               flag :=true;
               end 
          else if(cadena = 'YY') then
               begin
               {Pone la bandera de tipo metodo true, para determinar que existe un metodo}
               palabraAux :='AND';
               flag :=true;
               end 
          else if(cadena = 'MIENTRAS') then
               begin
               {Pone la bandera de tipo metodo true, para determinar que existe un metodo}
               palabraAux :='WHILE';
               flag :=true;
               end 
          else if(cadena = 'DEVOLVER') then
               begin
                    palabraAux := metodoDevolver + ':=';
                    flag :=true;
               end            
          else
               flag :=false;          
          if flag then
               begin
                    {sabemos en que parte del programa vamos leyendo}
                    nombrePrograma := nombrePrograma + 1;
                    {de esta forma sabemos cuando estamos en la iteración del nombre del programa y agregar un ";" }
                    if(isVariableB) then
                         begin
                              isVariable := isVariable + 1;
                         end;
                         {de esta forma sabemos en que segmento de los 3 en una declaración se encuentra la iteración}
                    if (nombrePrograma = 2) then
                         begin
                              {le concatenamos un ; ya que no lo posee el lenguaje cpb}
                              palabraAux := palabraAux + ';';
                              isInicio :=false;
                         end;
                    if (isVariable = 2) then
                         begin
                              {no queremos escribir esta parte para que compile correctamente en pascal}
                              palabraVariable := palabraAux;
                              palabraAux := '';
                         end;
                    if (isProceso) then
                    {si es el nombre del procedimiento le agremos un ";"}
                    begin
                         if (palabraAux = 'BEGIN') then
                         {si es el nombre del procedimiento le agremos un ";"}
                         begin
                              palabraAux := ';' + palabraAux ;
                              isProceso := false;
                         end;
                    end;
                    traducir:=palabraAux;{retornamos la variable con el valor del método}
               end
          else
               begin                 
                    if (isMetodo) then
                         begin
                              if(cadena[1] <> '(') then{para no tomar los parámetros}
                                   begin
                                        metodoDevolver := cadena;{nombre del método}
                                   end 
                         end;
                    if(isVariableB) then
                         begin
                              isVariable := isVariable + 1;
                         end;
                         {de esta forma sabemos en que segmento de los 3 en una declaración se encuentra la iteración}
                    if (isVariable = 3) then
                         begin
                              {le agregamos cierta sintaxis para que funcione en pascal}
                              cadena := cadena + ':' + palabraVariable + ';';
                              isDeclaraB:=true;{para saber que ya no estamos en la declaración}
                         end;
                    if (isVariable = 4) then
                         begin
                              isVariable := 0;{reiniciamos para poder trabajar con la siguiente declarcación}
                              isVariableB := false;
                              palabraVariable:='';
                              cadena := '';
                         end;
                    if(palabraVariable <> '') then
                         begin
                         end;     
                    
                    {if((contDeclaracion=0) and (contMetodo=0) and not(isProceso)) then 
                         begin 
                              writeLn('ERROR EN SINTAXIS');
                         end;}
                    traducir:=cadena;
               end;
     end;

     procedure Compilar;
     var Archiv : text;
     var nombreArc,palabraP : string;
     aux :TIPO_LISTA;

     Begin
          clrscr;
          writeln('                     --------Compilando--------');
          nombreArc := nombreaux+'.pas';
          writeln('                     Nombre Del archivo: ' + nombreArc);
          Validarllaves(ListaAux);{validamos que todas las llaves abran y cierren}
          palabraP := '}';
          EliminarUltimaLLave(ListaAux, palabraP);{eliminamos la última llave
          {VerificarFinal(ListaAux);{verificamos que la última llave sea "llave final y ;"}
          if valido then
               begin
                    Assign(Archiv,nombreArc); {Asigna variable "Archiv" a Pueba.txt}
                    ReWrite(Archiv); {Crea el archivo}
                    palabraP := 'END';
                    EliminarUltimaLLave(ListaLenguaje, palabraP);
                    aux := ListaLenguaje;
                    while aux <> nil do 
                    begin
                         write( Archiv, aux^.PALABRA );
                         aux := aux^.SGTE;
                    end;
                    writeln('                     Archivo Compilado!');
                    close( Archiv );
               end
          else
               begin
                    writeln('                     Errores encontrados en apertura y cierre de sentencias');
               end;
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
     var f,errorT: text;       (* Un fichero de texto *) 
     nombreArchivo:string[30];
     caracter : char;
     parametro,espacio,palabra: string;
     j : integer;
     Begin
          {Creamos el archivo de errores, y le escribimos un título}
          assign( errorT, 'ERRORS.TXT' );  
          rewrite( errorT );              
          writeLn( errorT, 'Lista de errores');      
          close( errorT ); 

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
                    else if (ord(caracter ) = 10 ) then
                         begin
                              espacio :=' ';
                              AGREGAR (ListaLenguaje, espacio);
                         end
                    else
                         begin   
                              contArhivo:=contArhivo+1;     
                              espacio :=' '; 
                              for j := 1 to Length(palabra) do
                                   palabra[j] := UpCase(palabra[j]);

                              if((contArhivo=1) and (palabra <> 'CPB') )then
                                   begin 
                                        writeln('Hay un error en cpb');
                                        assign( errorT, 'ERRORS.TXT' );  
                                        append( errorT );            
                                        writeLn( errorT, 'Error de sintaxis en linea 1:  ', palabra);      
                                        close( errorT ); 
                                        HALT;               
                                   end;  
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
          if((metAux1<>0) or (procAux1<>0)) then {ARREGLAR LUEGO XD}
               begin 
                    assign( errorT, 'ERRORS.TXT' );  
                    append( errorT );
                   {writeLn( errorT, 'Estructuras de metodo o procedimiento no fueron cerradas');}     
                    close( errorT );
               end;
          {else
               begin
                    writeLn('Ejecutado con exito');
               end;     }
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
     beginCount := 0;
     nombrePrograma := 0;
     isProceso := false;
     isVariable := 0;
     isVariableB := false;
     isInicio :=false;
     programaB := false;
     metodo:='';
     palabraVariable:='';
     metodoDevolver:='';
     contArhivo:=0;
     condicionalB := false;
     isDeclaraB:=false;
     isMetodoB:=false;
     menu;
     clrscr;
     INICIALIZAR(L_PALABRA);
     repeat until keypressed;
end.