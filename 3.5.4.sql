'Посчитать, сколько студентов относится к каждой группе. Столбцы назвать Группа, Интервал, Количество. Указать границы интервала.'
WITH temp AS ('ранжирование по кол-ву пройденных шагов'
  SELECT student_name, rate, 
    CASE
        WHEN rate <= 10 THEN "I"
        WHEN rate <= 15 THEN "II"
        WHEN rate <= 27 THEN "III"
        ELSE "IV"
    END AS Группа
FROM      
    ('Считаем сколько шагов прошел студент'
     SELECT student_name, count(*) as rate
     FROM 
         ('Вывод студентов прошедших шаги обучения'
          SELECT student_name, step_id
          FROM 
              student 
              INNER JOIN step_student USING(student_id)
          WHERE result = "correct"
          GROUP BY student_name, step_id
         ) query_in
     GROUP BY student_name 
     ORDER BY 2
     ) query_in )
'Запрос на вывод итоговой таблицы'
SELECT Группа,
    CASE
        WHEN Группа='I' then 'от 0 до 10'
        WHEN Группа='II' then 'от 11 до 15'
        WHEN Группа='III' then 'от 16 до 27'
        ELSE 'больше 27'
    END AS Интервал,
    COUNT(*) AS Количество
FROM temp
GROUP BY Группа, Интервал
