-- DROP DATABASE `coursera`;

-- create a database;

CREATE DATABASE `coursera`;

-- use a coursera database

USE `coursera`;

CREATE TABLE
    User (
        id INT PRIMARY KEY AUTO_INCREMENT,
        fullname VARCHAR(255),
        email VARCHAR(255) UNIQUE,
        password VARCHAR(255),
        is_verified BOOLEAN,
        is_admin BOOLEAN DEFAULT false,
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
        FOREIGN KEY (category_id) REFERENCES Category (id)
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
        is_free BOOLEAN,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        FOREIGN KEY (category_id) REFERENCES Category (id),
        FOREIGN KEY (subcategory_id) REFERENCES Subcategory (id)
    );

-- Create the CartItem table

CREATE TABLE
    CartItem (
        id INT PRIMARY KEY AUTO_INCREMENT,
        user_id INT,
        course_id INT,
        quantity INT,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        FOREIGN KEY (user_id) REFERENCES User (id),
        FOREIGN KEY (course_id) REFERENCES Course (id)
    );

-- Create the Enrollment table

CREATE TABLE
    Enrollment (
        id INT PRIMARY KEY AUTO_INCREMENT,
        user_id INT,
        course_id INT,
        enrolled_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        progress INT,
        FOREIGN KEY (user_id) REFERENCES User (id),
        FOREIGN KEY (course_id) REFERENCES Course (id)
    );

-- Create the Payment table

CREATE TABLE
    Payment (
        id INT PRIMARY KEY AUTO_INCREMENT,
        user_id INT,
        course_id INT,
        amount DECIMAL(10, 2),
        paid_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (user_id) REFERENCES User (id),
        FOREIGN KEY (course_id) REFERENCES Course (id)
    );

-- Create the OTP table

CREATE TABLE
    OTP (
        id INT PRIMARY KEY AUTO_INCREMENT,
        user_id INT,
        otp VARCHAR(255),
        expires_at TIMESTAMP,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (user_id) REFERENCES User (id)
    );

-- Create the Topic table

CREATE TABLE
    Topic (
        id INT PRIMARY KEY AUTO_INCREMENT,
        course_id INT,
        title VARCHAR(255),
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        FOREIGN KEY (course_id) REFERENCES Course (id)
    );

-- Create the Subtopic table

CREATE TABLE
    Subtopic (
        id INT PRIMARY KEY AUTO_INCREMENT,
        topic_id INT,
        title VARCHAR(255),
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        FOREIGN KEY (topic_id) REFERENCES Topic (id)
    );

-- Create the File table

CREATE TABLE
    File (
        id INT PRIMARY KEY AUTO_INCREMENT,
        subtopic_id INT,
        filename VARCHAR(255),
        filepath VARCHAR(255),
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        FOREIGN KEY (subtopic_id) REFERENCES Subtopic (id)
    );

-- Create the Order table

CREATE TABLE
    Orders (
        id INT PRIMARY KEY AUTO_INCREMENT,
        user_id INT,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        FOREIGN KEY (user_id) REFERENCES User (id)
    );

-- Create the OrderItem table

CREATE TABLE
    OrderItem (
        id INT PRIMARY KEY AUTO_INCREMENT,
        order_id INT,
        course_id INT,
        quantity INT,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        FOREIGN KEY (order_id) REFERENCES Orders (id),
        FOREIGN KEY (course_id) REFERENCES Course (id)
    );

-- Insert dummy data into the Category table

INSERT INTO Category (name)
VALUES ('Category 1'), ('Category 2'), ('Category 3');

-- Insert dummy data into the Subcategory table

INSERT INTO
    Subcategory (name, category_id)
VALUES ('Subcategory 1', 1), ('Subcategory 2', 1), ('Subcategory 3', 2);

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
        'password',
        1,
        0
    ), (
        'Jane Smith',
        'jane@example.com',
        'password',
        1,
        1
    );

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
        'Course 1',
        'Description for Course 1',
        1,
        1,
        49.99,
        0
    ), (
        'Course 2',
        'Description for Course 2',
        2,
        2,
        29.99,
        0
    ), (
        'Course 3',
        'Description for Course 3',
        1,
        1,
        0,
        1
    );

