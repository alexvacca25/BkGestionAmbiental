from typing import Dict
from app.database.database import get_connection
from app.sql.roles_sql import gestionRol

def roles_obtener():
    conexion=get_connection()
    try:
        with conexion.cursor() as cursor:
            cursor.execute(gestionRol.LISTAR)
            result=cursor.fetchall()
        return result
    finally:
        conexion.close()


def roles_crear(roles: Dict):
    conexion=get_connection()
    try:
        with conexion.cursor() as cursor:
            cursor.execute(gestionRol.CREAR,(roles['nombre_rol'],roles['descripcion']))
            result=cursor.fetchone()
            conexion.commit()
            return result
    finally:
        conexion.close()

def roles_actualizar(roles: Dict):
    conexion=get_connection()
    try:
        with conexion.cursor() as cursor:
            cursor.execute(gestionRol.ACTUALIZAR,(roles['id_rol'], roles['nombre_rol'],roles['descripcion']))
            result=cursor.fetchone()
            conexion.commit()
            return result
    finally:
        conexion.close()
        

def roles_eliminar(roles: Dict):
    conexion=get_connection()
    try:
        with conexion.cursor() as cursor:
            cursor.execute(gestionRol.ELIMINAR,(roles['id_rol']))
            result=cursor.fetchone()
            conexion.commit()
            return result
    finally:
        conexion.close()