import pymysql
from flask import Flask, render_template
from sqlalchemy import text, func

from models import db
from models.HardwareConfig import HardwareConfig
from models.Instance import Instance
from models.Log import Log
from models.NetworkConfig import NetworkConfig
from models.Snapshot import Snapshot
from models.StorageConfig import StorageConfig
from models.User import User

HOST = "localhost"
PORT = 3307
USER = "root"
PASSWORD = "example"
DATABASE = "virtual_machines"

app = Flask(__name__)

app.config['SQLALCHEMY_DATABASE_URI'] = f'mysql+pymysql://{USER}:{PASSWORD}@{HOST}:{PORT}/{DATABASE}'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False


def execute_script(sql_file_path: str):
    with open(sql_file_path, 'r') as file:
        sql_script = file.read()

    # Split the SQL script into separate queries based on semicolons
    queries = sql_script.split(';')

    # Connect to the database
    connection = pymysql.connect(host=HOST, port=PORT, user=USER, password=PASSWORD, database=DATABASE)
    cursor = connection.cursor()

    # Use pymysql to execute each query
    for query in queries:
        if query.strip():  # Skip empty queries
            cursor.execute(query)

    # Commit the changes and close the connection
    connection.commit()
    connection.close()


def create_procedure(sql_file_path: str):
    with open(sql_file_path, 'r') as file:
        sql_script = file.read()

        # Use SQLAlchemy's text function to execute the entire script
        db.session.execute(text(sql_script))
        db.session.commit()


@app.route('/')
def index():
    return render_template('index.html')


@app.route('/overview')
def overview():
    users = User.query.all()
    instances = Instance.query.all()
    network_configs = NetworkConfig.query.all()
    storage_configs = StorageConfig.query.all()
    hardware_configs = HardwareConfig.query.all()
    logs = Log.query.all()
    snapshots = Snapshot.query.all()

    return render_template('overview.html', users=users, instances=instances,
                           network_configs=network_configs, storage_configs=storage_configs,
                           hardware_configs=hardware_configs, logs=logs, snapshots=snapshots)


# Select all running virtual machines with their hardware configurations
@app.route('/run_query_1')
def run_query_1():
    result = db.session.query(Instance, HardwareConfig).join(HardwareConfig,
                                                             Instance.vm_id == HardwareConfig.vm_id).filter(
        Instance.status == 'Running').all()

    return render_template('query_result.html', result=result)


# Insert a new network configuration for a specific virtual machine
@app.route('/run_query_2')
def run_query_2():
    new_network_config = NetworkConfig(
        vm_id=1,
        network_type='Ethernet',
        ip_address='192.168.1.2',
        subnet_mask='255.255.255.0',
        gateway='192.168.1.1'
    )

    # Add and commit the new network configuration
    db.session.add(new_network_config)
    db.session.commit()

    result = NetworkConfig.query.all()

    return render_template('query_result.html', result=result)


# Update the description of a virtual machine
@app.route('/run_query_3')
def run_query_3():
    db.session.query(Instance).filter_by(vm_id=1).update({'vm_description': "Updated description!"})
    db.session.commit()

    result = Instance.query.all()

    return render_template('query_result.html', result=result)


# Delete a storage configuration for a specific virtual machine
@app.route('/run_query_4')
def run_query_4():
    db.session.query(StorageConfig).filter(StorageConfig.vm_id.in_([1, 2])).delete()
    db.session.commit()

    result = StorageConfig.query.all()

    return render_template('query_result.html', result=result)


# Select all virtual machines with their associated logs
@app.route('/run_query_5')
def run_query_5():
    result = db.session.query(Instance, Log.log_message, Log.log_timestamp).outerjoin(Log,
                                                                                      Instance.vm_id == Log.vm_id).all()

    return render_template('query_result.html', result=result)


# Update the storage capacity of a specific storage configuration
@app.route('/run_query_6')
def run_query_6():
    storage_config = StorageConfig.query.filter_by(storage_id=2).first()
    if storage_config:
        storage_config.storage_capacity_gb = 100
        db.session.commit()

    result = StorageConfig.query.all()

    return render_template('query_result.html', result=result)


# Select the latest snapshot for each virtual machine
@app.route('/run_query_7')
def run_query_7():
    subquery = db.session.query(Snapshot.vm_id, func.max(Snapshot.snapshot_timestamp).label(
        'latest_snapshot')).group_by(Snapshot.vm_id).subquery()
    result = db.session.query(Snapshot).join(subquery, (Snapshot.vm_id == subquery.c.vm_id) & (
            Snapshot.snapshot_timestamp == subquery.c.latest_snapshot)).all()

    return render_template('query_result.html', result=result)


# Insert a new snapshot for a specific virtual machine
@app.route('/run_query_8')
def run_query_8():
    new_snapshot = Snapshot(vm_id=1, snapshot_name='Snapshot_1', snapshot_description='Initial snapshot')
    db.session.add(new_snapshot)
    db.session.commit()

    result = Snapshot.query.all()

    return render_template('query_result.html', result=result)


with app.app_context():
    db.init_app(app)
    # execute_script("sql_scripts/00-InitDB.sql")
    # create_procedure("sql_scripts/05-CreateUser.sql")
    # create_procedure("sql_scripts/06-CreateInstance.sql")

if __name__ == '__main__':
    app.run(debug=False)
