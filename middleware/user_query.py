from flask_sqlalchemy import SQLAlchemy
from flask import Flask, render_template, request, redirect
from database.database import User

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///database.db'  # Replace with your database URI
db = SQLAlchemy(app)

@app.route('/add/user', methods=['GET', 'POST'])
def addUser():
    if request.method == 'POST':
        username = request.form['name']
        password = request.form['password']
        failed_login_attempts = 0
        role = 'user'
        approved = 'False'
        approved_by = None

        new_user = User(username=username, password=password, role=role, approved=approved, approved_by=approved_by, failed_login_attempts=failed_login_attempts)

        try:
            db.session.add(new_user)
            db.session.commit()
            return redirect('/')
        except:
            return 'There was an issue adding your user'

    else:
        return render_template('addUser.html')


@app.route('/delete/user/<int:id>')
def deleteUser(id):
    user_to_delete = User.query.get_or_404(id)
    
    try:
        db.session.delete(user_to_delete)
        db.session.commit()
        return redirect('/')
    except:
        return 'There was a problem deleting that user'


@app.route('/update/user/<int:id>', methods=['GET', 'POST'])
def updateUser(id):
    user = User.query.get_or_404(id)

    if request.method == 'POST':
        user.username = request.form['name']
        user.password = request.form['password']

        try:
            db.session.commit()
            return redirect('/')
        except:
            return 'There was an issue updating your user'

    else:
        return render_template('updateUser.html', user=user)


@app.route('/approve/user/<int:id>')
def approveUser(id):
    user = User.query.get_or_404(id)
    user.approved = 'True'
    try:
        db.session.commit()
        return redirect('/')
    except:
        return 'There was an issue approving your user'


@app.route('/assign/admin/<int:id>')
def assignUser(id):

    user = User.query.get_or_404(id)
    user.role = 'admin'
    try:
        db.session.commit()
        return redirect('/')
    except:
        return 'There was an issue assigning your user'


@app.route('/unassign/admin/<int:id>')
def unassignUser(id):
    user = User.query.get_or_404(id)
    user.role = 'user'
    try:
        db.session.commit()
        return redirect('/')
    except:
        return 'There was an issue unassigning your user'
