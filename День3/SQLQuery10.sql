-- 1. Вывести всех пользователей
SELECT * FROM Users;
GO

-- 2. Показать список всех курсов с именами их авторов
SELECT
    c.course_id,
    c.title,
    u.username AS author_name
FROM Courses c
JOIN Users u ON c.author_id = u.user_id;
GO

-- 3. Найти все комментарии к конкретному курсу (например, курс с ID 1)
SELECT
    com.comment_id,
    u.username,
    com.content,
    com.created_at
FROM Comments com
JOIN Users u ON com.user_id = u.user_id
WHERE com.course_id = 1;
GO

-- 4. Посчитать, сколько комментариев оставил каждый пользователь
SELECT
    u.user_id,
    u.username,
    COUNT(com.comment_id) AS comment_count
FROM Users u
LEFT JOIN Comments com ON u.user_id = com.user_id
GROUP BY u.user_id, u.username
ORDER BY comment_count DESC;
GO

-- 5. Найти курсы, у которых нет ни одного комментария
SELECT
    c.course_id,
    c.title
FROM Courses c
LEFT JOIN Comments com ON c.course_id = com.course_id
WHERE com.comment_id IS NULL;
GO

-- 6. Показать 5 самых свежих комментариев с именами пользователей и названиями курсов
SELECT TOP 5
    u.username,
    c.title AS course_title,
    com.content,
    com.created_at
FROM Comments com
JOIN Users u ON com.user_id = u.user_id
JOIN Courses c ON com.course_id = c.course_id
ORDER BY com.created_at DESC;
GO

-- 7. Найти пользователей, которые оставили комментарии к курсам, которые они сами не создавали
SELECT DISTINCT
    u.user_id,
    u.username
FROM Comments com
JOIN Users u ON com.user_id = u.user_id
JOIN Courses c ON com.course_id = c.course_id
WHERE u.user_id != c.author_id;
GO

-- 8. Посчитать количество курсов, созданных каждым пользователем
SELECT
    u.user_id,
    u.username,
    COUNT(c.course_id) AS course_count
FROM Users u
LEFT JOIN Courses c ON u.user_id = c.author_id
GROUP BY u.user_id, u.username
ORDER BY course_count DESC;
GO

-- 9. Найти самый комментируемый курс (с количеством комментариев)
SELECT TOP 1
    c.course_id,
    c.title,
    COUNT(com.comment_id) AS comment_count
FROM Courses c
JOIN Comments com ON c.course_id = com.course_id
GROUP BY c.course_id, c.title
ORDER BY comment_count DESC;
GO

-- 10. Вывести пользователей, у которых есть и курсы, и комментарии
SELECT DISTINCT
    u.user_id,
    u.username
FROM Users u
WHERE EXISTS (
    SELECT 1 FROM Courses c WHERE c.author_id = u.user_id
)
AND EXISTS (
    SELECT 1 FROM Comments com WHERE com.user_id = u.user_id
);
GO
