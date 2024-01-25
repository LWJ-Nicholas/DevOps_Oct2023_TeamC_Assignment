# content of test_sysexit.py
import pytest
from website.models import User
from website import db
from main import app
from werkzeug.security import generate_password_hash

def f():
    raise SystemExit(1)

def test_account_management_add_user():
    with app.app_context():
        userArray = User.query.all()
        originalCount = len(userArray)

        new_user = User(username="test", password=generate_password_hash(
            "password", method='pbkdf2'),role='user')
        db.session.add(new_user)
        db.session.commit()
        
        userArray = User.query.all()
        newCount = len(userArray)

        db.session.delete(new_user)
        db.session.commit()

        assert originalCount == newCount-1 
        

def test_mytest():
    with pytest.raises(SystemExit):
        f()