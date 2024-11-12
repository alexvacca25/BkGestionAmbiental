from fastapi import APIRouter

from app.controllers.residuos_controller import residuos_actualizar, residuos_crear, residuos_eliminar, residuos_obtener

router=APIRouter()

@router.get("/")
async def get_residuos():
    data=residuos_obtener()
    return data

@router.post("/")
async def create_residuo(residuo: dict):
    data=residuos_crear(residuo)
    return data


@router.put("/")
async def update_residuo(residuo: dict):
    data=residuos_actualizar(residuo)
    return data

@router.delete("/")
async def delete_residuo(residuo: dict):
    data=residuos_eliminar(residuo)
    return data