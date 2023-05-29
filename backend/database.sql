-- create a database;
CREATE DATABASE `coursera`;

-- use a coursera database
USE `coursera`;

-- Create the User table
CREATE TABLE
    User (
        id INT PRIMARY KEY AUTO_INCREMENT,
        fullname VARCHAR(255),
        email VARCHAR(255),
        password VARCHAR(255),
        is_verified TINYINT(1),
        is_admin TINYINT(1),
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

-- Create the Category table
CREATE TABLE
    Category (
        id INT PRIMARY KEY AUTO_INCREMENT,
        name VARCHAR(255),
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

-- Create the Subcategory table

CREATE TABLE
    Subcategory (
        id INT PRIMARY KEY AUTO_INCREMENT,
        name VARCHAR(255),
        category_id INT,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        FOREIGN KEY (category_id) REFERENCES Category(id)
    );

-- Create the Course table
CREATE TABLE
    Course (
        id INT PRIMARY KEY AUTO_INCREMENT,
        title VARCHAR(255),
        description TEXT,
        category_id INT,
        subcategory_id INT,
        price DECIMAL(10, 2),
        is_free TINYINT(1),
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        FOREIGN KEY (category_id) REFERENCES Category(id),
        FOREIGN KEY (subcategory_id) REFERENCES Subcategory(id)
    );

-- Create the Enrollment table
CREATE TABLE
    Enrollment (
        id INT PRIMARY KEY AUTO_INCREMENT,
        user_id INT,
        course_id INT,
        enrolled_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        progress INT,
        FOREIGN KEY (user_id) REFERENCES User(id),
        FOREIGN KEY (course_id) REFERENCES Course(id)
    );

-- Create the Payment table
CREATE TABLE
    Payment (
        id INT PRIMARY KEY AUTO_INCREMENT,
        user_id INT,
        course_id INT,
        amount DECIMAL(10, 2),
        paid_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (user_id) REFERENCES User(id),
        FOREIGN KEY (course_id) REFERENCES Course(id)
    );

-- Create the OTP table
CREATE TABLE
    OTP (
        id INT PRIMARY KEY AUTO_INCREMENT,
        user_id INT,
        otp VARCHAR(255),
        expires_at TIMESTAMP,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (user_id) REFERENCES User(id)
    );

-- Create the Topic table
CREATE TABLE
    Topic (
        id INT PRIMARY KEY AUTO_INCREMENT,
        course_id INT,
        title VARCHAR(255),
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        FOREIGN KEY (course_id) REFERENCES Course(id)
    );

-- Create the Subtopic table
CREATE TABLE
    Subtopic (
        id INT PRIMARY KEY AUTO_INCREMENT,
        topic_id INT,
        title VARCHAR(255),
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        FOREIGN KEY (topic_id) REFERENCES Topic(id)
    );

-- Create the File table
CREATE TABLE
    File (
        id INT PRIMARY KEY AUTO_INCREMENT,
        topic_id INT,
        filename VARCHAR(255),
        filepath VARCHAR(255),
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        FOREIGN KEY (topic_id) REFERENCES Topic(id)
    );

-- Create the CartItem table
CREATE TABLE
    CartItem (
        id INT PRIMARY KEY AUTO_INCREMENT,
        user_id INT,
        course_id INT,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        FOREIGN KEY (user_id) REFERENCES User(id),
        FOREIGN KEY (course_id) REFERENCES Course(id)
    );

-- Insert dummy data into the User table
INSERT INTO
    User (
        fullname,
        email,
        password,
        is_verified,
        is_admin
    )
VALUES (
        'John Doe',
        'john@example.com',
        'password123',
        1,
        0
    ), (
        'Jane Smith',
        'jane@example.com',
        'password456',
        1,
        0
    ), (
        'Admin User',
        'admin@example.com',
        'adminpassword',
        1,
        1
    );

-- Insert dummy data into the Category table
INSERT INTO Category (name)
VALUES ('Technology'), ('Business'), ('Art');

-- Insert dummy data into the Subcategory table
INSERT INTO
    Subcategory (name, category_id)
VALUES ('Web Development', 1), ('Data Science', 1), ('Marketing', 2), ('Painting', 3);

-- Insert dummy data into the Course table
INSERT INTO
    Course (
        title,
        description,
        category_id,
        subcategory_id,
        price,
        is_free
    )
VALUES (
        'Introduction to HTML',
        'Learn the basics of HTML programming.',
        1,
        1,
        49.99,
        0
    ), (
        'Python for Data Analysis',
        'Master Python for data analysis and visualization.',
        1,
        2,
        79.99,
        0
    ), (
        'Digital Marketing Fundamentals',
        'Discover the essentials of digital marketing strategies.',
        2,
        3,
        99.99,
        0
    ), (
        'Introduction to Acrylic Painting',
        'Learn the fundamentals of acrylic painting techniques.',
        3,
        4,
        0,
        1
    );

-- Insert dummy data into the Enrollment table
INSERT INTO
    Enrollment (
        user_id,
        course_id,
        enrolled_at,
        progress
    )
VALUES (1, 1, NOW(), 50), (1, 2, NOW(), 30), (2, 1, NOW(), 70);

-- Insert dummy data into the Payment table
INSERT INTO
    Payment (
        user_id,
        course_id,
        amount,
        paid_at
    )
VALUES (1, 3, 99.99, NOW()), (2, 2, 79.99, NOW());

-- Insert dummy data into the OTP table
INSERT INTO
    OTP (user_id, otp, expires_at)
VALUES (
        1,
        '123456',
        NOW() + INTERVAL 1 HOUR
    ), (
        2,
        '654321',
        NOW() + INTERVAL 1 HOUR
    );

-- Insert dummy data into the Topic table
INSERT INTO
    Topic (course_id, title)
VALUES (1, 'Introduction to HTML'), (2, 'Python Basics'), (2, 'Data Manipulation');

-- Insert dummy data into the Subtopic table
INSERT INTO
    Subtopic (topic_id, title)
VALUES (1, 'HTML Syntax'), (1, 'HTML Elements'), (2, 'Variables'), (2, 'Conditional Statements');

-- Insert dummy data into the File table
INSERT INTO
    File (topic_id, filename, filepath)
VALUES (
        1,
        'HTML_Syntax.pdf',
        '/files/html_syntax.pdf'
    ), (
        2,
        'Variables.py',
        '/files/variables.py'
    );

-- Insert dummy data into the CartItem table
INSERT INTO
    CartItem (user_id, course_id)
VALUES (1, 1), (1, 2), (2, 3);

--get all categories
SELECT
    c.id AS category_id,
    c.name AS category_name,
    JSON_ARRAYAGG(
        JSON_OBJECT('id', s.id, 'name', s.name)
    ) AS subcategories
FROM Category c
    LEFT JOIN Subcategory s ON c.id = s.category_id
GROUP BY c.id, c.name;

--user enrolled course
SELECT
    u.id AS user_id,
    u.fullname AS user_fullname,
    u.email AS user_email,
    JSON_ARRAYAGG(
        JSON_OBJECT(
            'course_id',
            c.id,
            'course_title',
            c.title,
            'course_description',
            c.description,
            'course_category',
            cat.name,
            'course_subcategory',
            subcat.name,
            'course_price',
            c.price,
            'course_is_free',
            c.is_free,
            'enrollment_progress',
            e.progress
        )
    ) AS enrolled_courses
FROM User u
    JOIN Enrollment e ON u.id = e.user_id
    JOIN Course c ON e.course_id = c.id
    JOIN Category cat ON c.category_id = cat.id
    JOIN Subcategory subcat ON c.subcategory_id = subcat.id
WHERE u.id = 1
GROUP BY u.email;

--user paymeny HISTORY
SELECT
    u.id AS user_id,
    u.fullname AS user_fullname,
    u.email AS user_email,
    JSON_ARRAYAGG(
        JSON_OBJECT(
            'payment_id',
            p.id,
            'course_id',
            c.id,
            'course_title',
            c.title,
            'payment_amount',
            p.amount,
            'payment_date',
            p.paid_at
        )
    ) AS payment_history
FROM User u
    JOIN Payment p ON u.id = p.user_id
    JOIN Course c ON p.course_id = c.id
WHERE u.id = 1
GROUP BY u.email;

--get User cart
SELECT
    u.id AS user_id,
    u.fullname AS user_fullname,
    u.email AS user_email,
    JSON_ARRAYAGG(
        JSON_OBJECT(
            'cart_item_id',
            ci.id,
            'course_id',
            c.id,
            'course_title',
            c.title,
            'course_description',
            c.description,
            'course_category',
            cat.name,
            'course_subcategory',
            subcat.name,
            'course_price',
            c.price,
            'course_is_free',
            c.is_free
        )
    ) AS cart_items
FROM User u
    JOIN CartItem ci ON u.id = ci.user_id
    JOIN Course c ON ci.course_id = c.id
    JOIN Category cat ON c.category_id = cat.id
    JOIN Subcategory subcat ON c.subcategory_id = subcat.id
WHERE u.id = 1
GROUP BY u.email;

--delete a cart course according to USER
DELETE FROM CartItem WHERE user_id = 1 AND course_id = 2;

--delete a enrolled course according to USER
DELETE FROM Enrollment WHERE user_id = 1 AND course_id = 1;
