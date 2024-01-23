from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_login import LoginManager
from werkzeug.security import generate_password_hash

db = SQLAlchemy()
DB_NAME = "database.db"


def create_app():
    app = Flask(__name__)
    app.config['SECRET_KEY'] = 'KNO4@33#R3T49124141ararf4'
    app.config['SQLALCHEMY_DATABASE_URI'] = f'sqlite:///{DB_NAME}'
    db.init_app(app)

    from .views import views
    from .auth import auth

    app.register_blueprint(views, url_prefix='/')
    app.register_blueprint(auth, url_prefix='/')

    from .models import User

    with app.app_context():
        db.create_all()

    login_manager = LoginManager()
    login_manager.login_view = 'auth.login'
    login_manager.init_app(app)

    @login_manager.user_loader
    def load_user(id):
        return User.query.get(int(id))

    # create admin account
    with app.app_context():
        if db.session.query(User).filter_by(username='Admin').count() < 1:
            admin = User(username='Admin', password=generate_password_hash('password', method='pbkdf2'), isAdmin=1, isApproved=1, approvedBy='Admin')
            db.session.add(admin)
            db.session.commit()
    
    with app.app_context():
        if db.session.query(User).filter_by(username='User').count() < 1:
            user = User(username='User', password=generate_password_hash('password', method='pbkdf2'), isAdmin=0, isApproved=1, approvedBy='Admin')
            db.session.add(user)
            db.session.commit()

    return app
