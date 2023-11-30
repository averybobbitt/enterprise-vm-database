from models import db


class Log(db.Model):
    __tablename__ = 'logs'
    log_id = db.Column(db.Integer, primary_key=True)
    vm_id = db.Column(db.Integer, db.ForeignKey('instances.vm_id'))
    log_message = db.Column(db.Text)
    log_timestamp = db.Column(db.TIMESTAMP, default=db.func.current_timestamp())
