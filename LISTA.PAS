{
    Unidad dedicada a la lista de palabras que vamos a tener del lenguaje escrito
    por el usuario dicha lista funcionará para almacenar tanto el lenguaje de manera
    original y para traducir al lenguaje intermedio
}
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

var valido :boolean;
{------------------------------------------------------------------}
{Declaracion de procedimientos }
Procedure Inicializar (Var L :TIPO_LISTA);
Procedure AGREGAR(VAR L :TIPO_LISTA; ELE :STRING);
Procedure MostrarLista(Var L :TIPO_LISTA);
Procedure Validarllaves(VAR L :TIPO_LISTA);
procedure EliminarUltimaLLave(VAR L :TIPO_LISTA; Var tipoP :string);
Procedure VerificarFinal(VAR L :TIPO_LISTA);
{------------------------------------------------------------------}

IMPLEMENTATION
Procedure Inicializar (Var L :TIPO_LISTA);
    Begin
    NEW(L);
        L^.SGTE := nil;
        L^.ANT  := nil;
        L^.PALABRA :='';
    END;

{ Procedimiento para agregar palabras al final en la lista}
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
{Procedimiento que se encarga de validar que la cantidad de llaves sea correcta
en el lenguaje escrito por el usuario para su posterior traducción a código intermedio
de tipo pascal
}
procedure Validarllaves(VAR L :TIPO_LISTA);
    var auxiliar : TIPO_LISTA;
        llaveA, llaveC :integer;
        j :integer;
    Begin
        auxiliar := L;
        llaveA := 0;
        llaveC := 0;
        valido := false; { valido es una variable global }
        while auxiliar <> nil do 
            BEGIN
                for j := 1 to Length(auxiliar^.PALABRA) do
                    if (j = 1) then 
                        begin
                            if(auxiliar^.PALABRA[j] = '}') then
                                begin
                                    llaveC := llaveC + 1;
                                end
                            else
                                begin
                                    if (auxiliar^.PALABRA[j] = '{') then
                                    begin
                                        llaveA := llaveA + 1;
                                    end;
                                end;
                        end;
                    if (Length(auxiliar^.PALABRA) > 1) then
                        begin
                            if(auxiliar^.PALABRA[Length(auxiliar^.PALABRA)] = '{') then
                                begin
                                    llaveA := llaveA + 1;
                                end;
                        end;
            auxiliar := auxiliar^.SGTE;
            END;
        if(((llaveA <> 0) AND (llaveC <> 0)) AND (llaveA = llaveC)) then 
            begin
                valido := true;
            end;
    End;

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

{Procedimiento imporatante para eliminar la última llave de la lista 
esto debido a que si no se hacía ibamos a tener un end de más en el código 
en pascal,por lo cual nos daría errores}
procedure EliminarUltimaLLave(VAR L :TIPO_LISTA; Var tipoP :string);
    Var cont, cont2 :integer;
        auxiliar : TIPO_LISTA;
        auxiliar2 : TIPO_LISTA;
        auxiliar3 : TIPO_LISTA;
    Begin
        cont := 0;
        cont2 := 0;
        auxiliar := L;
        auxiliar2 := L;
        while auxiliar <> nil do 
        BEGIN
            if (auxiliar^.PALABRA = tipoP) then
            begin
                cont := cont + 1;
            end;
            auxiliar := auxiliar^.SGTE;
        END;


        auxiliar3 := auxiliar2;
        while auxiliar2 <> nil do 
        BEGIN
            if (auxiliar2^.PALABRA = tipoP) then
            begin
                cont2 := cont2 + 1;
                if(cont2 = cont) then
                begin
                    auxiliar2^.PALABRA := '';
                end;
            end;
            auxiliar2 := auxiliar2^.SGTE;
        END;
        auxiliar2 := auxiliar3;
        L := auxiliar2;
    End;
END.