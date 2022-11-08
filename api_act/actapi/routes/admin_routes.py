import base64
from actapi.util import delete_user_moodel, get_user_picture, get_users_info ,password_generator
from actapi import db
from flask import request, jsonify, Response, make_response,abort
from flask_jwt_extended import jwt_required, get_jwt_identity, get_jwt
from actapi.Config import TOKEN as token
from flask_restful import Resource
from actapi.models.user import User as user_model
import smtplib
class User(Resource):
    @jwt_required()
    def get(self):
        """
        return all users    
        admin required
        """
        id = get_jwt_identity()
        admin = get_jwt()
        try:
            if not admin['user']['admin']:
                return make_response(jsonify({"message": "Unauthorized"}), 403)

            users = user_model.query.all()
            img = ""
            for user in users:
                try:
                    if not  user.admin:
                        img = get_users_info(token, user.moodle_id)
                        if img == "" or img == False:
                            img =  "data:image/png;base64," 
                except Exception as e:
                    return make_response(jsonify({"message": "Either the server is overloaded or there is an error in the application moodle"}), 500)
                output = [{"image":img,"phone": user.phone, "public_id": user.public_id, "username": user.username, "email": user.email, "first_name": user.first_name,
                       "last_name": user.last_name, "score": user.score, "last_active": user.last_active, "moodle_id": user.moodle_id}for user in users if user.admin == False]

            return jsonify({'users': output})
        except Exception as e:
            abort(500)

    @jwt_required()
    def post(self):
        """
        Create a new user (student) by admin only
        """
        id = get_jwt_identity()
        admin = get_jwt()["user"]['admin']
        if not admin:
            return make_response(jsonify({"message": "Unauthorized"}), 401)
        data = request.get_json()
        password = password_generator()
        try:
            new_user = user_model(username=data['username'], email=data['email'],
                                  password=password, firstname=data["firstName"], lastname=data["lastName"], token=token)
            db.session.add(new_user)
            db.session.commit()
            message = f"""From: Actuary Admin <from@fromdomain.com>
                
                Subject: Your Password
                Hello {new_user.first_name},
                This is your password {password}
                """
            ser = smtplib.SMTP('smtp.gmail.com', 587)
            ser.ehlo()
            ser.starttls()
            ser.login("usf.belhadj@gmail.com", "g e c d u l i f s o r n w e s f")
            ser.sendmail("usf.belhadj@gmail.com", new_user.email, message)         
        except Exception as e:
            if str(e) == "Failed to create user at online dauphine!":
                return make_response(jsonify({"message": "user name or email already exists"}), 500)
            return make_response(jsonify({'message': 'Failed to create user'}), 405)
        return  make_response(jsonify({'message': f'New user created! password : {password}'}),201)





    






class Users(Resource):
    @jwt_required()
    def get(self, public_id):
        """
        return user by public_id
        admin required
        """
        user_data = {}
        id = get_jwt_identity()
        admin = get_jwt()["user"]['admin']
        if not admin:
            return make_response(jsonify({"message": "Unauthorized"}), 401)

        user = user_model.query.filter_by(public_id=public_id).first()
        if not user:
            return make_response(jsonify({'message': 'No user found!'}),404)
        user_data['image']= get_user_picture(token,user.moodle_id)
        user_data['public_id'] = user.public_id
        user_data['username'] = user.username
        user_data['email'] = user.email
        user_data['first_name'] = user.first_name
        user_data['last_name'] = user.last_name
        user_data['score'] = user.score
        user_data['admin'] = user.admin
        user_data['last_active'] = user.last_active
        user_data['phone'] = user.phone

        return make_response(jsonify({'user': user_data}),200)

    @jwt_required()
    def delete(self, public_id):
        """
        delete user by public_id
        admin required
        TODO : fix response status
        """
        id = get_jwt_identity()
        admin = get_jwt()["user"]['admin']
        if not admin:
            return make_response(jsonify({"message": "Unauthorized"}), 401)
        user = user_model.query.filter_by(public_id=public_id).first()
        if not user:
            return Response("'message': 'Failed to delete user'", status=405)
        res = delete_user_moodel(token=token, userid=user.moodle_id)
        if (res != -1):
            db.session.delete(user)
            db.session.commit()
            return make_response(jsonify({'message': 'User has been deleted!'}),302)
        else:
            return Response("'message': 'Failed to delete user'", status=405)
