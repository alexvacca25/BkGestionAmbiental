
class GestionTratamiento:
    LISTAR="CALL Tratamiento_Residuos_Obtener()"
    LISTAR_ID="CALL Tratamiento_Residuos_Obtener_Id(%s)"
    CREAR="CALL Tratamiento_Residuos_Crear(%s,%s,%s)"
    ACTUALIZAR="CALL Tratamiento_Residuos_Actualizar(%s,%s,%s,%s)"
    ELIMINAR="CALL Tratamiento_Residuos_Eliminar(%s)"


gestiontr = GestionTratamiento()