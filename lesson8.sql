-- 1. Найдите общее количество учеников для каждого курса. В отчёт выведите название курса и количество учеников по всем потокам курса. Решите задание с применением оконных функций.
SELECT DISTINCT courses.name AS 'Название курса',
  SUM(streams.students_amount) OVER(PARTITION BY courses.id) AS 'Общее количество учеников по курсам'
FROM courses
  JOIN streams ON courses.id = streams.course_id;
-- 
-- 
-- 
-- 
-- 2. Найдите среднюю оценку по всем потокам для всех учителей. В отчёт выведите идентификатор, фамилию и имя учителя, среднюю оценку по всем проведённым потокам. Учителя, у которых не было потоков, также должны попасть в выборку. Решите задание с применением оконных функций.
SELECT DISTINCT teachers.id AS 'Идентификатор учителя',
  teachers.name || ' ' || teachers.surname AS 'ФИО учителя',
  AVG(grades.grade) OVER(PARTITION BY grades.teacher_id) AS 'Средняя оценка по потокам'
FROM teachers
  LEFT JOIN grades ON teachers.id = grades.teacher_id;
-- 
-- 
-- 
-- 
-- 3. Какие индексы надо создать для максимально быстрого выполнения представленного запроса?
SELECT surname,
  name,
  number,
  performance
FROM academic_performance
  JOIN teachers ON academic_performance.teacher_id = teachers.id
  JOIN streams ON academic_performance.stream_id = streams.id
WHERE number >= 200;
-- ОТВЕТ
CREATE INDEX teachers_surname_name_idx ON teachers(surname, name);
CREATE INDEX streams_perfomance_idx ON streams(perfomance);
CREATE INDEX academic_performance_idx ON academic_performance(perfomance);