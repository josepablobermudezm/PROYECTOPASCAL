program Hello;
        Uses crt;
        
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

     repeat until keypressed;
end.