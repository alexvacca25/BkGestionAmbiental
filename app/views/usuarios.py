from fastapi import APIRouter

from app.controllers.usuarios_controller import usuarios_actualizar, usuarios_actualizar_estado, usuarios_crear, usuarios_eliminar, usuarios_obtener

router=APIRouter()

@router.get("/")
async def get_usuarios():
    data=usuarios_obtener()
    return data

@router.post("/")
async def create_usuarios(usuario: dict):
    data=usuarios_crear(usuario)
    return data

@router.put("/")
async def update_usuarios(usuario: dict):
    data=usuarios_actualizar(usuario)
    return data

@router.put("/estado")
async def update_usuarios_estado(usuario: dict):
    data=usuarios_actualizar_estado(usuario)
    return data


@router.delete("/")
async def delete_usuarios(usuario: dict):
    data=usuarios_eliminar(usuario)
    return data

       