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
          if (IOResult = 0) then
          begin
               close(f);
               FileExists:=true;
          end
          else
               FileExists:=false;
          end;

        Procedure Compilar;
        var fichero: text;       (* Un fichero de texto *) 
        Var nombre:string[30];
        Var nombreaux:string[30];
        linea: string;      (* La linea que leeremos *)
        Begin
               writeln('Dime tu nombre: ');
               readln(nombreaux);
               nombre := nombreaux + '.cpb';
               if FileExists( nombre ) then
                    assign( fichero, nombre );  (* Le asignamos nombre *) 
                    reset( fichero );                (* Lo abrimos para leer datos *) 
                    while not eof( fichero) do
                    begin
                         readLn( fichero, linea );    (* Leemos una linea *)
                         writeLn( linea );            (* Y la mostramos *) 
                    end;
                    close( fichero );  (* Finalmente cerramos *)       
               else
               Begin
                    writeLn('El fichero no existe!');
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