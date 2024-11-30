from fastapi import APIRouter, Depends

from app.controllers.estadisticas_controller import estadistica_panel, estadistica_panel_grafica

router=APIRouter()

@router.get("/panel")
async def get_panel_control():
    data=estadistica_panel()
    return data

@router.get("/grafico")
async def get_panel_control_grafico():
    data=estadistica_panel_grafica()
    return data