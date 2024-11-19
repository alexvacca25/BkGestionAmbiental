from fastapi import APIRouter

from app.controllers.tratamiento_residuos_controller import tratamiento_obtener,tratamiento_crear,tratamiento_actualizar,tratamiento_eliminar

router=APIRouter()

@router.get("/")
async def get_tratamiento():
    data=tratamiento_obtener()
    return data

@router.post("/")
async def create_tratamiento(tratamiento: dict):
    data=tratamiento_crear(tratamiento)
    return data

@router.put("/")
async def update_tratamiento(tratamiento: dict):
    data=tratamiento_actualizar(tratamiento)
    return data

@router.delete("/")
async def delete_tratamiento(tratamiento: dict):
    data=tratamiento_eliminar(tratamiento)
    return data
