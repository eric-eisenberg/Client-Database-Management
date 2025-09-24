# Client Management Database Schema

## Overview
This project defines a simple **relational database schema** for managing clients and their meeting history. It consists of two core tables:

1. **`clients`** → Stores client details (contact info, company, etc.)
2. **`client_meetings`** → Stores meeting details, linked to each client via a foreign key.

The schema ensures referential integrity, provides sample data for testing, and includes example queries to demonstrate usage.

---

## Database Schema

### **1. Clients Table**
| Column       | Type             | Constraints         | Description                           |
|--------------|-----------------|---------------------|---------------------------------------|
| client_id    | INT             | PK, AUTO_INCREMENT  | Unique identifier for each client.     |
| first_name   | VARCHAR(100)    | NOT NULL            | Client’s first name.                  |
| last_name    | VARCHAR(100)    | NOT NULL            | Client’s last name.                   |
| email        | VARCHAR(150)    | UNIQUE, NOT NULL    | Email (must be unique).               |
| phone_number | VARCHAR(20)     | NULL                | Contact phone number.                 |
| company      | VARCHAR(150)    | NULL                | Company/organization name.            |
| created_at   | TIMESTAMP       | DEFAULT NOW         | Record creation timestamp.            |

---

### **2. Client Meetings Table**
| Column       | Type             | Constraints         | Description                           |
|--------------|-----------------|---------------------|---------------------------------------|
| meeting_id   | INT             | PK, AUTO_INCREMENT  | Unique identifier for each meeting.    |
| client_id    | INT             | FK → clients.id     | Associated client.                    |
| meeting_date | DATETIME        | NOT NULL            | Date & time of meeting.               |
| location     | VARCHAR(200)    | NULL                | Meeting location (or virtual platform).|
| notes        | TEXT            | NULL                | Optional meeting notes.               |
| created_at   | TIMESTAMP       | DEFAULT NOW         | Record creation timestamp.            |

**Relationship:**  
- A client can have **many meetings** (`1:N`).  
- If a client is deleted, their meetings are **automatically deleted** (`ON DELETE CASCADE`).  

---

## Key Features
- **Referential Integrity** → enforced via foreign key relationship.  
- **Data Consistency** → unique email constraint for clients.  
- **Cascade Deletes** → ensures no orphan meeting records.  
- **Test Data Included** → sample `INSERT` statements provided.  
- **Queries** → example JOIN query for quick validation.  

---

## Sample Queries

### Insert a new client
```sql
INSERT INTO clients (first_name, last_name, email, phone_number, company)
VALUES ('Diana', 'Prince', 'diana.prince@example.com', '555-444-5555', 'Justice League');
```

### Insert a meeting for a client
```sql
INSERT INTO client_meetings (client_id, meeting_date, location, notes)
VALUES (1, '2025-10-20 15:00:00', 'TechCorp HQ', 'Discuss contract renewal');
```

### List all clients with their meetings
```sql
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
```

### Count meetings per client
```sql
SELECT 
    c.client_id,
    CONCAT(c.first_name, ' ', c.last_name) AS client_name,
    COUNT(m.meeting_id) AS total_meetings
FROM clients c
LEFT JOIN client_meetings m ON c.client_id = m.client_id
GROUP BY c.client_id;
```

## How to Run

1. Save the `clientDB.sql` file to your machine.
2. Import into MySQL/MariaDB:
   ```bash
   mysql -u your_user -p your_database < clientDB.sql
   ```
3. Run the provided queries to validate data and relationships.
