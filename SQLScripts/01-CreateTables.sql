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
