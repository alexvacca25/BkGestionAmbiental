import bcrypt
#from passlib.context import CryptContext


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


