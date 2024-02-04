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
        non_existing_username = 'thisisanonexistentuser'
        users_with_username = User.query.filter_by(username=non_existing_username).first()
        assert users_with_username == None

def test_incorrect_password_in_db():
    with app.app_context():
        username='Testing'
        incorrect_password = 'thisisanincorrectpassword'
        user = User.query.filter_by(username=username).first()
        assert check_password_hash(user.password, incorrect_password) == False


# Check for values existing in database
def test_existing_username():
    with app.app_context():
        existing_username = 'Testing'  
        existing_user = User.query.filter_by(username=existing_username).first()
        assert existing_user
       
def test_correct_password():
    with app.app_context():
        username='Testing'
        correct_password = 'testing'
        user = User.query.filter_by(username=username).first()
        password_matched = check_password_hash(user.password, correct_password)
        assert password_matched

# Retrieve values based on column value in database
def test_retrieve_password_by_username():
    with app.app_context():
        existing_username = 'Testing'  
        user = User.query.filter_by(username=existing_username).first()
        retrieved_password = user.password
        assert retrieved_password

def test_retrieve_username_and_password_by_id():
    with app.app_context():
        existing_user_id = 3
        user = User.query.get(existing_user_id)
        retrieved_username = user.username
        assert retrieved_username



# Inserting new values into database
def test_insert_new_user():
    with app.app_context():
        new_username = 'testing5'
        new_password = 'testing5'
        new_user_role = 'user'
        new_user = User(username=new_username, password=new_password, role=new_user_role)
        db.session.add(new_user)
        db.session.commit()
        inserted_user = User.query.filter_by(username=new_username).first()
        assert (inserted_user.username == new_username) and (inserted_user.password == new_password)