CREATE DATABASE LibraryDB; 
USE LibraryDB; 

CREATE TABLE Authors ( 
    author_id INT PRIMARY KEY AUTO_INCREMENT, 
    name VARCHAR(255) NOT NULL UNIQUE 
); 
 
CREATE TABLE Books ( 
    book_id INT PRIMARY KEY AUTO_INCREMENT, 
    title VARCHAR(255) NOT NULL, 
    author_id INT, 
    published_year INT CHECK (published_year BETWEEN 1500 AND YEAR(CURDATE())), 
    isbn VARCHAR(50) UNIQUE NOT NULL, 
    quantity INT DEFAULT 1 CHECK (quantity >= 0), 
    FOREIGN KEY (author_id) REFERENCES Authors(author_id) ON DELETE CASCADE 
); 
 
CREATE TABLE Members ( 
    member_id INT PRIMARY KEY AUTO_INCREMENT, 
    name VARCHAR(255) NOT NULL, 
    username VARCHAR(100) UNIQUE NOT NULL, 
    email VARCHAR(255) UNIQUE NOT NULL, 
    phone VARCHAR(20) UNIQUE NOT NULL CHECK (phone REGEXP '^[0-9]{10,15}$'), 
    password_hash VARCHAR(255) NOT NULL, 
    password_set BOOLEAN DEFAULT FALSE 
); 
 
CREATE TABLE Librarians ( 
    librarian_id INT PRIMARY KEY AUTO_INCREMENT, 
    name VARCHAR(255) NOT NULL, 
    username VARCHAR(100) UNIQUE NOT NULL, 
    email VARCHAR(255) UNIQUE NOT NULL, 
    phone VARCHAR(20) UNIQUE NOT NULL CHECK (phone REGEXP '^[0-9]{10,15}$'), 
    password_hash VARCHAR(255) NOT NULL, 
    password_set BOOLEAN DEFAULT FALSE 
); 
 
CREATE TABLE BorrowedBooks ( 
    borrow_id INT PRIMARY KEY AUTO_INCREMENT, 
    book_id INT, 
    member_id INT, 
    borrow_date DATE DEFAULT (CURDATE()), 
    return_date DATE NULL, 
    status ENUM('borrowed', 'returned') DEFAULT 'borrowed', 
    FOREIGN KEY (book_id) REFERENCES Books(book_id) ON DELETE CASCADE, 
    FOREIGN KEY (member_id) REFERENCES Members(member_id) ON DELETE CASCADE 
); 
 