""" import unittest
from database.database import User
from datetime import datetime

class DatabaseTest(unittest.TestCase):
    def setUp(self):
        app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///:memory:'
        app.config['TESTING'] = True
        self.app = app.test_client()
        db.create_all()

    def tearDown(self):
        db.session.remove()
        db.drop_all()

    def test_user_creation(self):
        user = User(name="Test User", password="password", role="admin")
        db.session.add(user)
        db.session.commit()

        result = User.query.filter_by(name="Test User").first()
        self.assertIsNotNone(result)
        self.assertEqual(result.name, "Test User")
        self.assertEqual(result.password, "password")
        self.assertEqual(result.role, "admin")

if __name__ == '__main__':
    unittest.main() """