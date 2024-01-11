from flask import Blueprint,render_template,request,flash,redirect,url_for
from .models import User
from werkzeug.security import generate_password_hash,check_password_hash
from . import db
from flask_login import login_user,login_required,logout_user,current_user

auth = Blueprint('auth', __name__)

@auth.route('/login', methods=['GET','POST'])
def login():
    if request.method =='POST':
        username = request.form.get('username')
        password = request.form.get('password')

        user = User.query.filter_by(username=username).first()
        if user:
            if check_password_hash(user.password, password):
                flash('Logged in successfully!',category='success')
                login_user(user, remember=True)
                return redirect(url_for('views.home'))
            else:
                flash('Incorrect password, try again.',category='error')
        else:
            flash('Email does not exist.',category='error')

    return render_template("login.html",user=current_user)

@auth.route('/logout')
@login_required
def logout():
    logout_user()
    return redirect(url_for('auth.login'))

@auth.route('/create-account',methods=['GET','POST'])
def createAccount():
    if request.method == "POST":
        username = request.form.get('username')
        password = request.form.get('password')

        user = User.query.filter_by(username=username).first()

        if user:
            flash('Email already exists',category='error')
        elif len(username) < 2:
            flash('Username must be greater than 2 characters.',category='error')
        elif len(password) < 7:
            flash('Password must be greater than 7 characters.',category='error')
        else:
            new_user = User(username=username, password=generate_password_hash(
                password, method='pbkdf2'))
            db.session.add(new_user)
            db.session.commit()
            login_user(user, remember=True)

            flash('Account created!',category='success')

            return redirect(url_for('views.home'))


    return render_template("create-account.html",user=current_user)