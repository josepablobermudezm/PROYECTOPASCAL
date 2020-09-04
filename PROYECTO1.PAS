program PROYECTO1;
     Uses crt;

     TYPE
          TIPO_LISTA = ^TIPO_NODO;
          TIPO_NODO = Record
          PALABRA :STRING[100];
          SGTE       :TIPO_LISTA;
          ANT        :TIPO_LISTA;
     END;

     
     var nombreaux : string;
     VAR L_PALABRA :TIPO_LISTA;
     L_Cab :TIPO_LISTA;
     PALABRA :STRING[100];

     Var Lista :TIPO_LISTA;

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
     if L=NIL THEN { insertamos el primero}
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
     var auxiliar : TIPO_LISTA;
     Begin
          auxiliar := L;
          while auxiliar <> nil do 
          BEGIN
               write(auxiliar^.PALABRA);
               auxiliar := auxiliar^.SGTE;
          END;
     End;
     function traducir(cadena :string): string;
     var palabraAux :string[100];
         flag :boolean;
         {palabraAux :string[100];}
     begin
          {palabraAux := UpCase(cadena);
          for i := 1 to Length(s) do
          s[i] := UpCase(s[i]);}
          if(cadena = 'cpb') then
               begin
               palabraAux :='program';
               flag :=true;
               end
          else 
               if(cadena = 'METODO') then
                    begin
                    palabraAux :='function';
                    flag :=true;
                    end
               else 
                    if (cadena = 'ENTERO') then
                         begin
                         palabraAux :='Integer';
                         flag :=true;
                         end
                    else 
                         if (cadena = 'CADENA') then
                              begin
                              palabraAux :='string';
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
          writeln('Compilando...');
          nombreArc := nombreaux+'.pas';
          writeln(nombreArc);
          Assign(Archiv,nombreArc); {Asigna variable "Archiv" a Pueba.txt}
          ReWrite(Archiv); {Crea el archivo}
          aux := Lista;
          while aux <> nil do 
          BEGIN
               write( Archiv, aux^.PALABRA );
               aux := aux^.SGTE;
          END;
          writeln('ya');
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
     aux :TIPO_LISTA;
     var palabra :string[100];
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
                    if(caracter <> ' ') then
                         begin
                              palabra := palabra + caracter;
                         end
                    else
                         begin
                              AGREGAR (Lista, traducir(palabra));
                              AGREGAR (Lista, ' ');
                              palabra :='';
                         end;
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