-- Insert dummy data into the Topic table

INSERT INTO
    Topic (course_id, title)
VALUES (1, 'Topic 1'), (1, 'Topic 2'), (2, 'Topic 1');

-- Insert dummy data into the Subtopic table

INSERT INTO
    Subtopic (topic_id, title)
VALUES (1, 'Subtopic 1'), (1, 'Subtopic 2'), (2, 'Subtopic 1');

-- Insert dummy data into the File table

INSERT INTO
    File (
        subtopic_id,
        filename,
        filepath
    )
VALUES (1, 'File 1', '/path/to/file1'), (1, 'File 2', '/path/to/file2'), (2, 'File 3', '/path/to/file3');

-- Insert dummy data into the Enrollment table

INSERT INTO
    Enrollment (
        user_id,
        course_id,
        enrolled_at,
        progress
    )
VALUES (1, 1, NOW (), 50), (1, 2, NOW (), 30), (2, 1, NOW (), 70);

-- Insert dummy data into the Payment table

INSERT INTO
    Payment (
        user_id,
        course_id,
        amount,
        paid_at
    )
VALUES (1, 3, 99.99, NOW ()), (2, 2, 79.99, NOW ());

-- Insert dummy data into the User table for cart items

INSERT INTO
    CartItem (user_id, course_id, quantity)
VALUES (1, 1, 2), (2, 2, 1);

-- Insert dummy data into the OrderTable table

INSERT INTO `Orders` (user_id) VALUES (1), (2);

-- Insert dummy data into the OrderItem table

INSERT INTO
    OrderItem (order_id, course_id, quantity)
VALUES (1, 1, 1), (1, 2, 2), (2, 2, 1);

-- get all categories

SELECT
    c.id AS category_id,
    c.name AS category_name,
    JSON_ARRAYAGG (
        JSON_OBJECT ('id', s.id, 'name', s.name)
    ) AS subcategories
FROM Category c
    LEFT JOIN Subcategory s ON c.id = s.category_id
GROUP BY c.id, c.name;

-- user enrolled course

