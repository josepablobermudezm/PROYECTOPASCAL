UNIT LISTA;
INTERFACE
USES CRT;

Type
    TIPO_LISTA = ^TIPO_NODO;
    TIPO_NODO = Record
    PALABRA :STRING[100];
    SGTE       :TIPO_LISTA;
    ANT        :TIPO_LISTA;
END;

Procedure Inicializar (Var L :TIPO_LISTA);
Procedure imprima;
Procedure AGREGAR(VAR L :TIPO_LISTA; ELE :STRING);
Procedure MostrarLista(Var L :TIPO_LISTA);

IMPLEMENTATION
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

Procedure imprima;
  Begin
    clrscr;
    gotoxy(15,8);
    writeln('HOLA');
  END;
END.