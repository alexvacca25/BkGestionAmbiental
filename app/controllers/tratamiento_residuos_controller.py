from typing import Dict
from app.database.database import get_connection
from app.sql.tratamiento_residuos import gestiontr

def tratamiento_obtener():
    conexion=get_connection()
    try:
        with conexion.cursor() as cursor:
            cursor.execute(gestiontr.LISTAR)
            result=cursor.fetchall()
        return result
    finally:
        conexion.close()


def tratamiento_crear(tratamiento: Dict):
    conexion=get_connection()
    print(tratamiento)
    try:
        with conexion.cursor() as cursor:
            cursor.execute(gestiontr.CREAR,(tratamiento['nombre_tratamiento'],tratamiento['descripcion'], tratamiento['responsable']))
            result=cursor.fetchone()
            conexion.commit()
            return result
    finally:
        conexion.close()

def tratamiento_actualizar(tratamiento: Dict):
    conexion=get_connection()
    print(tratamiento)
    try:
        with conexion.cursor() as cursor:
            cursor.execute(gestiontr.ACTUALIZAR,(tratamiento['id_tratamiento'],tratamiento['nombre_tratamiento'],tratamiento['descripcion'], tratamiento['responsable']))
            result=cursor.fetchone()
            conexion.commit()
            return result
    finally:
        conexion.close()
        

def tratamiento_eliminar(tratamiento: Dict):
    conexion=get_connection()
    try:
        with conexion.cursor() as cursor:
            cursor.execute(gestiontr.ELIMINAR,(tratamiento['id_tratamiento']))
            result=cursor.fetchone()
            conexion.commit()
            return result
    finally:
        conexion.close()