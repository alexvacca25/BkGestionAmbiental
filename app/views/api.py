from fastapi import APIRouter

from app.views.usuarios import router as usuarios_router
from app.views.roles import router as roles_router
from app.views.residuos import router as residuos_router

api_router = APIRouter()

api_router.include_router(usuarios_router,prefix="/usuarios")
api_router.include_router(roles_router, prefix="/roles")
api_router.include_router(residuos_router,prefix="/residuos")

