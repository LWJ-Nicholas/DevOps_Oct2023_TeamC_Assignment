from . import db
from flask_login import UserMixin
from sqlalchemy.sql import func

class User(db.Model, UserMixin):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(50), nullable=False)
    password = db.Column(db.String(50), nullable=False)
    failed_login_attempts = db.Column(db.Integer, default=0)
    role = db.Column(db.String(50), nullable=False)
    date_created = db.Column(db.DateTime, default=db.func.current_timestamp())
    approved_by = db.Column(db.String(50), nullable=True)
    date_approved = db.Column(db.DateTime, nullable=True)


    def __repr__(self):
        return f'<User {self.username}>'