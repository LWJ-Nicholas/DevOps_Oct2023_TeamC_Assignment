from flask import Blueprint, render_template, request, flash, redirect, url_for
from .models import User, Records
from werkzeug.security import generate_password_hash, check_password_hash
from . import db
from flask_login import login_user, login_required, logout_user, current_user

auth = Blueprint('auth', __name__)


@auth.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form.get('username')
        password = request.form.get('password')

        user = User.query.filter_by(username=username).first()
        account_validity = User.query.filter_by(username=username).first().isApproved

        if user:
            if check_password_hash(user.password, password):
                if account_validity == False:
                    flash('Account not yet approved', category='error')
                    return redirect(url_for('auth.login'))
                else:
                    flash('Logged in successfully!', category='success')
                    login_user(user, remember=True)
                    return redirect(url_for('auth.welcome'))
            else:
                flash('Incorrect username or password', category='error')
        else:
            flash('Incorrect username or password', category='error')

    return render_template("login.html", user=current_user)


@auth.route('/logout')
@login_required
def logout():
    logout_user()
    flash('Logged out successfully!', category='success')
    return redirect('/')


@auth.route('/register', methods=['GET', 'POST'])
def createAccount():
    if request.method == "POST":
        username = request.form.get('username')
        password = request.form.get('password')

        user = User.query.filter_by(username=username).first()

        if user:
            flash('User already exists', category='error')
        elif len(username) < 2:
            flash('Username must be greater than 2 characters.', category='error')
        elif len(password) < 7:
            flash('Password must be greater than 7 characters.', category='error')
        else:
            new_user = User(username=username, password=generate_password_hash(
                password, method='pbkdf2'))
            db.session.add(new_user)
            db.session.commit()

            flash('Account created!', category='success')

            return redirect(url_for('auth.login'))

    return render_template("register.html", user=current_user)

@auth.route('/welcome')
@login_required
def welcome():
    return render_template("welcome.html", user=current_user)

@auth.route('/create-entry', methods=['GET', 'POST'])
def form():
    if request.method == 'POST':
        # Access form data
        title = request.form['title']
        name = request.form['name']
        numofstudents = request.form['numofstudents']
        company = request.form['company']
        year = request.form['year']
        companycontact = request.form['companycontact']
        description = request.form['description']
        staff = request.form['staff']
        student = request.form['student']
        
        if title == '' or name == '' or numofstudents == '' or company == '' or year == '' or companycontact == '' or description == '' or staff == '' or student == '':
            flash('Please fill out all fields', category='error')
            return redirect(url_for('auth.form'))
        else:
            new_entry = Records(title=title, name=name, numofstudents=numofstudents, company=company, year=year, companycontact=companycontact, description=description, staff=staff, student=student)
            db.session.add(new_entry)
            db.session.commit()
            flash('Record created!', category='success')
            # Return a response (you can redirect or render a template)
            return render_template('search-entry.html', name=name)

    return render_template('create-entry.html')

