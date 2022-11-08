from actapi.util import create_user_moodle
from werkzeug.security import generate_password_hash
from actapi import db
import uuid
from datetime import datetime
import json


class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    public_id = db.Column(db.String(50), unique=True)
    moodle_id = db.Column(db.Integer)
    username = db.Column(db.String(50))
    email = db.Column(db.String(50))
    password = db.Column(db.String(80))
    first_name = db.Column(db.String(50))
    last_name = db.Column(db.String(50))
    score = db.Column(db.Integer, default=0)
    admin = db.Column(db.Boolean)
    last_active = db.Column(db.DateTime)
    phone = db.Column(db.String(50))

    def __init__(self, username, password, firstname, lastname, email, token="", admin=False):
        self.public_id = str(uuid.uuid4())
        if admin == True:
            self.admin = True
        else:
            self.admin = False
            res = create_user_moodle(token=token, username=username, password=password,
                                     firstname=firstname, lastname=lastname, email=email)
            if (res != -1):
                self.moodle_id = res
            else:
                raise Exception("Failed to create user at online dauphine!")
        self.username = username
        self.password = generate_password_hash(password, method='sha256')
        self.first_name = firstname
        self.last_name = lastname
        self.email = email
        self.score = 100
        self.last_active = datetime.now()

    def to_dict(self):
        return ({"username": self.username, "email": self.email, "first_name": self.first_name, "last_name": self.last_name, "score": self.score, "last_active": str(self.last_active), "phone": self.phone, "moodle_id": self.moodle_id,"admin":self.admin, "public_id": self.public_id})


    def update_password(self, password):
        self.password = generate_password_hash(password, method='sha256')
        