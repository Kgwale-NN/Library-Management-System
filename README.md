# Library Management System

A PostgreSQL project for managing books, authors, and library patrons. It demonstrates database tables, relationships, foreign keys, arrays, CRUD operations, joins, filtering, searching, and bulk updates.

## Features

- Add and view books, authors, and patrons.
- Find a book by title.
- Find books by a specific author.
- Find available books.
- Mark a book as borrowed or returned.
- Add genres to a book.
- Update a patron's borrowed books.
- Delete books and authors.
- Run advanced search and bulk-update queries.

## Technologies

- PostgreSQL 18
- pgAdmin 4 or `psql`
- SQL

## Installation

### Windows

1. Open the [official PostgreSQL Windows download page](https://www.postgresql.org/download/windows/).
2. Download and run the Windows installer.
3. Keep these components selected:
   - PostgreSQL Server
   - pgAdmin 4
   - Command Line Tools
4. Create and remember a password for the `postgres` user.
5. Keep the default port `5432`.
6. Complete the installation. Stack Builder is not required for this project.

### macOS

1. Open the [official PostgreSQL macOS download page](https://www.postgresql.org/download/macosx/).
2. Install PostgreSQL using the interactive installer or Homebrew.
3. Install pgAdmin if you want to use a graphical interface.
4. Confirm that the PostgreSQL server is running.

### Linux

1. Open the [official PostgreSQL Linux download page](https://www.postgresql.org/download/linux/).
2. Select your Linux distribution and follow its installation instructions.
3. Install pgAdmin or use the `psql` command-line tool.
4. Confirm that the PostgreSQL service is running.

### Connect pgAdmin to PostgreSQL

1. Open pgAdmin 4.
2. Select **Add New Server**.
3. Enter `PostgreSQL` as the server name.
4. Open the **Connection** tab and enter:

```text
Host name/address: 127.0.0.1
Port: 5432
Maintenance database: postgres
Username: postgres
Password: the password created during installation
```

5. Click **Save**.

To check a command-line installation, run:

```bash
psql --version
```

## Project Structure

```text
Library-Management-System/
└── sql/
    ├── 01-create-database.sql
    ├── 02-create-tables.sql
    ├── 03-insert-authors.sql
    ├── 04-insert-books.sql
    ├── 05-insert-patrons.sql
    ├── 06-read-queries.sql
    ├── 07-update-queries.sql
    ├── 08-delete-queries.sql
    └── 09-advanced-queries.sql
```

## Database Tables

### Authors

Stores each author's name, nationality, birth year, and death year.

### Books

Stores each book's title, author, genres, publication year, and availability. The `author_id` foreign key connects each book to an author.

### Patrons

Stores each patron's name, unique email address, and an array of borrowed book IDs.

## Run the Project with pgAdmin

1. Install PostgreSQL and pgAdmin.
2. Open pgAdmin and connect to the PostgreSQL server.
3. Select the default `postgres` database and open **Tools → Query Tool**.
4. Open and execute `01-create-database.sql`.
5. Refresh **Databases** and select `librarydb`.
6. Open a new Query Tool connected to `librarydb`.
7. Execute the remaining files in number order, from `02` to `09`.

> Run the database, table, and sample-data scripts only once. Running them again without resetting the database can produce "already exists" or duplicate-key errors.

## Run the Project with psql

Open a terminal in the repository root and run:

```powershell
psql -U postgres -f Library-Management-System/sql/01-create-database.sql
psql -U postgres -d librarydb -f Library-Management-System/sql/02-create-tables.sql
psql -U postgres -d librarydb -f Library-Management-System/sql/03-insert-authors.sql
psql -U postgres -d librarydb -f Library-Management-System/sql/04-insert-books.sql
psql -U postgres -d librarydb -f Library-Management-System/sql/05-insert-patrons.sql
psql -U postgres -d librarydb -f Library-Management-System/sql/06-read-queries.sql
psql -U postgres -d librarydb -f Library-Management-System/sql/07-update-queries.sql
psql -U postgres -d librarydb -f Library-Management-System/sql/08-delete-queries.sql
psql -U postgres -d librarydb -f Library-Management-System/sql/09-advanced-queries.sql
```

Enter the PostgreSQL password when requested.

## SQL Commands

### Create the Database

```sql
CREATE DATABASE librarydb;
```

### Create the Tables

```sql
CREATE TABLE authors (
    id INTEGER PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    nationality VARCHAR(50) NOT NULL,
    birth_year INTEGER NOT NULL,
    death_year INTEGER
);

CREATE TABLE books (
    id INTEGER PRIMARY KEY,
    title VARCHAR(200) NOT NULL UNIQUE,
    author_id INTEGER NOT NULL,
    genres TEXT[] NOT NULL,
    published_year INTEGER NOT NULL,
    available BOOLEAN NOT NULL DEFAULT TRUE,
    FOREIGN KEY (author_id) REFERENCES authors(id) ON DELETE CASCADE
);

CREATE TABLE patrons (
    id INTEGER PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    borrowed_books INTEGER[] NOT NULL DEFAULT ARRAY[]::INTEGER[]
);
```

`ON DELETE CASCADE` means deleting an author also deletes books connected to that author.

### Insert Authors

```sql
INSERT INTO authors (id, name, nationality, birth_year, death_year) VALUES
    (1, 'George Orwell', 'British', 1903, 1950),
    (2, 'Harper Lee', 'American', 1926, 2016),
    (3, 'F. Scott Fitzgerald', 'American', 1896, 1940),
    (4, 'Aldous Huxley', 'British', 1894, 1963),
    (5, 'J.D. Salinger', 'American', 1919, 2010),
    (6, 'Herman Melville', 'American', 1819, 1891),
    (7, 'Jane Austen', 'British', 1775, 1817),
    (8, 'Leo Tolstoy', 'Russian', 1828, 1910),
    (9, 'Fyodor Dostoevsky', 'Russian', 1821, 1881),
    (10, 'J.R.R. Tolkien', 'British', 1892, 1973);
```

### Insert Books

```sql
INSERT INTO books (id, title, author_id, genres, published_year, available) VALUES
    (1, '1984', 1, ARRAY['Dystopian', 'Political Fiction'], 1949, TRUE),
    (2, 'To Kill a Mockingbird', 2, ARRAY['Southern Gothic', 'Bildungsroman'], 1960, TRUE),
    (3, 'The Great Gatsby', 3, ARRAY['Tragedy'], 1925, TRUE),
    (4, 'Brave New World', 4, ARRAY['Dystopian', 'Science Fiction'], 1932, TRUE),
    (5, 'The Catcher in the Rye', 5, ARRAY['Realist Novel', 'Bildungsroman'], 1951, TRUE),
    (6, 'Moby-Dick', 6, ARRAY['Adventure Fiction'], 1851, TRUE),
    (7, 'Pride and Prejudice', 7, ARRAY['Romantic Novel'], 1813, TRUE),
    (8, 'War and Peace', 8, ARRAY['Historical Novel'], 1869, TRUE),
    (9, 'Crime and Punishment', 9, ARRAY['Philosophical Novel'], 1866, TRUE),
    (10, 'The Hobbit', 10, ARRAY['Fantasy'], 1937, TRUE);
```

### Insert Patrons

```sql
INSERT INTO patrons (id, name, email, borrowed_books) VALUES
    (1, 'Alice Johnson', 'alice@example.com', ARRAY[]::INTEGER[]),
    (2, 'Bob Smith', 'bob@example.com', ARRAY[1, 2]),
    (3, 'Carol White', 'carol@example.com', ARRAY[]::INTEGER[]),
    (4, 'David Brown', 'david@example.com', ARRAY[3]),
    (5, 'Eve Davis', 'eve@example.com', ARRAY[]::INTEGER[]),
    (6, 'Frank Moore', 'frank@example.com', ARRAY[4, 5]),
    (7, 'Grace Miller', 'grace@example.com', ARRAY[]::INTEGER[]),
    (8, 'Hank Wilson', 'hank@example.com', ARRAY[6]),
    (9, 'Ivy Taylor', 'ivy@example.com', ARRAY[]::INTEGER[]),
    (10, 'Jack Anderson', 'jack@example.com', ARRAY[7, 8]);
```

### Read Data

```sql
SELECT * FROM books;

SELECT * FROM books
WHERE title = '1984';

SELECT books.*
FROM books
JOIN authors ON books.author_id = authors.id
WHERE authors.name = 'George Orwell';

SELECT * FROM books
WHERE available = TRUE;
```

### Update Data

```sql
UPDATE books
SET available = FALSE
WHERE id = 10;

UPDATE books
SET genres = array_append(genres, 'Adventure')
WHERE id = 10
AND NOT ('Adventure' = ANY(genres));

UPDATE patrons
SET borrowed_books = array_append(borrowed_books, 10)
WHERE id = 1
AND NOT (10 = ANY(borrowed_books));
```

### Delete Data

```sql
DELETE FROM books
WHERE title = 'Crime and Punishment';

DELETE FROM authors
WHERE id = 9;
```

### Advanced Queries

```sql
SELECT * FROM books
WHERE published_year > 1950;

SELECT * FROM authors
WHERE nationality = 'American';

UPDATE books
SET available = TRUE;

SELECT * FROM books
WHERE available = TRUE
AND published_year > 1950;

SELECT * FROM authors
WHERE name ILIKE '%George%';

UPDATE books
SET published_year = published_year + 1
WHERE published_year = 1869;
```

## Learning Outcomes

- Create PostgreSQL databases and tables.
- Use primary keys, foreign keys, defaults, and unique values.
- Store multiple values with PostgreSQL arrays.
- Add, read, update, and delete records.
- Connect related tables with `JOIN`.
- Filter data with `WHERE`, `AND`, `ILIKE`, and comparison operators.
- Update multiple records with one command.

## Author

Created by Kgwale-NN.
