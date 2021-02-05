-- Create retirement_titles table
SELECT e.emp_no, e.first_name, e.last_name,
		t.title, t.from_date, t.to_date
INTO retirement_titles
FROM employees e
INNER JOIN titles t ON e.emp_no = t.emp_no
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no


-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;


-- Create Retiring Titles table
SELECT COUNT(*), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT(title) DESC


-- Create a Mentorship Eligibility table

SELECT DISTINCT ON(e.emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date,
		d.from_date, d.to_date,
		t.title
INTO mentorship_eligibilty
FROM employees e
INNER JOIN dept_emp d ON e.emp_no = d.emp_no
INNER JOIN titles t ON e.emp_no = t.emp_no
WHERE (EXTRACT(YEAR FROM d.to_date) = 9999)
AND (EXTRACT(YEAR FROM e.birth_date) = 1965)
ORDER BY e.emp_no 


