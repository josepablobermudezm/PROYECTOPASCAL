program PROYECTO1;
     Uses crt,Lista;
     
     var nombreaux : string;
     VAR L_PALABRA :TIPO_LISTA;
     L_Cab :TIPO_LISTA;
     PALABRA :STRING[100];

     VAR ListaLenguaje :TIPO_LISTA;

     function traducir(cadena :string) : string;
          var palabraAux :string;
         flag :boolean;
         j : integer;
         {palabraAux :string[100];}
     begin
          
          for j := 1 to Length(cadena) do
          cadena[j] := UpCase(cadena[j]);
          
          if(cadena = 'CPB') then
               begin
               palabraAux :='program';
               flag :=true;
               end
          else if(cadena = 'METODO') then
               begin
               palabraAux :='function';
               flag :=true;
               end
          else if (cadena = 'ENTERO') then
               begin
               palabraAux :='Integer';
               flag :=true;
               end
          else if (cadena = 'CADENA') then
               begin
               palabraAux :='string';
               flag :=true;
               end
          else if (cadena = 'LOGICO') then
               begin
               palabraAux :='boolean';
               flag :=true;
               end     
          else if (cadena = 'FLOTANTE') then
               begin
               palabraAux :='real';
               flag :=true;
               end
          else if (cadena = 'CARACTER') then
               begin
               palabraAux :='char';
               flag :=true;
               end
          else if (cadena = 'CARACTER') then
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
     aux :TIPO_LISTA;
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
          aux:=ListaLenguaje;

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
     menu;
     clrscr;
     INICIALIZAR(L_PALABRA);
     repeat until keypressed;
end.