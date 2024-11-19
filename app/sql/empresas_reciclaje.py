

class EmpresasReciclaje:
    LISTAR="CALL Empresas_Reciclaje_Obtener()"
    LISTAR_ID="CALL Empresas_Reciclaje_Obtener_Id(%s)"
    CREAR="CALL Empresas_Reciclaje_Crear(%s,%s,%s,%s,%s)"
    ACTUALIZAR="CALL Empresas_Reciclaje_Actualizar(%s,%s,%s,%s,%s,%s)"
    ELIMINAR="CALL Empresas_Reciclaje_Eliminar(%s)"

erv = EmpresasReciclaje()