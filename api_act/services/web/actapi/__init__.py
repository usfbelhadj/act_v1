from datetime import timedelta
from flask import Flask, make_response, jsonify
from flask_sqlalchemy import SQLAlchemy
from flask_restful import Api
from flask_migrate import Migrate
from flask_jwt_extended import JWTManager
from flask_cors import CORS
from actapi.Config import DATABASE_URL
app = Flask(__name__)
api = Api(app)
app.config["JWT_ACCESS_TOKEN_EXPIRES"] = timedelta(hours=24)

jwt = JWTManager(app)

CORS(app)
cors = CORS(app, resource={
    r"/*": {
        "origins": "*"

    }
})
app.config['SECRET_KEY'] = 'secret-key-goes-here'
app.config['SQLALCHEMY_DATABASE_URI'] = DATABASE_URL
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['JWT_SECRET_KEY'] = 'acturian'
app.config['CORS_HEADERS'] = 'Content-Type'

db = SQLAlchemy(app)
migrate = Migrate(app, db)

@app.errorhandler(500)
# def special_exception_handler():
#     return make_response(jsonify({'error': "'Database connection failed'"}), 500)


# @app.errorhandler(401)
# def unauthorized(error):
#     return make_response(jsonify({'error': "Unauthorized access"}), 401)


# @app.errorhandler(404)
# def not_found(error):
#     """ 404 Error
#     ---
#     responses:
#       404:
#         description: a resource was not found
#     """
#     return make_response(jsonify({'error': "Not found"}), 404)


# @app.errorhandler(400)
# def bad_request(error):
#     """ 400 Error
#     ---
#     responses:
#       400:
#         description: Bad request
#     """
#     return make_response(jsonify({'error': "Bad request"}), 400)


# @app.errorhandler(405)
# def method_not_allowed(error):
#     """ 405 Error
#     ---
#     responses:
#       405:
#         description: Method not allowed
#     """
#     return make_response(jsonify({'error': "Method not allowed"}), 405)

# @app.errorhandler(403)
# def forbidden(error):
#     """ 403 Error
#     ---
#     responses:
#       403:
#         description: Forbidden
#     """
    
#     return make_response(jsonify({'error': "Forbidden"}), 403)


# @app.errorhandler(404)
# def not_found(error):
#     """ 404 Error
#     ---
#     responses:
#       404:
#         description: a resource was not found
#     """
#     return make_response(jsonify({'error': "Not found"}), 404)


# @app.errorhandler(500)
# def special_exception_handler(error):
#     return make_response(jsonify({'error': "'Database connection failed'"}), 500)


@app.before_request
def first_request():
    db.create_all()




# ADMIN="testadmin"
# PASSWORD="testadmin"
# SimpleUser="testuser"
# password="testuser"

from actapi.routes import Auth, User, Users, UserManager, UserCourse, CourseManager, CourseList, Register,ScoreManage
# app.register_error_handler(500, special_exception_handler)
# app.register_error_handler(401, unauthorized)
# app.register_error_handler(404, not_found)
# app.register_error_handler(400, bad_request)
# app.register_error_handler(405, method_not_allowed)
# app.register_error_handler(403, forbidden)
api.add_resource(Auth, '/api/auth')  # Login need username and password  POST
api.add_resource(Register, '/api/auth/signup')  # Create ADMIN POST
api.add_resource(User, '/api/user') # Get all users need admin token  GET , POST (create user)
api.add_resource(Users, '/api/users/<public_id>') #Get user by public_id need admin token ,DELETE User by public_id need admin token 
api.add_resource(UserManager, '/api/user/current') # Get current user need token , PUT(update password) POST(update user) work both admin and user
api.add_resource(UserCourse, '/api/user/course')  # Get user course need token
api.add_resource(CourseManager, '/api/courses') # POST Enroll user to course need token need also {"courseID": "courseID", "publicID": "publicID"}
api.add_resource(CourseList, '/api/courses/list') # Get all courses need token GET
api.add_resource(ScoreManage, '/api/user/current/course/<course_id>') # Get user score need token GET