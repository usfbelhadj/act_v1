from actapi.util import  enrol_user, get_enrolled_courses,remove_user_enrolment
from flask import request, jsonify, Response, make_response
from flask_jwt_extended import jwt_required, get_jwt_identity, get_jwt
from actapi.Config import TOKEN as token
from flask_restful import Resource
from actapi.models.user import User as user_model
from actapi import db

class UserCourse(Resource):
    @jwt_required()
    def get(self):
        """_summary_: Get all courses for current user

        Returns:
            _type_: _description_
        """
        id = get_jwt_identity()
        moodle_id = get_jwt()["user"]['moodle_id']
        data = get_enrolled_courses(userid=moodle_id, token=token)
        score =sum([round(course['progress'] * 2,2) for course in data])
        user = user_model.query.filter_by(id=id).first()
        user.score = user.score + score
        db.session.add(user)
        db.session.commit()
        return make_response(jsonify({'Courses': data,"score":user.score}),200)

        
        
        


class CourseManager(Resource):
    @jwt_required()
    def post(self):
        """_summary_: Enroll a user to a  
        body : {"courseID": "courseID", "publicID": "publicID"}

        Returns:
            _type_: _description_
        """
        admin = get_jwt()["user"]['admin']
        data = request.get_json()
        if not admin:
            return make_response(jsonify({"message": "Unauthorized"}), 401)
        try:
            course_id = data["courseID"]
            public_id = data["publicID"]
        except:
            return make_response(jsonify({"message": "Bad Request"}), 400)
        user = user_model.query.filter_by(public_id=public_id).first()
        res = enrol_user(token=token, userid=user.moodle_id,
                         courseid=course_id)
        if (res != -1):
            return make_response(jsonify({'message': 'Success!'}),200)
        else:
            return Response("'message': 'Failed!'", status=405)
    @jwt_required()
    def delete(self):
        """
        remove user enrolment
        """
        id = get_jwt_identity()
        user_info = get_jwt()["user"]
        print(user_info['admin'])
        if user_info['admin']:
            data = request.get_json()
            try:
                public_id = data["publicID"]
                course_id = data["courseID"]
            except:
                return make_response(jsonify({"message": "Bad Request"}), 400)
            user = user_model.query.filter_by(public_id=public_id).first()
            if user:
                response = remove_user_enrolment(token=token,userid=user.moodle_id,courseid=course_id)
                if response == False:
                    return make_response(jsonify({'message': 'Failed!'}),405)
                return make_response(jsonify({'message': 'Success!'}),200)
            else:
                return make_response(jsonify({'message': 'User not found!'}),404)
        return make_response(jsonify({"message": "Unauthorized"}), 401)

class ScoreManage(Resource):
    @jwt_required()
    def get(self, course_id):
        id = get_jwt_identity()
        moodle_id = get_jwt()["user"]['moodle_id']
        data = get_enrolled_courses(userid=moodle_id, token=token)
        overall_score = [{"CourseName": course['displayname'],
                          "progress":course["progress"], "id":course['id']}for course in data]
        if course_id == "all":
            return make_response(jsonify({"overall_score": overall_score}),200)
        else:
            for course in overall_score:
                if course["id"] == int(course_id):
                    return make_response(jsonify(course), 200)
            return make_response(jsonify({"message": "Course not found"}), 404)


class CourseList(Resource):
    @jwt_required()
    def get(self):
        """
        get all available courses to enroll
        """
        available_courses = {"courses": [{"name": "Scala",
                                          "id": "78"
                                          },
                                         {
            "name": "SQL",
            "id": "77"
        },             {
            "name": "Python Programing",
            "id": "79"
        },
        ]
        }
        return make_response(jsonify(available_courses), 200)
