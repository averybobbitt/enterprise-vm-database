from models import db


class HardwareConfig(db.Model):
    __tablename__ = 'hardware_configs'
    hardware_id = db.Column(db.Integer, primary_key=True)
    vm_id = db.Column(db.Integer, db.ForeignKey('instances.vm_id'))
    cpu_cores = db.Column(db.Integer, nullable=False)
    ram_size_gb = db.Column(db.Integer, nullable=False)
