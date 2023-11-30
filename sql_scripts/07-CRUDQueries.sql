# noinspection SqlNoDataSourceInspectionForFile

-- 1. Select all running virtual machines with their hardware configurations
SELECT instances.*, hardware_configs.cpu_cores, hardware_configs.ram_size_gb
FROM instances
         JOIN hardware_configs ON instances.vm_id = hardware_configs.vm_id
WHERE instances.status = 'Running';

-- 2. Insert a new network configuration for a specific virtual machine
INSERT INTO network_configs (vm_id, network_type, ip_address, subnet_mask, gateway)
VALUES (1, 'Ethernet', '192.168.1.2', '255.255.255.0', '192.168.1.1');

-- 3. Update the description of a virtual machine
UPDATE instances
SET vm_description = 'Updated description'
WHERE vm_id = 1;

-- 4. Update the storage capacity of a specific storage configuration
UPDATE storage_configs
SET storage_capacity_gb = 100
WHERE storage_id = 2;

-- 5. Select all virtual machines with their associated logs
SELECT instances.*, logs.log_message, logs.log_timestamp
FROM instances
         LEFT JOIN logs ON instances.vm_id = logs.vm_id;

-- 6. Delete a storage configuration for a specific virtual machine
DELETE
FROM storage_configs
WHERE vm_id = 1
   OR vm_id = 2;

-- 7. Select the latest snapshot for each virtual machine
SELECT snapshots.*
FROM snapshots
         JOIN (SELECT vm_id, MAX(snapshot_timestamp) AS latest_snapshot
               FROM snapshots
               GROUP BY vm_id) AS latest_snapshots ON snapshots.vm_id = latest_snapshots.vm_id AND
                                                      snapshots.snapshot_timestamp = latest_snapshots.latest_snapshot;

-- 8. Insert a new snapshot for a specific virtual machine
INSERT INTO snapshots (vm_id, snapshot_name, snapshot_description)
VALUES (1, 'Snapshot_1', 'Initial snapshot');

-- 9. Purge all non running VM instances
CALL DeleteNonRunningInstances();

-- 10. Create a new VM instance using the CreateInstance procedure
CALL CreateVirtualMachineInstance(
        1, -- user_id
        'MyVM', -- vm_name
        'Description of MyVM', -- vm_description
        'Linux', -- os_type
        'Ethernet', -- network_type
        '192.168.1.2', -- ip_address
        '255.255.255.0', -- subnet_mask
        '192.168.1.1', -- gateway
        2, -- cpu_cores
        4, -- ram_size_gb
        'SSD', -- storage_type
        100, -- storage_capacity_gb
        'SATA' -- storage_controller
     );

