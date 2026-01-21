
-- create
CREATE TABLE Authors (
    author_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    country VARCHAR(50)
);

 CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    genre VARCHAR(50),
    price DECIMAL(10,2),
    author_id INT,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id)
);

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Order_Details (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    book_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);


-- insert
INSERT INTO Authors VALUES
(1, 'J.K. Rowling', 'UK'),
(2, 'George R.R. Martin', 'USA'),
(3, 'Haruki Murakami', 'Japan');

INSERT INTO Books VALUES
(1, 'Harry Potter', 'Fantasy', 20.99, 1),
(2, 'Game of Thrones', 'Fantasy', 25.99, 2),
(3, 'Norwegian Wood', 'Fiction', 15.49, 3);

INSERT INTO Customers VALUES
(1, 'Alice', 'alice@gmail.com'),
(2, 'Bob', 'bob@yahoo.com'),
(3, 'Charlie', 'charlie@hotmail.com');

INSERT INTO Orders VALUES
(1, 1, '2023-12-01'),
(2, 2, '2023-12-02');

INSERT INTO Order_Details VALUES
(1, 1, 1, 2),
(2, 2, 2, 1),
(3, 2, 3, 1);

-- fetch 
select * from Authors;
select * from Books;
select * from Customers;
select * from Orders;




SELECT o.order_id,
       c.name AS customer_name,
       b.title AS book_title
       
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN Order_Details od ON o.order_id = od.order_id
JOIN Books b ON od.book_id = b.book_id;


SELECT a.name AS author_name,
       SUM(b.price * od.quantity) AS total_revenue
FROM Authors a
JOIN Books b ON a.author_id = b.author_id
JOIN Order_Details od ON b.book_id = od.book_id
GROUP BY a.name;

SELECT name
FROM Authors
WHERE author_id = (
    SELECT author_id
    FROM Books
    WHERE price = (SELECT MAX(price) FROM Books)
);

SELECT c.name
FROM Customers c
WHERE c.customer_id IN (
    SELECT o.customer_id
    FROM Orders o
    JOIN Order_Details od ON o.order_id = od.order_id
    JOIN Books b ON od.book_id = b.book_id
    GROUP BY o.customer_id
    HAVING COUNT(DISTINCT b.genre) > 1
);











