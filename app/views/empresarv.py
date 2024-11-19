from fastapi import APIRouter


from app.controllers.empresas_reciclaje_controller import empresarv_crear, empresarv_obtener, empresarv_eliminar,empresarv_actualizar


router=APIRouter()

@router.get("/")
async def get_empresarv():
    data=empresarv_obtener()
    return data

@router.post("/")
async def create_empresarv(empresarv: dict):
    data=empresarv_crear(empresarv)
    return data

@router.put("/")
async def update_empresarv(empresarv: dict):
    data=empresarv_actualizar(empresarv)
    return data

@router.delete("/")
async def delete_empresarv(empresarv: dict):
    data=empresarv_eliminar(empresarv)
    return data
    