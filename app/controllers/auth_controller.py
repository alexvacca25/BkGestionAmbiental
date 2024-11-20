from typing import Dict
from app.database.database import get_connection
from app.sql.auth_sql import gestionAuth
from app.sql.usuarios import gestionUser
from app.utils.usuarios_utils import get_password, verify_password


def usuario_login(usuario: dict):
    conexion=get_connection()
    try:
        with conexion.cursor() as cursor:
            cursor.execute(gestionAuth.OBTENER_USER_EMAIL,(usuario["email"]))
            result=cursor.fetchone()
            try:
                if result["email"] :
                    print("Encontrado")
                    print(usuario["password"])
                    print(result["password_user"])
                    validar=verify_password(usuario['password'],result['password_user'])
                    print(validar)
                    print("********")
                    if validar:
                        return {"mensaje":"Usuario Logueado", "data": result}
                    else:
                        return {"mensaje":"Contraseña Incorrecta"}
            except:

                    print("No")
        return result
    finally:
        conexion.close()


def usuarios_registro(usuarios: Dict):
    conexion=get_connection()
    try:
        with conexion.cursor() as cursor:
           
            passwd=get_password(usuarios['password'])
  
            cursor.execute(gestionUser.CREAR,('',usuarios['email'],passwd,usuarios['fecha_creacion'],'inactivo','','','',''))
            result=cursor.fetchone()
            conexion.commit()
            return result
    finally:
        conexion.close()