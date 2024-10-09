-- clients info
INSERT INTO Clients (organization_name, contact_first_name, contact_last_name, email, address, preferred_contact_method) VALUES
('GOOGLE', 'TONY', 'STARK', 'STARK@23.com', 'WHITE HOUSE', 'email'),
('MICROSOFT', 'SATISH', 'KAUSHIK', 'KAUSHIK@RICH.com', 'BUCKINGHAM PALACE', 'post');


-- members info
INSERT INTO PoolMembers (first_name, last_name, email, phone_number, work_address, home_address) VALUES
('Peter', 'Parker', 'parker@123yahoo.com', '123456789', 'NEW YORK', '23 VICTORIAL ROAD'),
('Mary', 'Jane', 'jane@456.com', '987654321', 'LONDON', '16 HANDSWORTH');

-- mentioned atleast 6 skills
INSERT INTO Skills (skill_name, skill_type) VALUES
('Java', 'Backend'),
('JavaScript', 'Frontend'),
('HTML', 'Frontend'),
('SQL', 'Database'),
('Python', 'Backend'),
('UI/UX Design', 'Design');


INSERT INTO PoolMemberSkills (member_id, skill_id, experience_level) VALUES
(1, 1, 'senior'),-- peter :java senior
(1, 2, 'intermediate'), -- peter:javascript(intermediate)
(2, 2, 'senior'),-- mary: javascript(senior)
(2, 6, 'intermediate'); -- mary: ui/ux design(intermediate)

-- inserting one project
INSERT INTO Projects (title, start_date, end_date, budget, description, phase, required_skill_1, required_skill_2) VALUES
('ProjeCT MULTIVERSE', '2024-01-01', '2024-06-02', 10000.00, 'NEW REVOLUTION IN VFX', 'design', 'Java', 'JavaScript');


INSERT INTO ProjectAssignments (project_id, member_id)
VALUES
(1, 1),-- assign peter to project
(1, 2); -- assign mary to project





-- Identifying  pool members matching the project's requirements and assign them to the project
INSERT INTO ProjectAssignments (project_id, member_id)
SELECT p.project_id, pm.member_id
FROM Projects p
INNER JOIN PoolMembers pm ON p.required_skill_1 IN (SELECT skill_name FROM PoolMemberSkills pms1 
INNER JOIN Skills s1 ON pms1.skill_id = s1.skill_id
 WHERE pms1.member_id = pm.member_id AND s1.skill_type = 'Backend')
AND p.required_skill_2 IN (SELECT skill_name FROM PoolMemberSkills pms2
 INNER JOIN Skills s2 ON pms2.skill_id = s2.skill_id 
 WHERE pms2.member_id = pm.member_id AND s2.skill_type = 'Frontend');
 

  -- list of project with their corresponding client information
    SELECT
    Projects.title,
    Clients.organization_name,
    Clients.contact_first_name,
    Clients.contact_last_name,
    Clients.email,
    Clients.address
FROM
    Projects
INNER JOIN Clients ON Projects.client_id = Clients.client_id;
-- project budget overview
SELECT
    title AS Project,
    budget AS Budget
FROM
    Projects;
    -- project status
    SELECT
    title AS Project,
    phase AS Status
FROM
    Projects;
   