from . import db
from flask_login import UserMixin
from sqlalchemy.sql import func

#All User data have to have these attributes
class User(db.Model, UserMixin):
    id = db.Column(db.Integer,primary_key=True)
    username = db.Column(db.String(150),unique=True)
    password = db.Column(db.String(150))
    isAdmin = db.Column(db.Boolean,default=False)