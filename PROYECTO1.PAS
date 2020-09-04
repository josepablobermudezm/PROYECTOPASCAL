program PROYECTO1;
     Uses crt;

     TYPE
          TIPO_LISTA = ^TIPO_NODO;
          TIPO_NODO = Record
          PALABRA :STRING[50];
          SGTE       :TIPO_LISTA;
          ANT        :TIPO_LISTA;
     END;

     
     var nombreaux : string;
     VAR L_PALABRA :TIPO_LISTA;
     L_Cab :TIPO_LISTA;
     PALABRA :STRING[50];

     Procedure Inicializar (Var L :TIPO_LISTA);
     Begin
     NEW(L);
     L^.SGTE := nil;
     L^.ANT  := nil;
     L^.PALABRA :='';
     END;

     Procedure AGREGAR (VAR L :TIPO_LISTA; ELE :STRING);
     Var aux :TIPO_LISTA;
          New_Ele :TIPO_LISTA;
     Begin
     new(New_Ele);
     New_Ele^.SGTE := nil;
     New_Ele^.ANT := nil;
     New_Ele^.PALABRA := ELE;
     if L=NIL THEN { insetamos el primero}
          BEGIN
          L := New_Ele;
          END
     ELSE
          BEGIN
          aux := L;
          while L^.SGTE <> nil do 
          BEGIN
               L := L^.SGTE;
          END;
          L^.SGTE := New_Ele;
          New_Ele^.ANT := L;
          L := aux;
          END;
     END;

     procedure MostrarLista(VAR L :TIPO_LISTA);
     Var aux :TIPO_LISTA;
     Begin
          while L <> nil do 
          BEGIN
               write(L^.PALABRA);
               L := L^.SGTE;
          END;
     End;

     procedure Compilar;
     var Archiv : text;
     var nombreArc : string;
     Begin
          writeln('Compilando...');
          nombreArc := nombreaux+'.pas';
          writeln(nombreArc);
          Assign(Archiv,nombreArc); {Asigna variable "Archiv" a Pueba.txt}
          ReWrite(Archiv); {Crea el archivo}
          writeLn( Archiv, 'Hola' );      (* Y escribimos *) 
          writeLn( Archiv, 'Segunda linea' );
          close( Archiv ); 


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
     Caracter : char;
     Var Lista, aux :TIPO_LISTA;
     Begin
          writeln('Digite el nombre del archivo: ');
          readln(nombreaux);
          nombreArchivo := nombreaux + '.cpb';
          assign(f,nombreArchivo);
          reset(f);
          Inicializar (Lista);
          aux:=Lista;

          IF IORESULT <> 0 THEN
          begin
               writeLn('El archivo no existe');
          end
          else
          begin
               writeLn('Procesando...');
               while not eof( f) do
               begin
                    Read( f, Caracter );    (* Leemos un de caracter en caracter *)
                    AGREGAR (Lista, Caracter);
                    (*writeLn( Caracter );            (* Y la mostramos en pantalla*) 
               end;
               close(f);
          end;
          MostrarLista(Lista);
          repeat until keypressed;
     End;

     procedure menu;
     Var i:integer;
     Begin
          repeat
          clrscr;
          writeln('1. Cargar Archivo');
          writeln('2. Compilar');
          writeln('3. Salir');
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