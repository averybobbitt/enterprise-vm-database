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
