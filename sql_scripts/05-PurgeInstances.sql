-- Temporarily change delimiter to allow the procedure to be compacted into a single statement
DELIMITER //

-- Define the procedure
CREATE PROCEDURE PurgeInstances()
BEGIN
    DECLARE vm_id_to_delete INT;
    DECLARE done BOOLEAN DEFAULT FALSE;

    -- Get the VM IDs to delete
    DECLARE cursor_instances CURSOR FOR
        SELECT vm_id
        FROM instances
        WHERE status <> 'Running';

    -- Declare handler for cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cursor_instances;
    cursor_loop:
    LOOP
        FETCH cursor_instances INTO vm_id_to_delete;

        IF done THEN
            LEAVE cursor_loop;
        END IF;

        -- Delete related records from child tables
        DELETE FROM snapshots WHERE vm_id = vm_id_to_delete;
        DELETE FROM logs WHERE vm_id = vm_id_to_delete;
        DELETE FROM hardware_configs WHERE vm_id = vm_id_to_delete;
        DELETE FROM network_configs WHERE vm_id = vm_id_to_delete;
        DELETE FROM storage_configs WHERE vm_id = vm_id_to_delete;

        -- Delete instance from instances table
        DELETE FROM instances WHERE vm_id = vm_id_to_delete;
    END LOOP;

    CLOSE cursor_instances;
END //

-- Set delimiter back to default
DELIMITER ;