GET_USUARIOS="CALL Usuarios_Obtener()"
GET_GET_USUARIOS_ID="CALL Usuarios_Obtener_Id(%s)"
CREATE_USUARIOS="CALL Usuarios_Crear(%s,%s,%s,%s,%s,%s,%s,%s,%s)"
UPDATE_USUARIOS="CALL Usuarios_Actualizar(%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
DELETE_USUARIOS="CALL Usuarios_Eliminar(%s)"



class GestionUser:
    LISTAR="CALL Usuarios_Obtener()"
    LISTAR_ID="CALL Usuarios_Obtener_Id(%s)"
    CREAR="CALL Usuarios_Crear(%s,%s,%s,%s,%s,%s,%s,%s,%s)"
    ACTUALIZAR="CALL Usuarios_Actualizar(%s,%s,%s,%s,%s,%s,%s,%s,%s)"
    ELIMINAR="CALL Usuarios_Eliminar(%s)"


gestionUser = GestionUser()