from contextlib import asynccontextmanager
from fastapi import FastAPI
from app.core.database import engine, Base
from app.models import user, movie, theater 

@asynccontextmanager
async def lifespan(app: FastAPI):
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)
    print("DB 테이블 생성 완료")
    
    yield 
    
    print("서버 종료")

app = FastAPI(title="CineCatch", lifespan=lifespan)

@app.get("/")
async def root():
    return {"message": "CineCatch is Running"}