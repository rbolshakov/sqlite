1.Найдите потоки,
количество учеников в которых больше или равно 40.В отчет выведите номер потока,
название курса и количество учеников.
SELECT number AS stream_number,
	(
		SELECT name
		FROM courses
		WHERE id
	) AS 'course_name',
	students_amount
FROM streams
WHERE students_amount >= 40;
2.Найдите два потока с самыми низкими значениями успеваемости.В отчет выведите номер потока,
название курса,
фамилию и имя преподавателя (одним столбцом),
оценку успеваемости.
SELECT (
		SELECT number
		FROM streams
		WHERE id = stream_id
	) AS 'stream_number',
	(
		SELECT name
		FROM courses
		WHERE courses.id = (
				SELECT course_id
				FROM streams
				WHERE streams.id = grades.stream_id
			)
	) AS 'course_name',
	(
		SELECT (name || ' ' || surname)
		FROM teachers
		WHERE id = teacher_id
	) AS 'full_name_teacher',
	grade
FROM grades
ORDER BY grade ASC
LIMIT 2;
3.Найдите среднюю успеваемость всех потоков преподавателя Николая Савельева.В отчёт выведите идентификатор преподавателя и среднюю оценку по потокам.
SELECT teacher_id,
	(
		SELECT (name || ' ' || surname)
		FROM teachers
	) AS 'full_name_teacher',
	AVG(grade)
FROM grades
WHERE grades.teacher_id = (
		SELECT id
		FROM teachers
		WHERE surname = 'Савельев'
			AND name = 'Николай'
	);
4.Найдите потоки преподавателя Натальи Петровой,
а также потоки,
по которым успеваемость ниже 4.8.В отчёт выведите идентификатор потока,
фамилию и имя преподавателя.
SELECT (
		SELECT number
		FROM streams
		WHERE id = stream_id
	) AS 'stream_number',
	(
		SELECT (name || ' ' || surname)
		FROM teachers
		WHERE id = teacher_id
	) AS 'full_name_teacher'
FROM grades
WHERE grades.teacher_id = (
		SELECT id
		FROM teachers
		WHERE surname = 'Петрова'
			AND name = 'Наталья'
	)
UNION ALL
SELECT (
		SELECT number
		FROM streams
		WHERE id = stream_id
	) AS 'stream_number',
	(
		SELECT (name || ' ' || surname)
		FROM teachers
		WHERE id = teacher_id
	) AS 'full_name_teacher'
FROM grades
WHERE grade < 4.8;