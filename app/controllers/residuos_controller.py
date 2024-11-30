from typing import Dict
from app.database.database import get_connection
from app.sql.residuos_sql import GET_RESIDUOS, CREATE_RESIDUOS, UPDATE_RESIDUOS, DELETE_RESIDUOS


def residuos_obtener():
    conexion=get_connection()
    try:
        with conexion.cursor() as cursor:
            cursor.execute(GET_RESIDUOS)
            result=cursor.fetchall()
        return result
    finally:
        conexion.close()

def residuos_crear(residuo: Dict):
    conexion=get_connection()
    print(residuo)
    try:
        with conexion.cursor() as cursor:
            cursor.execute(CREATE_RESIDUOS,(residuo['nombre_residuo'],residuo['descripcion']))
            result=cursor.fetchone()
            conexion.commit()
            return result
    finally:
        conexion.close()



def residuos_actualizar(residuo: Dict):
    conexion=get_connection()
    try:
        with conexion.cursor() as cursor:
            cursor.execute(UPDATE_RESIDUOS,(residuo['id_residuo'], residuo['nombre_residuo'],residuo['descripcion']))
            result=cursor.fetchone()
            conexion.commit()
            return result
    finally:
        conexion.close()


def residuos_eliminar(residuos: Dict):
    conexion=get_connection()
    try:
        with conexion.cursor() as cursor:
            cursor.execute(DELETE_RESIDUOS,(residuos['id_residuo']))
            result=cursor.fetchone()
            conexion.commit()
            return result
    finally:
        conexion.close()