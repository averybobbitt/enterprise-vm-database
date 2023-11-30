-- Temporarily change delimiter to allow the procedure to be compacted into a single statement
# DELIMITER //

-- Define the procedure
CREATE PROCEDURE CreateVirtualMachineInstance(
    IN p_user_id INT,
    IN p_vm_name VARCHAR(255),
    IN p_vm_description TEXT,
    IN p_os_type VARCHAR(50),
    IN p_network_type VARCHAR(50),
    IN p_ip_address VARCHAR(15),
    IN p_subnet_mask VARCHAR(15),
    IN p_gateway VARCHAR(15),
    IN p_cpu_cores INT,
    IN p_ram_size_gb INT,
    IN p_storage_type VARCHAR(50),
    IN p_storage_capacity_gb INT,
    IN p_storage_controller VARCHAR(50)
)
BEGIN
    DECLARE new_vm_id INT;

    -- Create a new instance
    INSERT INTO instances (user_id, vm_name, vm_description, os_type, status)
    VALUES (p_user_id, p_vm_name, p_vm_description, p_os_type, 'Stopped');

    -- Get the newly created VM ID
    SET new_vm_id = LAST_INSERT_ID();

    -- Create network configuration
    INSERT INTO network_configs (vm_id, network_type, ip_address, subnet_mask, gateway)
    VALUES (new_vm_id, p_network_type, p_ip_address, p_subnet_mask, p_gateway);

    -- Create hardware configuration
    INSERT INTO hardware_configs (vm_id, cpu_cores, ram_size_gb)
    VALUES (new_vm_id, p_cpu_cores, p_ram_size_gb);

    -- Create storage configuration
    INSERT INTO storage_configs (vm_id, storage_type, storage_capacity_gb, storage_controller)
    VALUES (new_vm_id, p_storage_type, p_storage_capacity_gb, p_storage_controller);
END;

-- Set delimiter back to default
# DELIMITER ;
