from flask.cli import FlaskGroup

from actapi import app, db
from actapi.models.user import User
from actapi.util import enrol_user,delete_user_moodel
from actapi.Config import TOKEN,USERID
cli = FlaskGroup(app)


@cli.command("create_db")
def create_db():
    db.drop_all()
    db.create_all()
    db.session.commit()


@cli.command("seed_db_admin")
def seed_db():
    new_user = User(username="admin", email="admin@admin.com", password="admin",
                            admin=True, firstname="admin", lastname="admin")  
    db.session.add(new_user)
    db.session.commit()

@cli.command("seed_db_test")
def seed_db():
    try:
        delete_user_moodel(TOKEN,USERID)
        User.query.filter_by(username="acturiantest").delete()
    except:
        pass
    
    new_user = User(username="acturiantest", email="acturiantest@acturiantest.com", password="Acturiantest123@",
                            admin=False, firstname="test", lastname="test")  
    db.session.add(new_user)
    db.session.commit()
if __name__ == "__main__":
    cli()
