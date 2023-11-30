-- Table storing information about users
CREATE TABLE users
(
    user_id  INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    email    VARCHAR(255) NOT NULL,
    is_admin BOOL         NOT NULL
);

-- Table storing information about virtual machines
CREATE TABLE instances
(
    vm_id          INT PRIMARY KEY AUTO_INCREMENT,
    user_id        INT, -- Foreign key referencing the users table
    vm_name        VARCHAR(255)                                                NOT NULL,
    vm_description TEXT,
    os_type        VARCHAR(50)                                                 NOT NULL,
    os_version     VARCHAR(50),
    status         ENUM ('Running', 'Stopped', 'Paused', 'Suspended', 'Error') NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (user_id),
    created_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table storing information about network configs for virtual machines
CREATE TABLE network_configs
(
    network_id   INT PRIMARY KEY AUTO_INCREMENT,
    vm_id        INT, -- Foreign key referencing the virtual_machines table
    network_type VARCHAR(50) NOT NULL,
    ip_address   VARCHAR(15) NOT NULL,
    subnet_mask  VARCHAR(15) NOT NULL,
    gateway      VARCHAR(15),
    FOREIGN KEY (vm_id) REFERENCES instances (vm_id)
);

-- Table storing information about storage configs for virtual machines
CREATE TABLE storage_configs
(
    storage_id          INT PRIMARY KEY AUTO_INCREMENT,
    vm_id               INT, -- Foreign key referencing the virtual_machines table
    storage_type        VARCHAR(50) NOT NULL,
    storage_capacity_gb INT         NOT NULL,
    storage_controller  VARCHAR(50),
    FOREIGN KEY (vm_id) REFERENCES instances (vm_id)
);

-- Table storing information about hardware configs for virtual machines
CREATE TABLE hardware_configs
(
    hardware_id INT PRIMARY KEY AUTO_INCREMENT,
    vm_id       INT, -- Foreign key referencing the virtual_machines table
    cpu_cores   INT NOT NULL,
    ram_size_gb INT NOT NULL,
    FOREIGN KEY (vm_id) REFERENCES instances (vm_id)
);

-- Table storing information about virtual machine logs
CREATE TABLE logs
(
    log_id        INT PRIMARY KEY AUTO_INCREMENT,
    vm_id         INT, -- Foreign key referencing the instances table
    log_message   TEXT,
    log_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (vm_id) REFERENCES instances (vm_id)
);

-- Table storing information about virtual machine snapshots
CREATE TABLE snapshots
(
    snapshot_id          INT PRIMARY KEY AUTO_INCREMENT,
    vm_id                INT, -- Foreign key referencing the instances table
    snapshot_name        VARCHAR(255) NOT NULL,
    snapshot_description TEXT,
    snapshot_timestamp   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (vm_id) REFERENCES instances (vm_id)
);

-- Insert sample users into the 'users' table
INSERT INTO users (username, password, email, is_admin)
VALUES ('john_doe', 'securepass1', 'john.doe@example.com', true),
       ('mike_anderson', 'passwordMike', 'mike.anderson@example.com', true),
       ('amy_green', 'amy1234', 'amy.green@example.com', true),
       ('jane_smith', 'p@ssw0rd', 'jane.smith@example.com', false),
       ('bob_jones', 'bobsp@ss', 'bob.jones@example.com', false),
       ('sara_jackson', 'sara123', 'susersara.jackson@example.com', false),
       ('emily_miller', 'emilyPass123', 'emily.miller@example.com', false),
       ('david_white', 'davidPass', 'david.white@example.com', false),
       ('tom_wilson', 'secureTom', 'tom.wilson@example.com', false),
       ('lisa_jenkins', 'lisaPass', 'lisa.jenkins@example.com', false);

-- Insert sample virtual machine instances into the 'instances' table
INSERT INTO instances (user_id, vm_name, vm_description, os_type, os_version, status)
VALUES (1, 'WebServer', 'Web server for production', 'Linux', 'Fedora 34', 'Running'),
       (6, 'AnalyticsServer', 'Analytics server for reporting', 'Windows', 'Server 2016', 'Running'),
       (4, 'BackupServer', 'Backup server for critical data', 'Linux', 'Debian 10', 'Error'),
       (2, 'DevEnv', 'Development environment', 'Windows', '10', 'Running'),
       (3, 'TestEnv', 'Testing environment', 'Linux', 'Ubuntu 18.04', 'Running');


-- Insert sample network configurations into the 'network_configs' table
INSERT INTO network_configs (vm_id, network_type, ip_address, subnet_mask, gateway)
VALUES (1, 'LAN', '192.168.1.2', '255.255.255.0', '192.168.1.1'),
       (2, 'Public', '203.0.113.5', '255.255.255.192', '203.0.113.1'),
       (3, 'Private', '172.18.0.5', '255.255.0.0', '172.18.0.1'),
       (4, 'LAN', '192.168.2.3', '255.255.255.0', '192.168.2.1'),
       (5, 'DMZ', '172.16.0.2', '255.255.0.0', '172.16.0.1');

-- Insert sample storage configurations into the 'storage_configs' table
INSERT INTO storage_configs (vm_id, storage_type, storage_capacity_gb, storage_controller)
VALUES (1, 'SSD', 100, 'SATA'),
       (1, 'HDD', 500, 'SCSI'),
       (2, 'SSD', 250, 'NVMe'),
       (2, 'HDD', 200, 'SATA'),
       (3, 'SSD', 300, 'NVMe'),
       (3, 'HDD', 150, 'SCSI'),
       (4, 'SSD', 200, 'NVMe'),
       (4, 'HDD', 400, 'SATA'),
       (5, 'SSD', 120, 'NVMe'),
       (5, 'HDD', 350, 'SCSI');

-- Insert sample hardware configurations into the 'hardware_configs' table
INSERT INTO hardware_configs (vm_id, cpu_cores, ram_size_gb)
VALUES (1, 4, 8),
       (2, 2, 4),
       (3, 8, 16),
       (4, 4, 8),
       (5, 6, 12);

-- Insert sample logs into the 'logs' table
INSERT INTO logs (vm_id, log_message)
VALUES (1, 'VM started successfully'),
       (2, 'Error: Unable to start VM'),
       (3, 'VM paused for maintenance'),
       (4, 'VM stopped by user'),
       (5, 'Suspended due to high resource usage'),
       (1, 'VM rebooted'),
       (2, 'Security update applied'),
       (3, 'VM stopped for backup'),
       (4, 'VM created successfully'),
       (5, 'VM snapshot created');

-- Insert sample snapshots into the 'snapshots' table
INSERT INTO snapshots (vm_id, snapshot_name, snapshot_description)
VALUES (1, 'Snapshot1', 'Initial snapshot of VM'),
       (1, 'DailyBackup', 'Daily backup of production VM'),
       (2, 'BackupSnapshot', 'Backup before software update'),
       (2, 'RollbackSnapshot', 'Snapshot for rollback purposes'),
       (3, 'CriticalFixSnapshot', 'Snapshot taken before critical fix installation'),
       (3, 'DataMigrationSnapshot', 'Snapshot before data migration process'),
       (4, 'TestingEnvironment', 'Snapshot for testing environment setup'),
       (4, 'SecurityPatchSnapshot', 'Snapshot taken before applying security patches'),
       (5, 'TemplateSnapshot', 'Snapshot used as a template for new VMs'),
       (5, 'EmergencySnapshot', 'Snapshot taken in case of emergency');

-- View: Users with Virtual Machines
CREATE VIEW view_users_with_vms AS
SELECT users.user_id,
       users.username,
       users.email,
       instances.vm_id,
       instances.vm_name,
       instances.status
FROM users
         JOIN
     instances ON users.user_id = instances.user_id;

-- View: Running Virtual Machines
CREATE VIEW view_running_vms AS
SELECT vm_id,
       vm_name,
       status,
       created_at
FROM instances
WHERE status = 'Running';

-- View: Virtual Machine configs
CREATE VIEW view_vm_configs AS
SELECT instances.vm_id,
       instances.vm_name,
       instances.os_type,
       instances.os_version,
       hardware_configs.cpu_cores,
       network_configs.network_type,
       storage_configs.storage_type
FROM instances
         JOIN
     hardware_configs ON instances.vm_id = hardware_configs.vm_id
         JOIN
     network_configs ON instances.vm_id = network_configs.vm_id
         JOIN
     storage_configs ON instances.vm_id = storage_configs.vm_id;

-- View: Users with Admin Privileges
CREATE VIEW view_admin_users AS
SELECT user_id,
       username,
       email
FROM users
WHERE is_admin = true;

-- View: Virtual Machine Logs
CREATE VIEW view_logs AS
SELECT instances.vm_id,
       instances.vm_name,
       logs.log_message,
       logs.log_timestamp
FROM instances
         JOIN
     logs ON instances.vm_id = logs.vm_id;

-- Index on 'users' table for 'username'
CREATE INDEX idx_users_username ON users (username);

-- Index on 'instances' table for 'status'
CREATE INDEX idx_instances_status ON instances (status);

-- Composite index on 'instances' table for 'vm_id and vm_name'
CREATE INDEX idx_instances_vm_info ON instances (vm_id, vm_name);

# -- Define the procedure
# CREATE PROCEDURE CreateDatabaseUser(
#     IN p_username VARCHAR(255),
#     IN p_password VARCHAR(255)
# )
# BEGIN
#     -- Initialize procedure variables
#     DECLARE database_name VARCHAR(255);
#     SET database_name = 'virtual_machines';
#
#     -- Create a database user
#     SET @create_user_query = CONCAT('CREATE USER ''', p_username, '''@''%'' IDENTIFIED BY ''', p_password, '''');
#     PREPARE create_user_stmt FROM @create_user_query;
#     EXECUTE create_user_stmt;
#     DEALLOCATE PREPARE create_user_stmt;
#
#     -- Grant privileges to the user on the specified database
#     SET @grant_query =
#             CONCAT('GRANT SELECT, INSERT, UPDATE, DELETE ON ', database_name, '.* TO ''', p_username, '''@''%''');
#     PREPARE grant_stmt FROM @grant_query;
#     EXECUTE grant_stmt;
#     DEALLOCATE PREPARE grant_stmt;
#
#     -- Flush privileges to apply the changes
#     FLUSH PRIVILEGES;
# END;
#
# -- Use procedure to create a new user
# CALL CreateDatabaseUser('db_user', 'secretp4ssword!');
#
# -- Define the procedure
# CREATE PROCEDURE CreateVirtualMachineInstance(
#     IN p_user_id INT,
#     IN p_vm_name VARCHAR(255),
#     IN p_vm_description TEXT,
#     IN p_os_type VARCHAR(50),
#     IN p_network_type VARCHAR(50),
#     IN p_ip_address VARCHAR(15),
#     IN p_subnet_mask VARCHAR(15),
#     IN p_gateway VARCHAR(15),
#     IN p_cpu_cores INT,
#     IN p_ram_size_gb INT,
#     IN p_storage_type VARCHAR(50),
#     IN p_storage_capacity_gb INT,
#     IN p_storage_controller VARCHAR(50)
# )
# BEGIN
#     DECLARE new_vm_id INT;
#
#     -- Create a new instance
#     INSERT INTO instances (user_id, vm_name, vm_description, os_type, status)
#     VALUES (p_user_id, p_vm_name, p_vm_description, p_os_type, 'Stopped');
#
#     -- Get the newly created VM ID
#     SET new_vm_id = LAST_INSERT_ID();
#
#     -- Create network configuration
#     INSERT INTO network_configs (vm_id, network_type, ip_address, subnet_mask, gateway)
#     VALUES (new_vm_id, p_network_type, p_ip_address, p_subnet_mask, p_gateway);
#
#     -- Create hardware configuration
#     INSERT INTO hardware_configs (vm_id, cpu_cores, ram_size_gb)
#     VALUES (new_vm_id, p_cpu_cores, p_ram_size_gb);
#
#     -- Create storage configuration
#     INSERT INTO storage_configs (vm_id, storage_type, storage_capacity_gb, storage_controller)
#     VALUES (new_vm_id, p_storage_type, p_storage_capacity_gb, p_storage_controller);
# END;

-- Use procedure to create a new instance with only required fields
# CALL CreateVirtualMachineInstance(
#         1, -- user_id
#         'MyVM', -- vm_name
#         'Description of MyVM', -- vm_description
#         'Linux', -- os_type
#         'Ethernet', -- network_type
#         '192.168.1.2', -- ip_address
#         '255.255.255.0', -- subnet_mask
#         '192.168.1.1', -- gateway
#         2, -- cpu_cores
#         4, -- ram_size_gb
#         'SSD', -- storage_type
#         100, -- storage_capacity_gb
#         'SATA' -- storage_controller
#      );