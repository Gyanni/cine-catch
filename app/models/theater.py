from sqlalchemy import Column, BigInteger, String, DateTime, Integer, ForeignKey, text
from geoalchemy2 import Geometry
from app.core.database import Base

class Theater(Base):
    __tablename__ = "theaters"
    id = Column(BigInteger, primary_key=True, index=True)
    brand = Column(String(20), nullable=False)
    location = Column(Geometry("POINT", srid=4326), nullable=False)
    name = Column(String(50), nullable=False)
    address = Column(String(255), nullable=False, server_default=' ')

class Event(Base):
    __tablename__ = "events"
    id = Column(BigInteger, primary_key=True, index=True)
    movie_id = Column(BigInteger, ForeignKey("movies.id"), nullable=False)
    type = Column(String(20), nullable=False, server_default='GOODS')
    title = Column(String(255), nullable=False)
    start_at = Column(DateTime, nullable=False)
    end_at = Column(DateTime, nullable=False)
    view_count = Column(Integer, nullable=True, default=0)
    created_at = Column(DateTime, nullable=True, server_default=text("NOW()"))

class EventLocation(Base):
    __tablename__ = "event_location"
    id = Column(BigInteger, primary_key=True, index=True)
    theater_id = Column(BigInteger, ForeignKey("theaters.id"), nullable=False)
    event_id = Column(BigInteger, ForeignKey("events.id"), nullable=False)
    status = Column(String(20), nullable=False, server_default='Available')
    updated_at = Column(DateTime, nullable=False)

class TheaterSubscription(Base):
    __tablename__ = "theater_subscription"
    id = Column(BigInteger, primary_key=True, index=True)
    user_id = Column(BigInteger, ForeignKey("users.id"), nullable=False)
    theater_id = Column(BigInteger, ForeignKey("theaters.id"), nullable=False)
    created_at = Column(DateTime, nullable=False, server_default=text("NOW()"))