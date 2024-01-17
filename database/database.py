from flask_sqlalchemy import SQLAlchemy
from flask import Flask, render_template, request, redirect

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///database.db'  # Replace with your database URI
db = SQLAlchemy(app)


class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(50), nullable=False)
    password = db.Column(db.String(50), nullable=False)
    failed_login_attempts = db.Column(db.Integer, default=0)
    role = db.Column(db.String(50), nullable=False)
    date_created = db.Column(db.DateTime, default=db.func.current_timestamp())
    approved_by = db.Column(db.String(50), nullable=True)
    date_approved = db.Column(db.DateTime, nullable=True)

    def __repr__(self):
        return f'<User {self.name}>'


@app.route('/add/user', methods=['GET', 'POST'])
def addUser():
    if request.method == 'POST':
        name = request.form['name']
        password = request.form['password']
        failed_login_attempts = 0
        role = 'user'
        date_approved = None
        approved_by = None

        new_user = User(name=name, password=password, role=role, date_approved=date_approved, approved_by=approved_by, failed_login_attempts=failed_login_attempts)

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
        user.name = request.form['name']
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
    user.approved = True
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


# Create the database tables
db.create_all()
