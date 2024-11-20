from fastapi import APIRouter

from app.controllers.auth_controller import usuario_login, usuarios_registro


router = APIRouter()

@router.post("/login")
async def login(usuario: dict):
    data=usuario_login(usuario)
    return data

@router.post("/register")
async def register(usuario: dict):
    data=usuarios_registro(usuario)
    return data