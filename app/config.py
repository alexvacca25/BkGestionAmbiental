import os
from dotenv import load_dotenv

dotenv_path=os.path.join(os.path.dirname(__file__),'.env')

load_dotenv(dotenv_path)

class Setting:
    DB_HOST = os.getenv("DB_HOST")
    DB_USER = os.getenv("DB_USER")
    DB_PASSWORD = os.getenv("DB_PASSWORD")
    DB_NAME = os.getenv("DB_NAME")
    DB_PORT = int(os.getenv("DB_PORT",3306))
    ALLOWED_ORIGINS = os.getenv("ALLOWED_ORIGINS","").split(",")


settings = Setting()