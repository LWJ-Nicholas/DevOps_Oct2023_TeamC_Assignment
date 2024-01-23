from . import db
from flask_login import UserMixin


# All User data have to have these attributes
class User(db.Model, UserMixin):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(150), unique=True)
    password = db.Column(db.String(150))
    failed_login_attempts = db.Column(db.Integer, default=0)
    isAdmin = db.Column(db.Boolean, default=False)
    date_created = db.Column(db.DateTime, default=db.func.current_timestamp())
    isApproved = db.Column(db.Boolean, default=False)
    approvedBy = db.Column(db.String(150), nullable=True)

class Records(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(50), nullable=False)
    title = db.Column(db.String(50), nullable=False)
    number_of_students = db.Column(db.Integer, nullable=False)
    company_name = db.Column(db.String(50), nullable=False)
    academic_year = db.Column(db.DateTime, nullable=True)
    company_poc = db.Column(db.String(50), nullable=False)
    role_of_contact = db.Column(db.Integer, nullable=False)
    project_description = db.Column(db.String(250), nullable=False)
