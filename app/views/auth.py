from fastapi import APIRouter

from app.controllers.auth_controller import usuario_obtener


router = APIRouter()

@router.post("/login")
async def login(usuario: dict):
    data=usuario_obtener(usuario)
    return data