from typing import Dict
from app.database.database import get_connection
from app.sql.usuarios import gestionUser
from app.utils.usuarios_utils import get_password

def usuarios_obtener():
    conexion=get_connection()
    try:
        with conexion.cursor() as cursor:
            cursor.execute(gestionUser.LISTAR)
            result=cursor.fetchall()
        return result
    finally:
        conexion.close()


def usuarios_crear(usuarios: Dict):
    conexion=get_connection()
    try:
        with conexion.cursor() as cursor:
            print(usuarios['password'])
            passwd=get_password(usuarios['password'])
            print(passwd)
            cursor.execute(gestionUser.CREAR,(usuarios['nombre'],usuarios['email'],passwd,usuarios['fecha_creacion'],usuarios['estado'],usuarios['foto_url'],usuarios['telefono'],usuarios['cargo'],usuarios['profesion']))
            result=cursor.fetchone()
            conexion.commit()
            return result
    finally:
        conexion.close()

def usuarios_actualizar(usuarios: Dict):
    conexion=get_connection()
    try:
        with conexion.cursor() as cursor:
            passwd=get_password(usuarios['password'])
            cursor.execute(gestionUser.ACTUALIZAR,(usuarios['id_usuario'],usuarios['nombre'],usuarios['email'],passwd,usuarios['estado'],usuarios['foto_url'],usuarios['telefono'],usuarios['cargo'],usuarios['profesion']))
            result=cursor.fetchone()
            conexion.commit()
            return result
    finally:
        conexion.close()
        
def usuarios_actualizar_estado(usuarios: Dict):
    conexion=get_connection()
    try:
        with conexion.cursor() as cursor:
          
            cursor.execute(gestionUser.ACTUALIZAR_ESTADO,(usuarios['id_usuario'],usuarios['estado']))
            result=cursor.fetchone()
            conexion.commit()
            return result
    finally:
        conexion.close()



def usuarios_eliminar(usuarios: Dict):
    conexion=get_connection()
    try:
        with conexion.cursor() as cursor:
            cursor.execute(gestionUser.ELIMINAR,(usuarios['id_usuario']))
            result=cursor.fetchone()
            conexion.commit()
            return result
    finally:
        conexion.close()