from models import db


class Instance(db.Model):
    __tablename__ = 'instances'
    vm_id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('users.user_id'))
    vm_name = db.Column(db.String(255), nullable=False)
    vm_description = db.Column(db.Text)
    os_type = db.Column(db.String(50), nullable=False)
    status = db.Column(db.Enum('Running', 'Stopped', 'Paused', 'Suspended', 'Error'), nullable=False)
    created_at = db.Column(db.TIMESTAMP, default=db.func.current_timestamp())
