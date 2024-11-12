from typing import Dict
from app.database.database import get_connection
from app.sql.roles_sql import GET_ROLES,CREATE_ROLES,UPDATE_ROLES,DELETE_ROLES

def roles_obtener():
    conexion=get_connection()
    try:
        with conexion.cursor() as cursor:
            cursor.execute(GET_ROLES)
            result=cursor.fetchall()
        return result
    finally:
        conexion.close()


def roles_crear(roles: Dict):
    conexion=get_connection()
    try:
        with conexion.cursor() as cursor:
            cursor.execute(CREATE_ROLES,(roles['nombre_rol'],roles['descripcion']))
            result=cursor.fetchone()
            conexion.commit()
            return result
    finally:
        conexion.close()

def roles_actualizar(roles: Dict):
    conexion=get_connection()
    try:
        with conexion.cursor() as cursor:
            cursor.execute(UPDATE_ROLES,(roles['id_rol'], roles['nombre_rol'],roles['descripcion']))
            result=cursor.fetchone()
            conexion.commit()
            return result
    finally:
        conexion.close()
        

def roles_eliminar(roles: Dict):
    conexion=get_connection()
    try:
        with conexion.cursor() as cursor:
            cursor.execute(DELETE_ROLES,(roles['id_rol']))
            result=cursor.fetchone()
            conexion.commit()
            return result
    finally:
        conexion.close()