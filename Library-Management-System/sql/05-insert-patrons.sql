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
