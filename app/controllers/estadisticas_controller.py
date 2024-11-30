from typing import Dict
from app.database.database import get_connection
from app.sql.estadisticas_sql import gestionEstadisticas

def estadistica_panel():
    conexion=get_connection()
    try:
        with conexion.cursor() as cursor:
            cursor.execute(gestionEstadisticas.PANEL_CONTROL)
            result=cursor.fetchall()
        return result
    finally:
        conexion.close()


def estadistica_panel_grafica():
    conexion=get_connection()
    try:
        with conexion.cursor() as cursor:
            cursor.execute(gestionEstadisticas.PANEL_CONTROL_GRAFICO)
            result=cursor.fetchall()
        return result
    finally:
        conexion.close()