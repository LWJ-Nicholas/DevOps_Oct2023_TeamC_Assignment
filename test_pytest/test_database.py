###   testing database via Pytests

from website.models import User
from website import db
from main import app
from werkzeug.security import check_password_hash

#   Check if columns exist  in database
def test_database_id_column():
    with app.app_context():
        columns = [column.name for column in User.__table__.columns]
        assert 'id' in columns

def test_database_username_column():
    with app.app_context():
        columns = [column.name for column in User.__table__.columns]
        assert 'username' in columns

def test_database_password_column():
    with app.app_context():
        columns = [column.name for column in User.__table__.columns]
        assert 'password' in columns

# Check for duplicates in database
def test_database_duplicate_usernames():
    with app.app_context():
        distinct_usernames = db.session.query(User.username).distinct().all()
        all_usernames = [username for (username,) in distinct_usernames]
        has_duplicates = len(all_usernames) != len(set(all_usernames))
        assert not has_duplicates

# Check for not existing in database
def test_non_existing_username_in_db():
    with app.app_context():
        non_existing_username = 'nonexistentuser'
        users_with_username = User.query.filter_by(username=non_existing_username).all()
        assert len(users_with_username) == 0

def test_non_existing_password_in_db():
    with app.app_context():
        non_existing_password = 'nonexistentpassword'
        users_with_password = User.query.filter_by(password=non_existing_password).all()
        assert len(users_with_password) == 0


# # Check for values existing in database
# def test_existing_username():
#     with app.app_context():
#         existing_username = 'Hi'  
#         existing_user = User.query.filter_by(username=existing_username).first()
#         assert existing_user is not None
       
# def test_existing_password():
#     with app.app_context():
#         existing_password = 'testing'
#         users_with_password = User.query.filter_by(role='user').all()
#         password_matched = any(check_password_hash(user.password, existing_password) for user in users_with_password)
#         assert password_matched

# # Retrieve values based on column value in database
# def test_retrieve_password_by_username():
#     with app.app_context():
#         existing_username = 'Testing'  
#         user = User.query.filter_by(username=existing_username).first()
#         retrieved_password = user.password if user else None
#         assert retrieved_password is not None

# def test_retrieve_username_and_password_by_id():
#     with app.app_context():
#         existing_user_id = 3
#         user = User.query.get(existing_user_id)
#         retrieved_username = user.username if user else None
#         retrieved_password = user.password if user else None
#         assert retrieved_username is not None
#         assert retrieved_password is not None

