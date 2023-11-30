from models import db


class NetworkConfig(db.Model):
    __tablename__ = 'network_configs'
    network_id = db.Column(db.Integer, primary_key=True)
    vm_id = db.Column(db.Integer, db.ForeignKey('instances.vm_id'))
    network_type = db.Column(db.String(50), nullable=False)
    ip_address = db.Column(db.String(15), nullable=False)
    subnet_mask = db.Column(db.String(15), nullable=False)
    gateway = db.Column(db.String(15))
