CREATE TABLE job_applied (
    job_id INT,
    application_sent_date DATE,
    custom_resume BOOLEAN,
    resume_file_name VARCHAR(255),
    cover_letter_sent BOOLEAN,
    cover_letter_file_name VARCHAR(255),
    status VARCHAR(50)
);




INSERT INTO job_applied
    (job_id, 
    application_sent_date, 
    custom_resume, 
    resume_file_name, 
    cover_letter_sent, 
    cover_letter_file_name, 
    status)
VALUES (1,
        '2025-01-28',
        TRUE,
        'resume.docx',
        TRUE,
        'cover_letter.docx',
        'Pending'),
        (2,
        '2025-01-26',
        FALSE,
        'resumefile.docx',
        FALSE,
        NULL,
        'Round 1 Interview'),
        (3,
        '2025-01-22',
        TRUE,
        'resume3.docx',
        TRUE,
        'cover_letter3.docx',
        'Ghosted'),
        (4,
        '2025-01-20',
        TRUE,
        'resume4.docx',
        FALSE,
        NULL,
        'Submitted'),
        (5,
        '2025-01-18',
        FALSE,
        'resume5.docx',
        TRUE,
        'cover_letter5.docx',
        'Rejected') 
        ;



ALTER TABLE job_applied
ADD contact VARCHAR(50);


UPDATE job_applied
SET contact = 'Tony Scalese'
WHERE job_id = 1;

UPDATE job_applied
SET contact = 'Big Head'
WHERE job_id = 2;

UPDATE job_applied
SET contact = 'Andy Weir'
WHERE job_id = 3;

UPDATE job_applied
SET contact = 'Pepper Potts'
WHERE job_id = 4;

UPDATE job_applied
SET contact = 'Jeff Daniels'
WHERE job_id = 5;


SELECT * 
FROM job_applied;

ALTER TABLE job_applied
RENAME COLUMN status TO application_status;

ALTER TABLE job_applied
RENAME COLUMN contact TO contact_person;

ALTER TABLE job_applied
ALTER COLUMN contact_person TYPE TEXT;

ALTER TABLE job_applied
DROP COLUMN contact_person;



DROP TABLE job_applied;

