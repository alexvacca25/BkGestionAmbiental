GET_ROLES="CALL Rol_Obtener()"
GET_ROLES_ID="CALL Rol_Obtener_Id(%s)"
CREATE_ROLES="CALL Rol_Crear(%s,%s)"
UPDATE_ROLES="CALL Rol_Actualizar(%s,%s,%s)"
DELETE_ROLES="CALL Rol_Eliminar(%s)"


class GestionRoles:
    LISTAR="CALL Rol_Obtener()"
    LISTAR_ID="CALL Rol_Obtener_Id(%s)"
    CREAR="CALL Rol_Crear(%s,%s)"
    ACTUALIZAR="CALL Rol_Actualizar(%s,%s,%s)"
    ELIMINAR="CALL Rol_Eliminar(%s)"


gestionRol = GestionRoles()