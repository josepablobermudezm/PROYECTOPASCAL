program FichT01; 
 
var 
    fichero: text;       (* Un fichero de texto *) 
 
begin 
    assign( fichero, 'DATOS.TXT' );  (* Le asignamos nombre *) 
    rewrite( fichero );              (* Lo creamos *) 
    writeLn( fichero, 'Hola' );      (* Y escribimos *) 
    writeLn( fichero, 'Segunda linea' );
    close( fichero );                (* Finalmente cerramos *) 
end. 