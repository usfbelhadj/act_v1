import string
import random
import requests
import json
from actapi.Config import TOKEN 

def password_generator(size=6, chars=string.ascii_letters + string.digits):
    return ''.join(random.choice(chars) for _ in range(size)) + '0*acT'


def create_user_moodle(token, username, password, firstname, lastname, email):
    funtion = "core_user_create_users"
    try:
        r = requests.post(
            f"https://online-dauphine.com/moodle/webservice/rest/server.php?wstoken={token}&wsfunction={funtion}&moodlewsrestformat=json&users[0][username]={username}&users[0][firstname]={firstname}&users[0][lastname]={lastname}&users[0][email]={email}&users[0][password]={password}")
        print(f"password : {password}")
        id = json.loads(r.text)[0]["id"]
        return id
    except Exception as e:
        print(e)
        return -1


def get_enrolled_courses(token, userid):
    funtion = "core_enrol_get_users_courses"
    try:
        r = requests.post(
            f"https://online-dauphine.com/moodle/webservice/rest/server.php?wstoken={token}&wsfunction={funtion}&moodlewsrestformat=json&userid={userid}")
        res = json.loads(r.text)
        return res
    except Exception as e:
        print(e)
        return -1


def enrol_user(token, userid, courseid, roleid=5):
    funtion = "enrol_manual_enrol_users"
    try:
        r = requests.post(
            f"https://online-dauphine.com/moodle/webservice/rest/server.php?wstoken={token}&wsfunction={funtion}&moodlewsrestformat=json&enrolments[0][userid]={userid}&enrolments[0][courseid]={courseid}&enrolments[0][roleid]={roleid}")
        res = json.loads(r.text)
        return res
    except Exception as e:
        print(e)
        return -1


def get_completed_courses(token, userid, courseid):
    funtion = "core_completion_get_course_completion_status"
    try:
        r = requests.post(
            f"https://online-dauphine.com/moodle/webservice/rest/server.php?wstoken={token}&wsfunction={funtion}&moodlewsrestformat=json&userid={userid}&courseid={courseid}")
        res = json.loads(r.text)
        return res
    except Exception as e:
        print(e)
        return -1


def delete_user_moodel(token, userid):
    funtion = "core_user_delete_users"
    try:
        r = requests.post(
            f"https://online-dauphine.com/moodle/webservice/rest/server.php?wstoken={token}&wsfunction={funtion}&moodlewsrestformat=json&userids[0]={userid}")
        if r.text == "null":
            return 0
        return -1
    except Exception as e:
        print(e)
        return -1


def get_grades(token, course_id, users_ids):
    funtion = "core_grades_get_grades"
    try:
        r = requests.post(
            f"https://online-dauphine.com/moodle/webservice/rest/server.php?wstoken={token}&wsfunction={funtion}&courseid={course_id}&userids={users_ids}&moodlewsrestformat=json")
        res = json.loads(r.text)

        return res
    except Exception as e:
        print(e)
        return -1


def update_user_info(token, user_id,user_info):
    """_summary_

    Args:
        token (_type_): _description_
        user_id (_type_): _description_
        user_info dict : 
    all available updates and their format
    users[0][id]= int
    users[0][username]= string
    users[0][auth]= string
    users[0][suspended]= int
    users[0][password]= string
    users[0][firstname]= string
    users[0][lastname]= string
    users[0][email]= string
    users[0][maildisplay]= int
    users[0][city]= string
    users[0][country]= string
    users[0][timezone]= string
    users[0][description]= string
    users[0][userpicture]= int
    users[0][firstnamephonetic]= string
    users[0][lastnamephonetic]= string
    users[0][middlename]= string
    users[0][alternatename]= string
    users[0][interests]= string
    users[0][url]= string
    users[0][icq]= string
    users[0][skype]= string
    users[0][aim]= string
    users[0][yahoo]= string
    users[0][msn]= string
    users[0][idnumber]= string
    users[0][institution]= string
    users[0][department]= string
    users[0][phone1]= string
    users[0][phone2]= string
    users[0][address]= string
    users[0][lang]= string
    users[0][calendartype]= string
    users[0][theme]= string
    users[0][mailformat]= int
    users[0][customfields][0][type]= string
    users[0][customfields][0][value]= string
    users[0][preferences][0][type]= string
    users[0][preferences][0][value]= string

    Returns:
        _type_: _description_
    """
    funtion = "core_user_update_users"
    for key,val in user_info.items():
        try:
            r = requests.post(
            f"https://online-dauphine.com/moodle/webservice/rest/server.php?wstoken={token}&wsfunction={funtion}&users[0][id]={user_id}&users[0][{key}]={val}&moodlewsrestformat=json")
        except Exception as e:
            print(e)
            return False
    return r
def get_users_info(token, user_id):
    """get user info"""
    function ="core_user_get_users"
    try:
        r = requests.post(f"https://online-dauphine.com/moodle/webservice/rest/server.php?wstoken={token}&wsfunction={function}&criteria[0][key]=id&criteria[0][value]={user_id}&moodlewsrestformat=json")
        res = json.loads(r.text)['users'][0]['profileimageurlsmall']
    except Exception as e:
        return False
    return res
def get_user_picture(token, user_id):
    """get user info"""
    function ="core_user_get_users"
    try:
        r = requests.post(f"https://online-dauphine.com/moodle/webservice/rest/server.php?wstoken={token}&wsfunction={function}&criteria[0][key]=id&criteria[0][value]={user_id}&moodlewsrestformat=json")
        res = json.loads(r.text)["users"][0]["profileimageurl"]

    except Exception as e:
        return False
    return res

def update_user_picture(token, user_id, picture):
    """_summary_

    Args:
        token (_type_): _description_
        user_id (_type_): _description_
        picture (_type_): _description_

    Returns:
        _type_: _description_
    """
    funtion = "core_user_update_user_picture"
    try:
        r = requests.post(
            f"https://online-dauphine.com/moodle/webservice/rest/server.php?wstoken={token}&wsfunction={funtion}&userpicturefile={picture}&userid={user_id}&moodlewsrestformat=json")
        print(r.text)
        return r
    except Exception as e:
        print(e)
        return False

def upload_image_file(token,filename="test",component = "user",filearea = "draft",itemid = 0,filepath = "/acturian_app/",filecontent="",contextlevel="user",userid=0):
    """
    upload image to moodle draft file area
    """
    function = "core_files_upload"
    try:
        r = requests.post(f"https://online-dauphine.com/moodle/webservice/rest/server.php?wstoken={token}&wsfunction={function}&contextid=edz&filename={filename}&component={component}&filearea={filearea}&itemid={itemid}&filepath={filepath}&filecontent={filecontent}&contextlevel={contextlevel}&instanceid={userid}&moodlewsrestformat=json")
        print(r.text)
    except Exception as e:
        print(e)
        return False
    
def remove_user_enrolment(token,userid,courseid):
    """
    remove user enrolment
    """
    function = "enrol_manual_unenrol_users"
    try:
        r = requests.post(f"https://online-dauphine.com/moodle/webservice/rest/server.php?wstoken={token}&wsfunction={function}&enrolments[0][roleid]=5&enrolments[0][userid]={userid}&enrolments[0][courseid]={courseid}&moodlewsrestformat=json")
        print(r.text)
    except Exception as e:
        print(e)
        return False