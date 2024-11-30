from fastapi import APIRouter, Depends

from app.utils.usuarios_utils import get_current_user
from app.views.usuarios import router as usuarios_router
from app.views.roles import router as roles_router
from app.views.residuos import router as residuos_router
from app.views.transporte import router as transpote_router
from app.views.tratamiento_residuos import router as tratamiento_router
from app.views.auth import router as auth_router
from app.views.empresarv import router as empresarv_router
from app.views.generadores import router as generadores_router
from app.views.estadisticas import router as estadisticas_router

api_router = APIRouter()

api_router.include_router(residuos_router,prefix="/residuos")
api_router.include_router(transpote_router, prefix="/transporte")
api_router.include_router(tratamiento_router,prefix="/tratamiento")
api_router.include_router(empresarv_router, prefix="/empresarv")
api_router.include_router(generadores_router, prefix="/generadores")

api_router.include_router(estadisticas_router,prefix="/estadisticas")

api_router.include_router(usuarios_router,prefix="/usuarios")
# api_router.include_router(roles_router, prefix="/roles",dependencies=[Depends(get_current_user)])
api_router.include_router(roles_router, prefix="/roles")
api_router.include_router(auth_router,prefix="/auth")
