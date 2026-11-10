USE librarydb;
INSERT INTO members VALUES
(1,  'Aarav Nair',    'Student', '2025-06-10'),
(2,  'Diya Menon',    'Student', '2025-06-12'),
(3,  'Rohan Shetty',  'Student', '2025-07-01'),
(4,  'Meera Iyer',    'Student', '2025-07-03'),
(5,  'Kiran Rao',     'Student', '2025-08-15'),
(6,  'Sneha Kulkarni','Student', '2025-08-20'),
(7,  'Dr. Anil Kumar','Faculty', '2024-01-05'),
(8,  'Prof. Lakshmi', 'Faculty', '2023-11-20'),
(9,  'Dr. Joseph',    'Faculty', '2024-03-18'),
(10, 'Farhan Sheikh', 'Student', '2025-09-02'),
(11, 'Tanvi Gowda',   'Student', '2025-09-10'),
(12, 'Dr. Revathi',   'Faculty', '2024-06-25');

INSERT INTO books VALUES
(1,  'Database System Concepts',     'Silberschatz', 'Computer Science', 650.00, 2),
(2,  'Learning SQL',                 'Alan Beaulieu','Computer Science', 480.00, 0),
(3,  'Python Crash Course',          'Eric Matthes', 'Computer Science', 520.00, 1),
(4,  'Discrete Mathematics',         'Kenneth Rosen','Mathematics',      590.00, 3),
(5,  'Linear Algebra Done Right',    'Sheldon Axler','Mathematics',      450.00, 2),
(6,  'Wings of Fire',                'APJ Abdul Kalam','Biography',      250.00, 0),
(7,  'The Story of My Experiments',  'M. K. Gandhi', 'Biography',        200.00, 2),
(8,  'Malgudi Days',                 'R. K. Narayan','Fiction',          180.00, 4),
(9,  'The God of Small Things',      'Arundhati Roy','Fiction',          320.00, 1),
(10, 'Statistics for Data Science',  'James Miller', 'Data Science',     700.00, 2),
(11, 'Introduction to Machine Learning','Ethem Alpaydin','Data Science', 750.00, 1),
(12, 'Business Communication',       'Meenakshi Raman','Management',     340.00, 3);

INSERT INTO issues VALUES
(1,  1, 2,  '2026-08-01', '2026-08-15', '2026-08-14'),
(2,  1, 3,  '2026-08-20', '2026-09-03', '2026-09-10'),
(3,  1, 10, '2026-09-15', '2026-09-29', '2026-10-05'),
(4,  2, 2,  '2026-08-05', '2026-08-19', '2026-08-25'),
(5,  2, 8,  '2026-09-01', '2026-09-15', '2026-09-14'),
(6,  2, 9,  '2026-10-01', '2026-10-15', NULL),
(7,  3, 1,  '2026-08-10', '2026-08-24', '2026-08-30'),
(8,  3, 2,  '2026-09-05', '2026-09-19', NULL),
(9,  3, 6,  '2026-09-20', '2026-10-04', '2026-10-04'),
(10, 4, 3,  '2026-08-12', '2026-08-26', '2026-08-26'),
(11, 4, 11, '2026-09-10', '2026-09-24', '2026-10-02'),
(12, 5, 6,  '2026-09-12', '2026-09-26', NULL),
(13, 5, 2,  '2026-10-10', '2026-10-24', NULL),
(14, 6, 8,  '2026-08-25', '2026-09-08', '2026-09-07'),
(15, 6, 8,  '2026-09-30', '2026-10-14', '2026-10-12'),
(16, 7, 1,  '2026-07-15', '2026-08-14', '2026-08-10'),
(17, 7, 5,  '2026-08-20', '2026-09-19', '2026-09-30'),
(18, 7, 10, '2026-10-02', '2026-11-01', NULL),
(19, 8, 4,  '2026-08-01', '2026-08-31', '2026-08-29'),
(20, 8, 9,  '2026-09-05', '2026-10-05', '2026-10-01'),
(21, 8, 11, '2026-10-05', '2026-11-04', '2026-11-06'),
(22, 9, 7,  '2026-08-18', '2026-09-17', '2026-09-17'),
(23, 9, 12, '2026-09-25', '2026-10-25', '2026-10-20'),
(24, 10, 2, '2026-10-15', '2026-10-29', NULL),
(25, 10, 3, '2026-10-18', '2026-11-01', NULL),
(26, 10, 6, '2026-08-30', '2026-09-13', '2026-09-20'),
(27, 1,  8, '2026-10-20', '2026-11-03', NULL),
(28, 3, 10,'2026-10-25', '2026-11-08', NULL);

