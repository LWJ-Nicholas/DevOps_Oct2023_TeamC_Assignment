# content of test_sysexit.py
import pytest
from website.models import User
from website import db
from main import app
from werkzeug.security import generate_password_hash

def f():
    raise SystemExit(1)

def test_mytest():
    with pytest.raises(SystemExit):
        f()