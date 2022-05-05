-- 1. Создайте представление, которое для каждого курса выводит название, номер последнего потока, дату начала обучения последнего потока и среднюю успеваемость курса по всем потокам.
CREATE VIEW streams_info AS
SELECT courses.name AS 'Название курса',
  MAX(streams.number) AS 'Номер последнего потока',
  streams.started_at AS 'Дата начала обучения',
  AVG(grades.grade) AS 'asdf'
FROM courses
  JOIN streams ON courses.id = streams.course_id
  JOIN grades ON streams.id = grades.stream_id
GROUP BY courses.name
ORDER BY streams.started_at DESC;
-- 2. Удалите из базы данных всю информацию, которая относится к преподавателю с идентификатором, равным 3. Используйте транзакцию.
BEGIN TRANSACTION;
DELETE FROM grades
WHERE teacher_id = 3;
DELETE FROM teachers
WHERE id = 3;
COMMIT;
-- 3. Создайте триггер для таблицы успеваемости, который проверяет значение успеваемости на соответствие диапазону чисел от 0 до 5 включительно.
CREATE TRIGGER check_grade BEFORE
INSERT ON grades BEGIN
SELECT CASE
    WHEN CAST((NEW.grade) AS INTEGER) NOT BETWEEN 0 AND 5 THEN RAISE(
      ABORT,
      'Неверная оценка, введите в правильном формате'
    )
  END;
END;