CourseManagementSystem - Servlet & JSP Course Management
=====================================================

**Project**
- Name: CourseManagementSystem
- Type: Java Servlet + JSP web application (no build tool detected)
- Purpose: A simple online course management system for a lab assignment.

**Description**
This project implements an online Course Management System using Java Servlets and JSP pages. It supports three user roles: student, teacher, and admin. Core features:

- Authentication (login/logout). Registration page is provided but optional.
- Admin: add new courses and assign a teacher to a course.
- Student: register for courses and view registered courses.
- Teacher: view the list of students registered for their courses.

**Files / Structure (key paths)**
- `src/main/java/com/cms/dao` - data access objects: `CourseDAO.java`, `DBConnection.java`, `RegistrationDAO.java`, `UserDAO.java`
- `src/main/java/com/cms/model` - model classes: `Course.java`, `Registration.java`, `User.java`
- `src/main/java/com/cms/servlet` - servlets: `AdminServlet.java`, `LoginServlet.java`, `LogoutServlet.java`, `RegisterServlet.java`, `StudentServlet.java`, `TeacherServlet.java`
- `src/main/webapp` - JSP pages: `admin.jsp`, `index.jsp`, `login.jsp`, `register.jsp`, `student.jsp`, `teacher.jsp`

**Requirements / Prerequisites**
- JDK 8 or newer
- Apache Tomcat 8+ (or any servlet container compatible with your JDK)
- MySQL (or another relational DB) and a JDBC driver on the classpath
- An IDE such as Eclipse (project is structured as a dynamic web project)

**Database schema (example)**
Create a database (e.g., `cmsdb`) and run these SQL statements as a starting point:

```sql
CREATE DATABASE cmsdb;
USE cmsdb;

CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(100) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  role VARCHAR(20) NOT NULL -- 'admin', 'teacher', 'student'
);

CREATE TABLE courses (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  teacher_id INT, 
  FOREIGN KEY (teacher_id) REFERENCES users(id)
);

CREATE TABLE registrations (
  id INT AUTO_INCREMENT PRIMARY KEY,
  course_id INT NOT NULL,
  student_id INT NOT NULL,
  FOREIGN KEY (course_id) REFERENCES courses(id),
  FOREIGN KEY (student_id) REFERENCES users(id)
);

-- Sample users
INSERT INTO users (username, password, role) VALUES ('admin','adminpass','admin');
INSERT INTO users (username, password, role) VALUES ('teacher1','teacherpass','teacher');
INSERT INTO users (username, password, role) VALUES ('student1','studentpass','student');

-- Sample course (assign teacher by id after checking user ids)
INSERT INTO courses (name, teacher_id) VALUES ('Intro to Java', 2);
```

Note: Passwords in sample SQL are plain text for convenience. In a real deployment, use hashed passwords and secure storage.

**Configure database connection**
- Open `src/main/java/com/cms/dao/DBConnection.java` and update the JDBC URL, username and password to match your MySQL instance. Example values to replace:

```
jdbc:mysql://localhost:3306/cmsdb
username: root
password: <your-db-password>
```

If the project already bundles a JDBC driver under `WEB-INF/lib`, ensure it matches your database (for MySQL use `mysql-connector-java`).

**Import & deploy (Eclipse + Tomcat)**
1. Open Eclipse -> File -> Import -> Existing Projects into Workspace and select the project folder.
2. Make sure the project is a Dynamic Web Project (set Targeted Runtimes to your Tomcat).
3. Add the JDBC driver JAR to `WEB-INF/lib` if not present.
4. Update `DBConnection.java` with your DB details.
5. Right-click project -> Run As -> Run on Server and choose your Tomcat instance.

**Build & deploy (manual WAR)**
- If you prefer to create a WAR manually, export the project as a WAR from Eclipse and drop it into Tomcat's `webapps` folder, then start Tomcat.

**How to use**
- Open `http://localhost:8080/<context>/` in your browser.
- Login using the sample users or create accounts via `register.jsp` (if enabled).
- Use the admin account to create courses and assign teachers.
- Students can register for courses from `student.jsp`.
- Teachers can view registered students from `teacher.jsp`.

**Notes & limitations**
- This is a lab/demo project. It is not production-ready: no password hashing, limited input validation, and minimal error handling.
- The UI uses basic JSP — you can enhance it with Bootstrap or client-side frameworks.

**Next steps / Improvements**
- Add password hashing (bcrypt) and input validation.
- Add pagination and search for courses.
- Add role-based authorization filters.

**Author / Assignment**
- Lab: Servlet Project (Course Management System)
- Created for instructional/demo purposes.
