CREATE TABLE Courses (
    course_id INT IDENTITY(1,1) PRIMARY KEY,
    title NVARCHAR(200) NOT NULL,
    description NVARCHAR(MAX),
    author_id INT NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Courses_Author FOREIGN KEY (author_id) REFERENCES Users(user_id) ON DELETE CASCADE
);