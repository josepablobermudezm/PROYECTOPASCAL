program Hello;
     Uses crt, LISTA;
     
     VAR L_PALABRA :TIPO_LISTA;
     L_Cab :TIPO_LISTA;
     PALABRA :STRING[50];

     procedure Cargar;
     Begin
          writeln('Cargando');
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

     Procedure Compilar;
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

          

     Procedure AGREGAR (VAR lista : T_NODO;VAR fich :TEXT);
     VAR
     aux,aux2 : T_NODO;
     cad,cad2 : INTEGER;
     Begin
     (*Inicializamos la lista*)
     lista:=NIL;
     (*Abrimos el fichero del que vamos a tomar los datos en modo lectura*)
     RESET(fich);
     (*Vamos a ir leyendo línea a línea hasta el final*)
     WHILE NOT(EOF(fich)) DO
          BEGIN
          READLN(fich,cad);
          NEW(aux);
          aux^.nombre:=COPY(cad,1,POS(',',cad)-2);
          DELETE(cad,1,POS(cad,1,POS(',',cad)));
          (*En este punto añadimos los nuevos nodos a la lista*)
          IF lista=NIL THEN
               BEGIN
                    lista:=aux;
                    aux2:=lista;
               END
          ELSE
               BEGIN
                    aux2^.sig:=aux;
                    aux2:=aux2^.sig;
               END;
          END;
     aux2^.sig:=NIL;
     (*Cerramos el fichero del cual hemos tomado los datos*)
     CLOSE(fich);
     END;


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