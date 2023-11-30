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

