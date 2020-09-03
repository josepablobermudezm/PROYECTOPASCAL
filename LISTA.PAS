UNIT LISTA;
INTERFACE
USES CRT;

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

Procedure Inicializar (Var L :TIPO_LISTA);
Procedure imprima;
PROCEDURE AGREGAR(VAR L :TIPO_LISTA; ELE: TIPO_ARCHIVO);

IMPLEMENTATION

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
    if L = nil then Begin { insetamos el primero}
      L := New_Ele;
    else
      aux := L;
      while L^.SGTE <> nil do Begin
        L := L^SGTE;
      End;
      L^.SGTE := New_Ele;
      New_Ele^.ANT := L;
      L := aux;
    end;
  END;

Procedure imprima;
  Begin
    clrscr;
    gotoxy(15,8);
    writeln('HOLA');
  END;
END.