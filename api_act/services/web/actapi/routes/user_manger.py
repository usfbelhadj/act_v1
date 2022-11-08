from actapi import db
from flask import request, jsonify, Response, make_response
from flask_jwt_extended import jwt_required, get_jwt_identity, get_jwt
from flask_restful import Resource
from actapi.models.user import User as user_model
from werkzeug.security import generate_password_hash, check_password_hash
from actapi.Config import TOKEN
from actapi.util import update_user_info


class UserManager(Resource):
    @jwt_required()
    def get(self):
        """
        Get Current User
        """
        try:
            current_user = get_jwt_identity()
            user = user_model.query.filter_by(id=current_user).first()
            return make_response(jsonify(user.to_dict()),200)
        except Exception as e:
            return make_response(jsonify({"message": "Error accured during getting current user"}), 405)

    @jwt_required()
    def put(self):
        id = get_jwt_identity()
        user_info = get_jwt()["user"]

        user = user_model.query.filter_by(id=id).first()
        data = request.get_json()
        hashed_password = generate_password_hash(
            data["newPassword"], method='sha256')
        if not user:
            return make_response(jsonify({'message': 'No user found!'}),404)
        if check_password_hash(user.password, data["oldPassword"]) and data["newPassword"] == data["confirmPassword"]:
            if user_info["admin"] == True:
                user.password = hashed_password
                db.session.commit()
                return make_response(jsonify({'message': 'Password updated!'}),200)
            else:

                return make_response(jsonify({'message': 'Password changed!'}),200)
        return Response("'message': 'Error'", status=405)

    @jwt_required()
    def patch(self):
        """    Update User
        """
        id = get_jwt_identity()
        user = user_model.query.filter_by(
            id=id).first()
        try:
            data = request.get_json()
            
            if "firstname" or "lastname" or "email" or "phone1" in list(data.keys()):
                user.first_name = data["firstname"]
                user.last_name = data["lastname"]
                user.email = data["email"]
                user.phone = data["phone1"]
            if not user.admin:
                    check = update_user_info(
                    token=TOKEN, user_id=user.moodle_id, user_info=data)
                    if not check:
                        make_response(jsonify({"message":"moodle update failed"}),401)
            db.session.commit()
        except Exception as e:
            return make_response(jsonify({'message': 'Error accured during update'}), 401   )
        return make_response(jsonify({'message': 'User updated!'}),200)



# class UserPicture(Resource):
#     @jwt_required()
#     def get(self):
#         """Get User Picture
#         """
#         id = get_jwt_identity()
#         user = user_model.query.filter_by(
#             id=id).first()
#         if not user:
#             return jsonify({'message': 'No user found!'})
#         return jsonify({'picture': user.picture})
#     @jwt_required()
#     def post(self):
#         """Update User Picture
#         """
#         id = get_jwt_identity()
#         user = user_model.query.filter_by(
#             id=id).first()
#         if not user:
#             return jsonify({'message': 'No user found!'})
#         user_picture = get_user_picture(token=TOKEN, user_id=user.moodle_id)
#         data = request.get_json()
#         user.picture = data["picture"]
#         db.session.commit()
#         return jsonify({'message': 'Picture updated!'})