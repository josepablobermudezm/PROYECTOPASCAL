program PROYECTO1;
     Uses crt, LISTAAUX;

     TYPE
     TIPO_ARCHIVO = RECORD
     PALABRA :STRING[50];
     END;

     TIPO_LISTA = ^TIPO_NODO;
     TIPO_NODO = Record
     PALABRA :TIPO_ARCHIVO;
     SGTE       :TIPO_LISTA;
     ANT        :TIPO_LISTA;
     END;
     
     VAR L_PALABRA :TIPO_LISTA;
     L_Cab :TIPO_LISTA;
     PALABRA :STRING[50];

     procedure Compilar;
     Procedure Inicializar (Var L :TIPO_LISTA);
     Begin
     NEW(L);
     L^.SGTE := nil;
     L^.ANT  := nil;
     L^.PALABRA.PALABRA :='';
     END;

     Procedure AGREGAR (VAR L :TIPO_LISTA; ELE :TIPO_ARCHIVO);
     Var aux : TIPO_LISTA;
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


     procedure Cargar;
     Begin
          writeln('Compilando...');
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
     Var nombre:string[30];
     Var nombreaux:string[30];
     Caracter : char;
     Begin
          writeln('Dime tu nombre: ');
          readln(nombreaux);
          nombre := nombreaux + '.cpb';
          assign(f,nombre);
          reset(f);
          IF IORESULT <> 0 THEN
          begin
               writeLn('El archivo no existe');
          end
          else
          begin
               while not eof( f) do
               begin
                    Read( f, Caracter );    (* Leemos un de caracter en caracter *)
                    writeLn( Caracter );            (* Y la mostramos en pantalla*) 
               end;
               close(f);
          end;
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