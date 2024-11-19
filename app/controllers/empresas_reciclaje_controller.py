from typing import Dict
from app.database.database import get_connection
from app.sql.empresas_reciclaje import erv


def empresarv_obtener():
    conexion=get_connection()
    try:
        with conexion.cursor() as cursor:
            cursor.execute(erv.LISTAR)
            result=cursor.fetchall()
        return result
    finally:
        conexion.close()


def empresarv_crear(empresarv: Dict):
    conexion=get_connection()
    try:
        with conexion.cursor() as cursor:
            cursor.execute(erv.CREAR,(empresarv['nombre'],empresarv['tipo'],empresarv['direccion'],empresarv['telefono'],empresarv['id_departamento']))
            result=cursor.fetchone()
            conexion.commit()
            return result
    finally:
        conexion.close()

def empresarv_actualizar(empresarv: Dict):
    conexion=get_connection()
    print(empresarv)
    try:
        with conexion.cursor() as cursor:
            cursor.execute(erv.ACTUALIZAR,(empresarv['id_erv'], empresarv['nombre'],empresarv['tipo'],empresarv['direccion'],empresarv['telefono'],empresarv['id_departamento']))
            result=cursor.fetchone()
            conexion.commit()
            return result
    finally:
        conexion.close()
        

def empresarv_eliminar(empresarv: Dict):
    conexion=get_connection()
    try:
        with conexion.cursor() as cursor:
            cursor.execute(erv.ELIMINAR,(empresarv['id_erv']))
            result=cursor.fetchone()
            conexion.commit()
            return result
    finally:
        conexion.close()