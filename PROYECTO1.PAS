program Hello;
        Uses crt;
        Var nombre:string[30];
        edad, estatura :integer;
        peso :real;

        procedure Cargar;
        Begin
             writeln('Cargando');
             repeat until keypressed;
        End;

        Procedure Compilar;
        Begin
             writeln('Compilando');
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