-- ============================================================
-- C2  How many members, books and issue records?
-- COUNT(*) counts rows. One query per table keeps it simple.
-- ============================================================
SELECT COUNT(*) AS total_members FROM members;
SELECT COUNT(*) AS total_books   FROM books;
SELECT COUNT(*) AS total_issues  FROM issues;
 
-- ============================================================
-- C3  Titles and total copies per category
-- COUNT(*) = number of book rows (titles); SUM = add up the copies column.
-- ============================================================
SELECT category,
       COUNT(*) AS titles,
       SUM(copies_available) AS total_copies
FROM books
GROUP BY category;
 
-- ============================================================
-- C4  Top 5 most borrowed books
-- Each row in issues = one borrowing, so count issue rows per book.
-- Group by book_id too, in case two books ever share a title.
-- ============================================================
SELECT b.title,
       COUNT(*) AS times_borrowed
FROM issues i
JOIN books b ON i.book_id = b.book_id
GROUP BY b.book_id, b.title
ORDER BY times_borrowed DESC
LIMIT 5;
-- Viva point: if the 5th and 6th books tie, LIMIT 5 cuts one of them off.
 
 
-- ============================================================
-- C5  Members who never borrowed
-- LEFT JOIN keeps every member. Members with no match in issues get NULLs
-- on the issues side, so "issue_id IS NULL" finds exactly them.
-- ============================================================
SELECT m.member_id, m.member_name
FROM members m
LEFT JOIN issues i ON m.member_id = i.member_id
WHERE i.issue_id IS NULL;
 
-- Same answer with NOT EXISTS (be ready to explain both):
SELECT m.member_id, m.member_name
FROM members m
WHERE NOT EXISTS (SELECT 1 FROM issues i WHERE i.member_id = m.member_id);
 
 
-- ============================================================
-- C6  Books currently issued (not returned)
-- return_date is NULL while the book is out. Use IS NULL, never = NULL.
-- ============================================================
SELECT m.member_name, b.title, i.due_date
FROM issues i
JOIN members m ON i.member_id = m.member_id
JOIN books   b ON i.book_id   = b.book_id
WHERE i.return_date IS NULL;
 
 
-- ============================================================
-- C7  Late returns with days late and fine (Rs. 2 per day)
-- Late = returned AFTER the due date. Unreturned books have NULL
-- return_date, and NULL > due_date is not true, so they drop out here.
-- ============================================================
SELECT i.issue_id,
       m.member_name,
       b.title,
       i.due_date,
       i.return_date,
       DATEDIFF(i.return_date, i.due_date)     AS days_late,
       DATEDIFF(i.return_date, i.due_date) * 2 AS fine_rs
FROM issues i
JOIN members m ON i.member_id = m.member_id
JOIN books   b ON i.book_id   = b.book_id
WHERE i.return_date > i.due_date;
 
 
-- ============================================================
-- C8  Total fine per member (only members with a fine)
-- Same late filter, then add up the fines per member.
-- HAVING filters AFTER grouping; WHERE filters rows BEFORE grouping.
-- ============================================================
SELECT m.member_id,
       m.member_name,
       SUM(DATEDIFF(i.return_date, i.due_date) * 2) AS total_fine_rs
