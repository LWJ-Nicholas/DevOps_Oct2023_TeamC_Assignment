from flask_sqlalchemy import SQLAlchemy
from flask import Flask

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///database.db'  # Replace with your database URI
db = SQLAlchemy(app)

class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(50), nullable=False)
    password = db.Column(db.String(50), nullable=False)
    failed_login_attempts = db.Column(db.Integer, default=0)
    role = db.Column(db.String(50), nullable=False)
    date_created = db.Column(db.DateTime, default=db.func.current_timestamp())
    approved_by = db.Column(db.String(50), nullable=True)
    approved = db.Column(db.String(50), nullable=False)

    def __repr__(self):
        return f'<User {self.username}>'

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

    def __repr__(self):
        return f'<Records {self.name}>'

# Create the database tables
db.create_all()

db.session.commit()
