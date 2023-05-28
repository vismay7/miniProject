-- Create Users table
CREATE TABLE Users (
  user_id INT PRIMARY KEY AUTO_INCREMENT,
  full_name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL,
  is_verified BOOLEAN DEFAULT false,
  is_admin BOOLEAN DEFAULT false,
);

-- Create Courses table
CREATE TABLE Courses (
  course_id INT PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(255) NOT NULL,
  category VARCHAR(255),
  subcategory VARCHAR(255),
  is_paid BOOLEAN DEFAULT false,
);

-- Create UserCourses table to track course progress
CREATE TABLE UserCourses (
  user_id INT,
  course_id INT,
  progress INT DEFAULT 0,
  is_completed BOOLEAN DEFAULT false,
  PRIMARY KEY (user_id, course_id),
  FOREIGN KEY (user_id) REFERENCES Users(user_id),
  FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

-- Create Payments table for online payments
CREATE TABLE Payments (
  payment_id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT,
  course_id INT,
  amount DECIMAL(10, 2) NOT NULL,
  payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES Users(user_id),
  FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

-- Create Categories table for course categorization
CREATE TABLE Categories (
  category_id INT PRIMARY KEY AUTO_INCREMENT,
  category_name VARCHAR(255) NOT NULL
);

-- Create Subcategories table for further course classification
CREATE TABLE Subcategories (
  subcategory_id INT PRIMARY KEY AUTO_INCREMENT,
  category_id INT,
  subcategory_name VARCHAR(255) NOT NULL,
  FOREIGN KEY (category_id) REFERENCES Categories(category_id)

);

-- Create Topics table for course content organization
CREATE TABLE Topics (
  topic_id INT PRIMARY KEY AUTO_INCREMENT,
  course_id INT,
  topic_name VARCHAR(255) NOT NULL,
  FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

-- Create Subtopics table for further content subdivision
CREATE TABLE Subtopics (
  subtopic_id INT PRIMARY KEY AUTO_INCREMENT,
  topic_id INT,
  subtopic_name VARCHAR(255) NOT NULL,
  FOREIGN KEY (topic_id) REFERENCES Topics(topic_id)
);

-- Create Videos table to store video files
CREATE TABLE Videos (
  video_id INT PRIMARY KEY AUTO_INCREMENT,
  subtopic_id INT,
  video_url VARCHAR(255) NOT NULL,
  FOREIGN KEY (subtopic_id) REFERENCES Subtopics(subtopic_id)
);

-- Create Files table to store supported files
CREATE TABLE Files (
  file_id INT PRIMARY KEY AUTO_INCREMENT,
  subtopic_id INT,
  file_url VARCHAR(255) NOT NULL,
  FOREIGN KEY (subtopic_id) REFERENCES Subtopics(subtopic_id)
);

-- Create OTPs table for email verification
CREATE TABLE OTPs (
  user_id INT,
  otp_code VARCHAR(255) NOT NULL,
  otp_expiry TIMESTAMP NOT NULL,
  FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Create Admins table for admin users
CREATE TABLE Admins (
  admin_id INT PRIMARY KEY AUTO_INCREMENT,
  user_id INT,
  FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
