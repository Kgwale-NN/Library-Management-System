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
