import os


basedir = os.path.abspath(os.path.dirname(__file__))


class Config(object):
    SQLALCHEMY_DATABASE_URI = os.getenv("DATABASE_URL", "sqlite://")
    SQLALCHEMY_TRACK_MODIFICATIONS = False





TOKEN="35a04f8c166cfac64b56bf14ca3d9e3d"
DATABASE_URL="postgresql://admin_act:admin123@db:5432/actuarryapp"
USERID="1761"