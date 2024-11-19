from fastapi import APIRouter

from app.controllers.transporte_controller import transporte_actualizar, transporte_crear, transporte_eliminar, transporte_obtener


router=APIRouter()

@router.get("/")
async def get_transporte():
    data=transporte_obtener()
    return data

@router.post("/")
async def create_transporte(transporte: dict):
    data=transporte_crear(transporte)
    return data

@router.put("/")
async def update_transporte(transporte: dict):
    data=transporte_actualizar(transporte)
    return data

@router.delete("/")
async def delete_transporte(transporte: dict):
    data=transporte_eliminar(transporte)
    return data
    