SELECT
    u.id AS user_id,
    u.fullname AS user_fullname,
    u.email AS user_email,
    JSON_ARRAYAGG (
        JSON_OBJECT (
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

-- user paymeny HISTORY

SELECT
    u.id AS user_id,
    u.fullname AS user_fullname,
    u.email AS user_email,
    JSON_ARRAYAGG (
        JSON_OBJECT (
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

-- get User cart

SELECT
    u.id AS user_id,
    u.fullname AS user_fullname,
    u.email AS user_email,
    JSON_ARRAYAGG (
        JSON_OBJECT (
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

-- delete a cart course according to USER

DELETE FROM CartItem WHERE user_id = 1 AND course_id = 2;

-- delete a enrolled course according to USER

DELETE FROM Enrollment WHERE user_id = 1 AND course_id = 1;

-- get all course details

SELECT
    c.id AS course_id,
    c.title AS course_title,
    c.description AS course_description,
    c.price AS course_price,
    c.is_free AS course_is_free,
    cat.name AS category_name,
    subcat.name AS subcategory_name,
    JSON_ARRAYAGG (
        JSON_OBJECT (
            'topic_id',
            t.id,
            'topic_title',
            t.title,
            'subtopics', (
                SELECT
                    JSON_ARRAYAGG (
                        JSON_OBJECT (
                            'subtopic_id',
                            st.id,
                            'subtopic_title',
                            st.title
                        )
                    )
                FROM
                    Subtopic st
                WHERE
                    st.topic_id = t.id
            )
        )
    ) AS topics,
    JSON_ARRAYAGG (
        JSON_OBJECT (
            'file_id',
            f.id,
            'file_name',
            f.filename,
            'file_path',
            f.filepath
        )
    ) AS files
FROM Course c
    JOIN Category cat ON c.category_id = cat.id
    JOIN Subcategory subcat ON c.subcategory_id = subcat.id
    LEFT JOIN Topic t ON c.id = t.course_id
    LEFT JOIN File f ON t.id = f.subtopic_id
GROUP BY c.id;

-- get a perticular course details

SELECT
    c.id AS course_id,
    c.title AS course_title,
    c.description AS course_description,
    c.price AS course_price,
    c.is_free AS course_is_free,
    cat.name AS category_name,
    subcat.name AS subcategory_name,
    JSON_ARRAYAGG (
        JSON_OBJECT (
            'topic_id',
            t.id,
            'topic_title',
            t.title,
            'subtopics', (
                SELECT
                    JSON_ARRAYAGG (
                        JSON_OBJECT (
                            'subtopic_id',
                            st.id,
                            'subtopic_title',
                            st.title
                        )
                    )
                FROM
                    Subtopic st
                WHERE
                    st.topic_id = t.id
            )
        )
    ) AS topics,
    JSON_ARRAYAGG (
        JSON_OBJECT (
            'file_id',
            f.id,
            'file_name',
            f.filename,
            'file_path',
            f.filepath
        )
    ) AS files
FROM Course c
    JOIN Category cat ON c.category_id = cat.id
    JOIN Subcategory subcat ON c.subcategory_id = subcat.id
    LEFT JOIN Topic t ON c.id = t.course_id
    LEFT JOIN File f ON t.id = f.topic_id
WHERE c.id = 1
GROUP BY c.id;

-- get all payment and users also

SELECT
    u.id as user_id,
    u.fullname as user_fullname,
    u.email as user_password,
    c.title as course_title,
    -- c.price as course_price,
    CASE
        WHEN c.is_free = 1 THEN "Free"
        ELSE c.price
    END as course_price,
    c.description as course_description,
    p.amount as course_payment,
    p.paid_at as payment_paid_at
from `User` u
    LEFT JOIN `Payment` p ON u.id = p.user_id
    LEFT JOIN `Course` c ON c.id = p.course_id;

-- get All Orders

SELECT
    u.id as user_id,
    u.fullname as user_fullname,
    u.email as user_email,
    u.is_verified as user_verified,
    SUM(c.price) as order_total_amount,
    JSON_ARRAYAGG (
        JSON_OBJECT (
            "course_title",
            c.title,
            "course_price",
            c.price
        )
    ) as course_details
from `User` u
    LEFT JOIN `Orders` o ON o.user_id = u.id
    LEFT JOIN `OrderItem` oi ON o.id = oi.order_id
    INNER JOIN `Course` c ON oi.course_id = c.id
GROUP BY u.id;

SELECT
    c.id as category_id,
    s.id as subcategory_id
FROM coursera.`Category` c
    INNER JOIN coursera.`Subcategory` s ON c.id = s.category_id
WHERE
    s.name = "Subcategory 2" && c.name = "Category 1";

SELECT * from coursera.`Subcategory`;


SELECT o.id,u.fullname,u.email,JSON_ARRAYAGG(JSON_OBJECT("course_id",c.id,"course_title",c.title,"course_description",c.description)) as course_details FROM coursera.`Orders` o LEFT JOIN `OrderItem` oi ON o.id=oi.order_id LEFT JOIN `User` u ON u.id=o.user_id JOIN `Course` c ON c.id=oi.course_id GROUP BY o.id;

SELECT o.id,u.fullname,u.email,JSON_ARRAYAGG(JSON_OBJECT("course_id",c.id,"course_title",c.title,"course_description",c.description)) as course_details FROM coursera.`Orders` o LEFT JOIN `OrderItem` oi ON o.id=oi.order_id LEFT JOIN `User` u ON u.id=o.user_id JOIN `Course` c ON c.id=oi.course_id WHERE u.id=2 GROUP BY o.id;

DELETE from Orders o JOIN OrderItem oi ON o.id=oi.order_id WHERE o.id = 1