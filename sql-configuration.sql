 Create the database
CREATE DATABASE db_honrado_capstone;

-- Use the created database
USE db_crud;

-- Create users table
CREATE TABLE tbl_users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    firstname VARCHAR(100) NOT NULL,
    lastname VARCHAR(100) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

--create table products
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('admin', 'job_seeker') NOT NULL,  -- 'admin' or 'job_seeker'
    phone_number VARCHAR(15),
    resume_link TEXT,  -- Link to the user's resume (if applicable)
    profile_picture VARCHAR(255),  -- Path to the profile picture
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
CREATE TABLE jobs (
    job_id INT AUTO_INCREMENT PRIMARY KEY,
    employer_id INT NOT NULL,  -- Foreign key to reference the employer (user)
    job_title VARCHAR(255) NOT NULL,
    job_description TEXT,
    job_type ENUM('full-time', 'part-time', 'contract', 'internship') NOT NULL,
    location VARCHAR(255),
    salary_range VARCHAR(100),
    posted_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    closing_date DATETIME NOT NULL,  -- Job application deadline
    status ENUM('open', 'closed') DEFAULT 'open',  -- Job status
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (employer_id) REFERENCES users(user_id)  -- Employer is a user
);
CREATE TABLE applications (
    application_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,  -- Foreign key to the job seeker (user)
    job_id INT NOT NULL,  -- Foreign key to the job posting
    status ENUM('pending', 'under review', 'accepted', 'rejected') DEFAULT 'pending',
    cover_letter TEXT,
    application_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),  -- Job seeker (user)
    FOREIGN KEY (job_id) REFERENCES jobs(job_id)  -- Job posting
);
CREATE TABLE employers (
    employer_id INT AUTO_INCREMENT PRIMARY KEY,
    company_name VARCHAR(255) NOT NULL,
    company_email VARCHAR(255) UNIQUE NOT NULL,
    company_phone VARCHAR(15),
    company_website VARCHAR(255),
    company_logo VARCHAR(255),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
CREATE TABLE job_skills (
    skill_id INT AUTO_INCREMENT PRIMARY KEY,
    skill_name VARCHAR(255) NOT NULL
);
CREATE TABLE job_skill_mapping (
    job_id INT NOT NULL,
    skill_id INT NOT NULL,
    PRIMARY KEY (job_id, skill_id),
    FOREIGN KEY (job_id) REFERENCES jobs(job_id),
    FOREIGN KEY (skill_id) REFERENCES job_skills(skill_id)
);
CREATE TABLE application_documents (
    document_id INT AUTO_INCREMENT PRIMARY KEY,
    application_id INT NOT NULL,
    document_type ENUM('resume', 'cover letter', 'portfolio') NOT NULL,
    file_path VARCHAR(255) NOT NULL,  -- Path to the document file
    uploaded_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (application_id) REFERENCES applications(application_id)
);
CREATE TABLE application_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    application_id INT NOT NULL,
    status ENUM('pending', 'under review', 'accepted', 'rejected') NOT NULL,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (application_id) REFERENCES applications(application_id)
);