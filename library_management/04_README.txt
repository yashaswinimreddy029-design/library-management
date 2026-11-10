COLLEGE LIBRARY MANAGEMENT - SQL PROJECT (Section C)
=====================================================

Name        : Harini M
Register no : U03BV25S0053
Course      : 3rd Sem BCA (Data Science)
Database    : Library_Management_DataBase (MySQL)


1. FOLDER CONTENTS
------------------
library_management/
  |- ERD.png              		my hand-drawn ERD (C1)
  |- Library_Management_DataBase.sql 	creation of all tables
  |- insertion_and_queries.sql   	all queries, C2 to C14, with comments
  |- README.txt            		this file 


2. HOW TO RUN
-------------
1. Install/open MySQL (Workbench or command line).
2. Load the database first:
       SOURCE Library_Management_DataBase.sql;
   This creates librarydb with three tables: members, books, issues.
3. Run the project file:
       SOURCE Library_Management_DataBase.sql;
   Or open it in Workbench and run one query at a time (recommended, so
   each result can be read and checked before moving on).
4. The file begins with USE librarydb; so the right database is selected.

Note: C13 and C14 use DELIMITER because the procedure and trigger bodies
contain semicolons. If you run them in Workbench, run each block as a whole.


3. TABLES USED
--------------
members (member_id, member_name, member_type, joined_date)
books   (book_id, title, author, category, price, copies_available)
issues  (issue_id, member_id, book_id, issue_date, due_date, return_date)

Relationships: members to issues is 1:N, books to issues is 1:N.
return_date is NULL when a book has not been returned yet.
Fine rule: Rs. 2 for every day a book is returned late.


4. WHAT EACH QUERY DOES
-----------------------
C2   Counts the rows in members, books and issues.
C3   Number of titles and total copies in each category.
C4   Top 5 most borrowed books (join issues with books, count, sort, LIMIT 5).
C5   Members who never borrowed (LEFT JOIN with IS NULL, also NOT EXISTS).
C6   Books currently issued: member name, title, due date (return_date IS NULL).
C7   Late returns: days late using DATEDIFF, fine = days late x 2.
C8   Total fine per member, only members with a fine (SUM, GROUP BY, HAVING).
C9   Books borrowed by Students vs Faculty.
C10  Members ranked by books borrowed using RANK().
C11  Number of issues per category, to find the most popular one.
C12  Books with 0 copies available that still have pending issues (subquery).
C13  Stored procedure member_history(member_id) and the CALL used to test it.
C14  Trigger on copies of the tables: inserting into issues_copy reduces
     copies_available in books_copy by 1. The test and result are in the file.

Copies (books_copy, issues_copy) were used for C14 so the original data
stays unchanged.


5. NULL HANDLING
----------------
- Never borrowed (C5): LEFT JOIN keeps all members, and members without any
  issue rows get NULL on the issues side, which IS NULL then picks out.
- Not yet returned (C6, C12): checked with return_date IS NULL.
- Late returns (C7, C8): the condition return_date > due_date automatically
  leaves out unreturned books, because comparing with NULL is never true.


6. WHAT I LEARNED AND PROBLEMS I FACED
--------------------------------------
Through this project, I learned how to create and manage relational databases using MySQL.
I gained practical knowledge of SQL queries, joins, aggregate functions, subqueries and window functions. I also learned how stored procedures and triggers can be used to automate database operations.
This project helped me understand how database concepts can be applied to a real-world library management system.

7. Conclusion
---------------
The Library Management System demonstrates how MySQL can be used to maintain and analyse library records. The queries help identify popular books, members with pending returns and late return fines.
Overall, this mini project helped me improve my practical understanding of database management and SQL.
