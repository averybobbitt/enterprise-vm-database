from sqlalchemy import TIMESTAMP

from models import db
from models.HardwareConfig import HardwareConfig
from models.Instance import Instance
from models.Log import Log
from models.NetworkConfig import NetworkConfig
from models.Snapshot import Snapshot
from models.StorageConfig import StorageConfig
from models.User import User

users = [
    User(username='john_doe', password='securepass1', email='john.doe@example.com', is_admin=True),
    User(username='mike_anderson', password='passwordMike', email='mike.anderson@example.com', is_admin=True),
    User(username='amy_green', password='amy1234', email='amy.green@example.com', is_admin=True),
    User(username='jane_smith', password='p@ssw0rd', email='jane.smith@example.com', is_admin=False),
    User(username='bob_jones', password='bobsp@ss', email='bob.jones@example.com', is_admin=False),
    User(username='sara_jackson', password='sara123', email='susersara.jackson@example.com', is_admin=False),
    User(username='emily_miller', password='emilyPass123', email='emily.miller@example.com', is_admin=False),
    User(username='david_white', password='davidPass', email='david.white@example.com', is_admin=False),
    User(username='tom_wilson', password='secureTom', email='tom.wilson@example.com', is_admin=False),
    User(username='lisa_jenkins', password='lisaPass', email='lisa.jenkins@example.com', is_admin=False),
]

instances = [
    Instance(user_id=1, vm_name='WebServer', vm_description='Web server for production', os_type='Linux',
             os_version='Fedora 34', status='Running'),
    Instance(user_id=6, vm_name='AnalyticsServer', vm_description='Analytics server for reporting', os_type='Windows',
             os_version='Server 2016', status='Running'),
    Instance(user_id=4, vm_name='BackupServer', vm_description='Backup server for critical data', os_type='Linux',
             os_version='Debian 10', status='Error'),
    Instance(user_id=2, vm_name='DevEnv', vm_description='Development environment', os_type='Windows', os_version='10',
             status='Running'),
    Instance(user_id=3, vm_name='TestEnv', vm_description='Testing environment', os_type='Linux',
             os_version='Ubuntu 18.04', status='Running'),
]

network_configs = [
    NetworkConfig(vm_id=1, network_type='LAN', ip_address='192.168.1.2', subnet_mask='255.255.255.0',
                  gateway='192.168.1.1'),
    NetworkConfig(vm_id=2, network_type='Public', ip_address='203.0.113.5', subnet_mask='255.255.255.192',
                  gateway='203.0.113.1'),
    NetworkConfig(vm_id=3, network_type='Private', ip_address='172.18.0.5', subnet_mask='255.255.0.0',
                  gateway='172.18.0.1'),
    NetworkConfig(vm_id=4, network_type='LAN', ip_address='192.168.2.3', subnet_mask='255.255.255.0',
                  gateway='192.168.2.1'),
    NetworkConfig(vm_id=5, network_type='DMZ', ip_address='172.16.0.2', subnet_mask='255.255.0.0',
                  gateway='172.16.0.1'),
]

storage_configs = [
    StorageConfig(vm_id=1, storage_type='SSD', storage_capacity_gb=100, storage_controller='SATA'),
    StorageConfig(vm_id=1, storage_type='HDD', storage_capacity_gb=500, storage_controller='SCSI'),
    StorageConfig(vm_id=2, storage_type='SSD', storage_capacity_gb=250, storage_controller='NVMe'),
    StorageConfig(vm_id=2, storage_type='HDD', storage_capacity_gb=200, storage_controller='SATA'),
    StorageConfig(vm_id=3, storage_type='SSD', storage_capacity_gb=300, storage_controller='NVMe'),
    StorageConfig(vm_id=3, storage_type='HDD', storage_capacity_gb=150, storage_controller='SCSI'),
    StorageConfig(vm_id=4, storage_type='SSD', storage_capacity_gb=200, storage_controller='NVMe'),
    StorageConfig(vm_id=4, storage_type='HDD', storage_capacity_gb=400, storage_controller='SATA'),
    StorageConfig(vm_id=5, storage_type='SSD', storage_capacity_gb=120, storage_controller='NVMe'),
    StorageConfig(vm_id=5, storage_type='HDD', storage_capacity_gb=350, storage_controller='SCSI'),
]

hardware_configs = [
    HardwareConfig(vm_id=1, cpu_cores=4, ram_size_gb=8),
    HardwareConfig(vm_id=2, cpu_cores=2, ram_size_gb=4),
    HardwareConfig(vm_id=3, cpu_cores=8, ram_size_gb=16),
    HardwareConfig(vm_id=4, cpu_cores=4, ram_size_gb=8),
    HardwareConfig(vm_id=5, cpu_cores=6, ram_size_gb=12),
]

