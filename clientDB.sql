-- create database
> CREATE DATABASE IF NOT EXIST client_management_app;
> USE client_management_app;


-- create tables
-- Create table for client information
CREATE TABLE clients (
    client_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    phone_number VARCHAR(20),
    company VARCHAR(150),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create table for client meeting information
CREATE TABLE client_meetings (
    meeting_id INT PRIMARY KEY AUTO_INCREMENT,
    client_id INT NOT NULL,
    meeting_date DATETIME NOT NULL,
    location VARCHAR(200),
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (client_id) REFERENCES clients(client_id) ON DELETE CASCADE
);

-- Sample data for clients
INSERT INTO clients (first_name, last_name, email, phone_number, company)
VALUES
('Alice', 'Johnson', 'alice.johnson@example.com', '555-123-4567', 'TechCorp'),
('Bob', 'Smith', 'bob.smith@example.com', '555-987-6543', 'Innovate Inc'),
('Charlie', 'Brown', 'charlie.brown@example.com', '555-222-3333', 'FutureWorks');

-- Sample data for client meetings
INSERT INTO client_meetings (client_id, meeting_date, location, notes)
VALUES
(1, '2025-10-01 10:00:00', 'TechCorp HQ, New York', 'Initial consultation about construction needs.'),
(2, '2025-10-05 14:30:00', 'Zoom', 'Follow-up discussion on project proposal.'),
(3, '2025-10-07 09:00:00', 'FutureWorks Office, Chicago', 'Initial meeting with client.'),
(1, '2025-10-15 11:00:00', 'Coffee Shop, Brooklyn', 'Casual check-in meeting.');

-- Example JOIN query: List clients with their meetings
SELECT 
    c.client_id,
    CONCAT(c.first_name, ' ', c.last_name) AS client_name,
    c.company,
    m.meeting_date,
    m.location,
    m.notes
FROM clients c
JOIN client_meetings m ON c.client_id = m.client_id
ORDER BY m.meeting_date;