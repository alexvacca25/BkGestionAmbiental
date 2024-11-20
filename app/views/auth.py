from fastapi import APIRouter, Depends

from app.controllers.auth_controller import usuario_login, usuarios_registro
from app.utils.usuarios_utils import get_current_user


router = APIRouter()

@router.post("/login")
async def login(usuario: dict):
    data=usuario_login(usuario)
    return data

@router.post("/register")
async def register(usuario: dict):
    data=usuarios_registro(usuario)
    return data

@router.get("/validartoken")
async def validarToken(usuario: dict = Depends(get_current_user)):
    return {"Usuario":usuario}