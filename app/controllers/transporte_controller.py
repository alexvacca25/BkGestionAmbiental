from typing import Dict
from app.database.database import get_connection
from app.sql.transporte_sql import GET_TRANSPORTE,CREATE_TRANSPORTE,UPDATE_TRANSPORTE,DELETE_TRANSPORTE

def transporte_obtener():
    conexion=get_connection()
    try:
        with conexion.cursor() as cursor:
            cursor.execute(GET_TRANSPORTE)
            result=cursor.fetchall()
        return result
    finally:
        conexion.close()


def transporte_crear(transporte: Dict):
    conexion=get_connection()
    try:
        with conexion.cursor() as cursor:
            cursor.execute(CREATE_TRANSPORTE,(transporte['nombre_empresa'],transporte['tipo'],transporte['placa'],transporte['contacto']))
            result=cursor.fetchone()
            conexion.commit()
            return result
    finally:
        conexion.close()

def transporte_actualizar(transporte: Dict):
    conexion=get_connection()
    try:
        with conexion.cursor() as cursor:
            cursor.execute(UPDATE_TRANSPORTE,(transporte['id_transporte'], transporte['nombre_empresa'],transporte['tipo'],transporte['placa'],transporte['contacto'],))
            result=cursor.fetchone()
            conexion.commit()
            return result
    finally:
        conexion.close()
        

def transporte_eliminar(tranposrte: Dict):
    conexion=get_connection()
    try:
        with conexion.cursor() as cursor:
            cursor.execute(DELETE_TRANSPORTE,(tranposrte['id_transporte']))
            result=cursor.fetchone()
            conexion.commit()
            return result
    finally:
        conexion.close()