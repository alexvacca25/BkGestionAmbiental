from typing import Dict
from app.database.database import get_connection
from app.sql.generadores_sql import generador


def generadores_obtener():
    conexion=get_connection()
    try:
        with conexion.cursor() as cursor:
            cursor.execute(generador.LISTAR)
            result=cursor.fetchall()
        return result
    finally:
        conexion.close()


def generadores_crear(generadores: Dict):
    conexion=get_connection()
    try:
        with conexion.cursor() as cursor:
            cursor.execute(generador.CREAR,(generadores['nombre_generador'],generadores['tipo_generador'],generadores['ubicacion'],generadores['contacto'],generadores['longitud'],generadores['latitud']))
            result=cursor.fetchone()
            conexion.commit()
            return result
    finally:
        conexion.close()

def generadores_actualizar(generadores: Dict):
    conexion=get_connection()
 
    try:
        with conexion.cursor() as cursor:
            cursor.execute(generador.ACTUALIZAR,(generadores['id_generador'], generadores['nombre_generador'],generadores['tipo_generador'],generadores['ubicacion'],generadores['contacto'],generadores['longitud'],generadores['latitud']))
            result=cursor.fetchone()
            conexion.commit()
            return result
    finally:
        conexion.close()
        

def generadores_eliminar(generadores: Dict):
    conexion=get_connection()
    try:
        with conexion.cursor() as cursor:
            cursor.execute(generador.ELIMINAR,(generadores['id_generador']))
            result=cursor.fetchone()
            conexion.commit()
            return result
    finally:
        conexion.close()