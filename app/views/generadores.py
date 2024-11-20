from fastapi import APIRouter

from app.controllers.generadores_controller import generadores_crear, generadores_actualizar, generadores_eliminar,generadores_obtener

router=APIRouter()

@router.get("/")
async def get_generadores():
    data=generadores_obtener()
    return data

@router.post("/")
async def create_generadores(generadores: dict):
    data=generadores_crear(generadores)
    return data

@router.put("/")
async def update_generadores(generadores: dict):
    data=generadores_actualizar(generadores)
    return data

@router.delete("/")
async def delete_generadores(generadores: dict):
    data=generadores_eliminar(generadores)
    return data