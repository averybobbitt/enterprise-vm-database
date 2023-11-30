from models import db


class StorageConfig(db.Model):
    __tablename__ = 'storage_configs'
    storage_id = db.Column(db.Integer, primary_key=True)
    vm_id = db.Column(db.Integer, db.ForeignKey('instances.vm_id'))
    storage_type = db.Column(db.String(50), nullable=False)
    storage_capacity_gb = db.Column(db.Integer, nullable=False)
    storage_controller = db.Column(db.String(50))
