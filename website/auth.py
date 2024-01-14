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
                return redirect(url_for('auth.welcome'))
            else:
                flash('Incorrect password, try again.',category='error')
        else:
            flash('Username does not exist.',category='error')

    return render_template("login.html",user=current_user)

@auth.route('/logout')
@login_required
def logout():
    logout_user()
    flash('Logged out successfully!',category='success')
    return redirect('/')

@auth.route('/create-account',methods=['GET','POST'])
def createAccount():
    if request.method == "POST":
        username = request.form.get('username')
        password = request.form.get('password')

        user = User.query.filter_by(username=username).first()

        if user:
            flash('User already exists',category='error')
        elif len(username) < 2:
            flash('Username must be greater than 2 characters.',category='error')
        elif len(password) < 7:
            flash('Password must be greater than 7 characters.',category='error')
        else:
            new_user = User(username=username, password=generate_password_hash(
                password, method='pbkdf2'))
            db.session.add(new_user)
            db.session.commit()
            login_user(new_user, remember=True)

            flash('Account created!',category='success')

            return redirect(url_for('auth.welcome'))

    return render_template("create-account.html",user=current_user)

@auth.route('/welcome')
@login_required
def welcome():
    return render_template("welcome.html",user=current_user)

# Route for the form page
@auth.route('/form', methods=['GET', 'POST'])
def form():
    if request.method == 'POST':
        # Access form data
        name = request.form['name']
        email = request.form['email']
        message = request.form['message']

        # Do something with the form data (you can process or store it)
        # For example, print the data to the console
        print(f"Name: {name}, Email: {email}, Message: {message}")

        # Return a response (you can redirect or render a template)
        return render_template('success.html', name=name)  # Render a success page with the submitted name

    return render_template('CreateEntry.html')