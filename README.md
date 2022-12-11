# ИДЗ 3 Лазарев Василий БПИ212 Вариант 1

## Условие задачи
```
Разработать программу, вычисляющую с помощью степенного ряда
с точностью не хуже 0,05% значение функции (1+x)^0.5 для заданного
параметра x
```
Планируемая оценка: ~6

## Решение:

Ограничения на параметр X:
- Елси X = 0, то выводится 1.
- Если введено |X| > 1, то пользователь получает сообщение `Incorrect input, |x| <= 1`.
Сначала вводится параметр X.

1. Изначально [abc3.c](https://github.com/Lapo4kaKek/CSA_IHW3/blob/main/programs/abc3.c) - программа на языке Си
2. Скомпилируем прогу на Си: 
```
gcc abc3.c -lm
```
Добавляем lm, т.к. есть использование функции pow(a, b).

3. Потестим кодик на Си [abc3.c](https://github.com/Lapo4kaKek/CSA_IHW3/blob/main/programs/abc3.c) ([тесты](https://github.com/Lapo4kaKek/CSA_IHW3/tree/main/tests))

![](https://github.com/Lapo4kaKek/CSA_IHW3/blob/main/static/testC.jpeg)

Все тесты прошли

3. Далее была произведена трансформация программы на языке Си с помощью команд, приведенных ниже.
Стандартное ассемблирование:
```
gcc abc3.c -S abc3.s
gcc -c abc3.s -o abc3.o
Затем трансформация с оптимизациями:
gcc -O0 -Wall -masm=intel -S -fno-asynchronous-unwind-tables -fcf-protection=none abc3.c
```

![](https://github.com/Lapo4kaKek/CSA_IHW3/blob/main/static/compil.jpeg)

Изначально была получена следующая программа - [abc3_begin.s](https://github.com/Lapo4kaKek/CSA_IHW3/blob/main/programs/abc3_begin.s)
С оптимизациями получена - [abc3.s](https://github.com/Lapo4kaKek/CSA_IHW3/blob/main/programs/abc3.s)

```
4. Удаляем весь мусор:
    - `	.file	"program.c"` -  информацию о названии файла, из которого программа была получена.
    - Информацию о размере функций:
       ```
        .size	input, .-input
        .size	work, .-work
        .size	output, .-output
        .size	main, .-main
        .size check, .-check
        .size Factorial, .-Factorial
        .size Composition, .-Composition
       ```
    - Информацию об экспорте символов методов:
    
       ```
        .type	input, @function
        .type	work, @function
        .type	check, @function
        .type	Factorial, @function
        .type	Composition, @function
        .type	output, @function
        .type	main, @function
       ```
     - Информацию о трансформации кода в язык ассемблера:
     
       ```
      	.ident	"GCC: (Ubuntu 11.2.1-19ubuntu1) 11.2.1"
	    .section	.note.GNU-stack,"",@progbits
       ```
     - Следующие объявления:
       ```
        .globl	input
        .globl Composition
        .globl Factorial
        .globl work
        .globl	check
        .globl	output
       ```
```
5. Ассемблерный код очищен от лишних директив и макросов, в коде на Си присутствуют локальные переменные и функции для ввода+вывода+поиска последовательности. Использованы регистры.
6. [abc3.s](https://github.com/Lapo4kaKek/CSA_IHW3/blob/main/programs/abc3.s) - закоментировал ассемблерный код
7. Потестим ассемблерную прогу, вдруг что-то сломалось
    
![](https://github.com/Lapo4kaKek/CSA_IHW3/blob/main/static/testAss.jpeg)  
	
Тесты всё также проходят, модификация ассемблерной программмы произведена верно.
