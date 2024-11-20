from fastapi import APIRouter, Depends

from app.controllers.roles_controller import roles_actualizar, roles_crear, roles_eliminar, roles_obtener
from app.utils.usuarios_utils import get_current_user

router=APIRouter()

@router.get("/")
async def get_roles():
    data=roles_obtener()
    return data

@router.post("/")
async def create_roles(roles: dict):
    data=roles_crear(roles)
    return data

@router.put("/")
async def update_roles(roles: dict):
    data=roles_actualizar(roles)
    return data

@router.delete("/")
async def delete_roles(roles: dict):
    data=roles_eliminar(roles)
    return data
    