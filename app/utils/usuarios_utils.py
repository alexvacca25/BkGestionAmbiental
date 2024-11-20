from datetime import datetime, timedelta
from typing import Optional
import bcrypt
from fastapi import Depends, HTTPException, status
from fastapi.security import OAuth2PasswordBearer

from jose import JWTError,jwt
from app.config import settings
#from passlib.context import CryptContext

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")

#pwd_context=CryptContext(schemes=["sha256_crypt"], deprecated="auto")

def get_password(password: str) -> str:
    # salt = bcrypt.gensalt()
    # hashed_password = bcrypt.hashpw(password, salt)
    return bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt()).decode('utf-8')

 

def verify_password(plain_password: str, hashed_password: str) -> bool:
    return bcrypt.checkpw(plain_password.encode('utf-8'), hashed_password.encode('utf-8'))
# def get_password_2(password: str):
#     return pwd_context.hash(password)

# def verify_password(plain_password,hash_password):
#     return pwd_context.verify(plain_password,hash_password)


def crear_token_acceso(data: dict, expirar: Optional[timedelta]=None):
    codificar=data.copy()
    if expirar:
        expire=datetime.utcnow()+expirar
    else:
        expire=datetime.utcnow()+timedelta(minutes=15)
    print(expire)
    codificar.update({"exp":expire})
    codificar_jwt=jwt.encode(codificar,settings.SECRET_KEY,algorithm=settings.ALGORITHM)
    return codificar_jwt


async def get_current_user(token: str = Depends(oauth2_scheme)):
    credentials_exception = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="No se pudo validar las credenciales",
        headers={"WWW-Authenticate": "Bearer"},
    )
    
    try:
        payload = jwt.decode(token, settings.SECRET_KEY, algorithms=["HS256"])
        username: str = payload.get("sub")
        if username is None:
            raise credentials_exception
    except JWTError:
        raise credentials_exception
    user = username
    if user is None:
        raise credentials_exception
    return user