FROM issues i
JOIN members m ON i.member_id = m.member_id
WHERE i.return_date > i.due_date
GROUP BY m.member_id, m.member_name
HAVING SUM(DATEDIFF(i.return_date, i.due_date) * 2) > 0
ORDER BY total_fine_rs DESC;
 
 
-- ============================================================
-- C9  Student vs Faculty usage
-- ============================================================
SELECT m.member_type,
       COUNT(*) AS books_borrowed
FROM issues i
JOIN members m ON i.member_id = m.member_id
GROUP BY m.member_type;
 
 
-- ============================================================
-- C10  Rank members by books borrowed, using RANK()
-- Aggregate first (COUNT per member), then rank the totals.
-- LEFT JOIN so members with 0 borrowings still show up (COUNT(i.issue_id)
-- counts 0 for them, COUNT(*) would wrongly give 1).
-- RANK gives ties the same number and skips the next (1,2,2,4).
-- ============================================================
SELECT m.member_name,
       COUNT(i.issue_id) AS books_borrowed,
       RANK() OVER (ORDER BY COUNT(i.issue_id) DESC) AS borrow_rank
FROM members m
LEFT JOIN issues i ON m.member_id = i.member_id
GROUP BY m.member_id, m.member_name
ORDER BY borrow_rank;
 
 
-- ============================================================
-- C11  Issues per category (most popular first)
-- ============================================================
SELECT b.category,
       COUNT(*) AS number_of_issues
FROM issues i
JOIN books b ON i.book_id = b.book_id
GROUP BY b.category
ORDER BY number_of_issues DESC;
 
 
-- ============================================================
-- C12  Zero copies available AND still pending issues (subquery)
-- Inner query: books that are out right now. Outer query keeps only
-- those with no copies left.
-- ============================================================
SELECT book_id, title, copies_available
FROM books
WHERE copies_available = 0
  AND book_id IN (SELECT book_id FROM issues WHERE return_date IS NULL);
 
 
-- ============================================================
-- C13  Stored procedure: member_history(member_id)
-- DELIMITER changes the statement terminator so the ; inside the
-- procedure body doesn't end the CREATE early.
-- ============================================================
DROP PROCEDURE IF EXISTS member_history;
 
DELIMITER //
CREATE PROCEDURE member_history(IN p_member_id INT)
BEGIN
    SELECT b.title,
           b.author,
           i.issue_date,
           i.due_date,
           i.return_date
    FROM issues i
    JOIN books b ON i.book_id = b.book_id
    WHERE i.member_id = p_member_id
    ORDER BY i.issue_date;
END //
DELIMITER ;
 
-- Test:
CALL member_history(1);
 
 
-- ============================================================
-- C14  Trigger on COPIES of the tables (originals stay safe)
-- AFTER INSERT on issues_copy: reduce copies_available in books_copy
-- by 1 for the book in the new row (NEW.book_id).
-- ============================================================
DROP TABLE IF EXISTS issues_copy;
DROP TABLE IF EXISTS books_copy;
CREATE TABLE books_copy  AS SELECT * FROM books;
CREATE TABLE issues_copy AS SELECT * FROM issues;
 
DROP TRIGGER IF EXISTS trg_reduce_copies;
 
DELIMITER //
CREATE TRIGGER trg_reduce_copies
AFTER INSERT ON issues_copy
FOR EACH ROW
BEGIN
    UPDATE books_copy
    SET copies_available = copies_available - 1
    WHERE book_id = NEW.book_id;
END //
DELIMITER ;
 
-- Test: check, insert, check again. Book 4 should go from 3 to 2.
SELECT book_id, title, copies_available FROM books_copy WHERE book_id = 4;
 
INSERT INTO issues VALUES (29, 4, 4, '2026-11-10', '2026-11-24', NULL);
 
SELECT book_id, title, copies_available FROM books_copy WHERE book_id = 4;
 