-- Temporarily change delimiter to allow the procedure to be compacted into a single statement
DELIMITER //

-- Define the procedure
CREATE PROCEDURE CreateDatabaseUser(
    IN p_username VARCHAR(255),
    IN p_password VARCHAR(255)
)
BEGIN
    -- Initialize procedure variables
    DECLARE database_name VARCHAR(255);
    SET database_name = 'virtual_machines';

    -- Create a database user
    SET @create_user_query = CONCAT('CREATE USER ''', p_username, '''@''%'' IDENTIFIED BY ''', p_password, '''');
    PREPARE create_user_stmt FROM @create_user_query;
    EXECUTE create_user_stmt;
    DEALLOCATE PREPARE create_user_stmt;

    -- Grant privileges to the user on the specified database
    SET @grant_query =
            CONCAT('GRANT SELECT, INSERT, UPDATE, DELETE ON ', database_name, '.* TO ''', p_username, '''@''%''');
    PREPARE grant_stmt FROM @grant_query;
    EXECUTE grant_stmt;
    DEALLOCATE PREPARE grant_stmt;

    -- Flush privileges to apply the changes
    FLUSH PRIVILEGES;
END //

-- Set delimiter back to default
DELIMITER ;

-- Use procedure to create a new user
CALL CreateDatabaseUser('db_user', 'secretp4ssword!');