from typing import Dict
from app.database.database import get_connection
from app.sql.auth_sql import gestionAuth
from app.utils.usuarios_utils import verify_password


def usuario_obtener(usuario: dict):
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