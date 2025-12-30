from sqlalchemy import Column, BigInteger, String, DateTime, text
from geoalchemy2 import Geometry
from app.core.database import Base

class User(Base):
    __tablename__ = "users"

    id = Column(BigInteger, primary_key=True, index=True)
    email = Column(String(255), nullable=False)
    password = Column(String(255), nullable=False)
    nickname = Column(String(255), nullable=False)
    fcm_token = Column(String(255), nullable=True, default=None)
    location = Column(Geometry("POINT", srid=4326), nullable=True)
    role = Column(String(20), nullable=False, server_default="USER") 
    created_at = Column(DateTime, nullable=False, server_default=text("NOW()"))