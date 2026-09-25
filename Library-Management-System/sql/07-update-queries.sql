-- Mark The Hobbit as borrowed
UPDATE books
SET available = FALSE
WHERE id = 10;

-- Add a new genre to The Hobbit
UPDATE books
SET genres = array_append(genres, 'Adventure')
WHERE id = 10
AND NOT ('Adventure' = ANY(genres));

-- Add The Hobbit to Alice Johnson's borrowed books
UPDATE patrons
SET borrowed_books = array_append(borrowed_books, 10)
WHERE id = 1
AND NOT (10 = ANY(borrowed_books));
