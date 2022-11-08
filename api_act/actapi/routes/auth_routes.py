from actapi import db
from flask import jsonify, make_response, request,abort
from actapi.models.user import User
from werkzeug.security import generate_password_hash, check_password_hash
from flask_restful import Resource
from flask_jwt_extended import create_access_token
import smtplib
from flask import request, jsonify, Response
from werkzeug.security import generate_password_hash, check_password_hash
from flask_cors import cross_origin
from datetime import datetime


class Auth(Resource):
    def post(self):
        try:
            auth = request.get_json()
        except:
            return make_response(jsonify({"message": "Bad request"}), 400)
        if not auth or not auth['username'] or not auth['password']:
            return  make_response(jsonify({"message": "Bad request missing info"}), 400)
        user = User.query.filter_by(username=auth['username']).first()
        if not user:
            return make_response(jsonify({"message": "User not found"}), 404)
        if check_password_hash(user.password, auth['password']):
            user.last_active = datetime.now()
            try:
                token = create_access_token(identity=user.id, additional_claims={
                                            "user": user.to_dict()})
            except Exception as ex:
                abort(500)
            db.session.commit()
            return make_response(jsonify({'token': token}),201)
        return make_response(jsonify({"message": "Wrong password"}), 401)


class Register(Resource):
    def post(self):
        try:
            data = request.get_json()
        except:
            return make_response(jsonify({"message": "Bad request"}), 400)
        try:
            new_user = User(username=data['username'], email=data['email'], password=data['password'],
                            admin=True, firstname=data['firstname'], lastname=data['lastname'])
            db.session.add(new_user)
            db.session.commit()
        except Exception as e:
            return make_response(jsonify({"message": "Error accured during registration"}), 405)
        return make_response(jsonify({'message': 'registered successfully'}),302)
