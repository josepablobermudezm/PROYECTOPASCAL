UNIT LISTA;
INTERFACE
USES CRT;

TYPE
TIPO_ESTUDIANTE = RECORD
  NO_CEDULA :STRING[10];
  NOMBRE    :STRING[30];
  APELLIDO  :STRING[40];
  CARRERA   :STRING[40];
  ESTADO    :STRING[1];
  EDAD      :INTEGER;
END;

TIPO_LISTA = ^TIPO_NODO;
TIPO_NODO = Record
  ESTUDIANTE :TIPO_ESTUDIANTE;
  SGTE       :TIPO_LISTA;
  ANT        :TIPO_LISTA;
END;

CONST CAR_DEF = 'Ingenieria Sistemas';
  Pi =3.14;

Procedure Inicializar (Var L :TIPO_LISTA);
Procedure imprima;
PROCEDURE AGREGAR(VAR L :TIPO_LISTA: ELE: TIPO_ESTUDIANTE);

IMPLEMENTATION

Procedure Inicializar (Var L :TIPO_LISTA);
  Begin
    NEW(L);
    L^.SGTE := nil;
    L^.ANT  := nil;
    L^.ESTUDIANTE.NO_CEDULA :='';
    L^.ESTUDIANTE.NOMBRE :='';
    L^.ESTUDIANTE.APELLIDO :='';
    L^.ESTUDIANTE.CARRERA :='';
    L^.ESTUDIANTE.EDAD :=0;
  END;

Procedure AGREGAR (VAR L :TIPO_LISTA: ELE: TIPO_ESTUDIANTEA);
  Var aux := TIPO_LISTA;
      New_Ele :TIPO_LISTA;
  Begin
    new(New_Ele);
    New_Ele^.SGTE := nil;
    New_Ele^.ANT := nil;
    New_Ele^.ESTUDIANTE := ELE;
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