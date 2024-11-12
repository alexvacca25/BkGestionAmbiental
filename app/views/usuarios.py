from fastapi import APIRouter

router=APIRouter()

@router.get("/")
async def get_usuarios():
    return {"mensaje":"Listado de Usuarios"}

@router.post("/")
async def create_usuarios(usuario: dict):
    return{"mensaje": "Crear Usuarios","Usuario":usuario}


    