-- Primary Key Index (Automatically created for primary keys)
-- Foreign Key Index (Automatically created for foreign keys)
 
-- Index on 'users' table for 'username'
CREATE INDEX idx_users_username ON users (username);

-- Index on 'instances' table for 'status'
CREATE INDEX idx_instances_status ON instances (status);

-- Composite index on 'instances' table for 'vm_id and vm_name'
CREATE INDEX idx_instances_vm_info ON instances (vm_id, vm_name);