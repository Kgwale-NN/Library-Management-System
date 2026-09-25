-- Find books published after 1950
SELECT * FROM books
WHERE published_year > 1950;

-- Find all American authors
SELECT * FROM authors
WHERE nationality = 'American';

-- Set all books as available
UPDATE books
SET available = TRUE;

-- Find available books published after 1950
SELECT * FROM books
WHERE available = TRUE
AND published_year > 1950;

-- Find authors whose names contain George
SELECT * FROM authors
WHERE name ILIKE '%George%';

-- Increment the published year 1869 by 1
UPDATE books
SET published_year = published_year + 1
WHERE published_year = 1869;
