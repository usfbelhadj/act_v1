from flask.cli import FlaskGroup

from actapi import app, db
from actapi.models.user import User


cli = FlaskGroup(app)


@cli.command("create_db")
def create_db():
    db.drop_all()
    db.create_all()
    db.session.commit()


@cli.command("seed_db")
def seed_db():
    new_user = User(username="admin", email="admin@admin.com", password="admin",
                            admin=True, firstname="admin", lastname="admin")  
    db.session.add(new_user)
    db.session.commit()

if __name__ == "__main__":
    cli()
