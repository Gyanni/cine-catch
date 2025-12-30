from sqlalchemy import Column, BigInteger, String, Date, DateTime, text
from app.core.database import Base

class Movie(Base):
    __tablename__ = "movies"

    id = Column(BigInteger, primary_key=True, index=True)
    title = Column(String(255), nullable=False)
    release_date = Column(Date, nullable=True)
    image = Column(String(512), nullable=True)
    director = Column(String(255), nullable=False)
    genre = Column(String(20), nullable=True)
    created_at = Column(DateTime, nullable=False, server_default=text("NOW()"))
    external_code = Column(String(50), nullable=True)