logs = [
    Log(vm_id=1, log_message='VM started successfully'),
    Log(vm_id=2, log_message='Error: Unable to start VM'),
    Log(vm_id=3, log_message='VM paused for maintenance'),
    Log(vm_id=4, log_message='VM stopped by user'),
    Log(vm_id=5, log_message='Suspended due to high resource usage'),
    Log(vm_id=1, log_message='VM rebooted'),
    Log(vm_id=2, log_message='Security update applied'),
    Log(vm_id=3, log_message='VM stopped for backup'),
    Log(vm_id=4, log_message='VM created successfully'),
    Log(vm_id=5, log_message='VM snapshot created'),
]

snapshots = [
    Snapshot(vm_id=1, snapshot_name='Snapshot1', snapshot_description='Initial snapshot of VM'),
    Snapshot(vm_id=1, snapshot_name='DailyBackup', snapshot_description='Daily backup of production VM'),
    Snapshot(vm_id=2, snapshot_name='BackupSnapshot', snapshot_description='Backup before software update'),
    Snapshot(vm_id=2, snapshot_name='RollbackSnapshot', snapshot_description='Snapshot for rollback purposes'),
    Snapshot(vm_id=3, snapshot_name='CriticalFixSnapshot',
             snapshot_description='Snapshot taken before critical fix installation'),
    Snapshot(vm_id=3, snapshot_name='DataMigrationSnapshot',
             snapshot_description='Snapshot before data migration process'),
    Snapshot(vm_id=4, snapshot_name='TestingEnvironment',
             snapshot_description='Snapshot for testing environment setup'),
    Snapshot(vm_id=4, snapshot_name='SecurityPatchSnapshot',
             snapshot_description='Snapshot taken before applying security patches'),
    Snapshot(vm_id=5, snapshot_name='TemplateSnapshot', snapshot_description='Snapshot used as a template for new VMs'),
    Snapshot(vm_id=5, snapshot_name='EmergencySnapshot', snapshot_description='Snapshot taken in case of emergency'),
]


# Define views
class ViewUsersWithVMs(db.Model):
    __tablename__ = 'view_users_with_vms'
    user_id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(255))
    email = db.Column(db.String(255))
    vm_id = db.Column(db.Integer, primary_key=True)
    vm_name = db.Column(db.String(255))
    status = db.Column(db.String(50))


class ViewRunningVMs(db.Model):
    __tablename__ = 'view_running_vms'
    vm_id = db.Column(db.Integer, primary_key=True)
    vm_name = db.Column(db.String(255))
    status = db.Column(db.String(50))
    created_at = db.Column(TIMESTAMP)


class ViewVMConfigs(db.Model):
    __tablename__ = 'view_vm_configs'
    vm_id = db.Column(db.Integer, primary_key=True)
    vm_name = db.Column(db.String(255))
    os_type = db.Column(db.String(50))
    os_version = db.Column(db.String(50))
    cpu_cores = db.Column(db.Integer)
    network_type = db.Column(db.String(50))
    storage_type = db.Column(db.String(50))


class ViewAdminUsers(db.Model):
    __tablename__ = 'view_admin_users'
    user_id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(255))
    email = db.Column(db.String(255))


class ViewLogs(db.Model):
    __tablename__ = 'view_logs'
    vm_id = db.Column(db.Integer, primary_key=True)
    vm_name = db.Column(db.String(255))
    log_message = db.Column(db.Text)
    log_timestamp = db.Column(TIMESTAMP)


views = [
    ViewUsersWithVMs(user_id=1, username='john_doe', email='john.doe@example.com', vm_id=1, vm_name='WebServer',
                     status='Running'),
    ViewUsersWithVMs(user_id=6, username='mike_anderson', email='mike.anderson@example.com', vm_id=2,
                     vm_name='AnalyticsServer', status='Running'),
    ViewUsersWithVMs(user_id=4, username='bob_jones', email='bob.jones@example.com', vm_id=3, vm_name='BackupServer',
                     status='Error'),
    ViewUsersWithVMs(user_id=2, username='jane_smith', email='jane.smith@example.com', vm_id=4, vm_name='DevEnv',
                     status='Running'),
    ViewUsersWithVMs(user_id=3, username='amy_green', email='amy.green@example.com', vm_id=5, vm_name='TestEnv',
                     status='Running'),
]
