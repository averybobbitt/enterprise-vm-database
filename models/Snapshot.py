from models import db


class Snapshot(db.Model):
    __tablename__ = 'snapshots'
    snapshot_id = db.Column(db.Integer, primary_key=True)
    vm_id = db.Column(db.Integer, db.ForeignKey('instances.vm_id'))
    snapshot_name = db.Column(db.String(255), nullable=False)
    snapshot_description = db.Column(db.Text)
    snapshot_timestamp = db.Column(db.TIMESTAMP, default=db.func.current_timestamp())
