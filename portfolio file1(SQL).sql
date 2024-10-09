create database if not exists test ;
use test;
CREATE TABLE Clients (
    client_id INT AUTO_INCREMENT PRIMARY KEY,
    organization_name VARCHAR(50),
    contact_first_name VARCHAR(50),
    contact_last_name VARCHAR(50),
    email VARCHAR(50),
    address VARCHAR(50),
    preferred_contact_method ENUM('post', 'email')
);


CREATE TABLE PoolMembers (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50),
    phone_number VARCHAR(20),
    work_address VARCHAR(50),
    home_address VARCHAR(50)
);


CREATE TABLE Skills (
    skill_id INT AUTO_INCREMENT PRIMARY KEY,
    skill_name VARCHAR(50),
    skill_type VARCHAR(50)
);

-- this table makes sure that memebers need to have different combinations of skills and experience
CREATE TABLE PoolMemberSkills (
    member_skill_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT,
    skill_id INT,
    experience_level ENUM('junior', 'intermediate', 'senior'),
    FOREIGN KEY (member_id) REFERENCES PoolMembers(member_id),
    FOREIGN KEY (skill_id) REFERENCES Skills(skill_id)
);

-- clients can offer as many projects as they want
-- there can be projects not linked to any poolmembers and vice versa
CREATE TABLE Projects (
    project_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(50),
    start_date DATE,
    end_date DATE,
    budget DECIMAL(10, 2),
    description TEXT,
    phase ENUM('design', 'development', 'testing', 'deployment', 'complete'),
    required_skill_1 VARCHAR(50),
    required_skill_2 VARCHAR(50),
    CONSTRAINT different_skills CHECK (required_skill_1 <> required_skill_2)
);


CREATE TABLE ProjectAssignments (
    assignment_id INT AUTO_INCREMENT PRIMARY KEY,
    project_id INT,
    member_id INT,
    FOREIGN KEY (project_id) REFERENCES Projects(project_id),
    FOREIGN KEY (member_id) REFERENCES PoolMembers(member_id)
);