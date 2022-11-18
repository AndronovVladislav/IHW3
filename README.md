# Андронов Владислав Артёмович, БПИ213
# Вариант 32
## Условие задачи
Разработать программу, определяющую корень уравнения $2^{x^2 + 1} + x^2 - 4 = 0$ методом половинного деления с точностью = $0.00001$ в диапазоне $[0; 1]$. Если диапазон некорректен, то подобрать корректный диапазон.
## На 6
### Опции компиляции
**1.1. gcc pure_c.c -lm**

**1.2 gcc -S pure_c.c -o pure_c.s -lm**

**2.2 gcc main.s funcs.s**

Были добавлены комментарии, поясняющие как использование переменных языка Си конвертируется в использование в регистов процессора. Были вручную раскрыты все макросы _leave_. Программа на Си не потребовала изменений для использования локальных переменных, так как не использовала глобальные переменные и функции в ней изначально были написаны с передачей данных через параметры. Также были внесены необходимы комментарии на 5 баллов.

Также добавлен файл, в котором программа частично переработана. Слегка переработана функция _sign_, полностью переписана функция _f_, а вот функция _bisection_solution_ не была затронута, так как в коде не было замечено мест, в которых можно провести значительные оптимизации.

### Тестовое покрытие на 4
![image](https://user-images.githubusercontent.com/97717897/202545362-a16b5fff-19a0-4746-b772-ff2c96dbde01.png)

### Тестовое покрытие на 6
![image](https://user-images.githubusercontent.com/97717897/202596137-cc01a5c1-5750-497f-8d94-011115752ff7.png)

## На 9
### На 7
Программа на ассемблере осталось разбитой на два модуля main.s и funcs.s. Оба модуля подверглись рефакторингу, в main.s стали использоваться функции fopen, fclose, fscanf и fprintf. Программу запускать с указанием сначала названия файла с вводными данными данными(файл __должен__ существовать), затем названия файла для выходных данных.

### Тестовое покрытие на 7
![image](https://user-images.githubusercontent.com/97717897/202731898-6042a247-af1f-44e1-870e-4581faec4407.png)

Взглянув на содержимое файлов с тестами и сравнив с предыдущими результатами работы программы, легко видеть, что программа на тех же тестах, что и первоначальная программа, работает корректно.

### На 8
В программу была добавлена возможность запуска в режиме случайного теста. Для этого достаточно запустить скомпилированную программу командой ./filename -r file_for_output.txt, при этом результат работы программы записывается в file_for_output.txt, а в терминал выводится настоящее время работы функции _bisection_solution_, легко сопоставимое с 1 секундой. Работа с файлами осуществляется как прежде. Замеры по времени имплементированы, как и требуют критерии, в программу на C и на ассемблере, полученную после рефакторинга, то есть в файлы из папки *For_6*. Результаты замеров представлены ниже.

![image](https://user-images.githubusercontent.com/97717897/202732960-dff53a86-508f-4013-97e3-84a0b907265b.png)

Из таблицы видно, что обе реализации алгоритма работают очень быстро($O(log_2(1))$), но код на ассемблере имеет большую устойчивость(разбор времени работы меньше).

Также стоит отметить, что при разных запусках программы в режиме случайного теста могут выводиться одинаковые числа, так как стандартный генератор случайных чисел в Си имеет ограниченную случайность.

## На 9
Сравнение ассемблерного файла с файлом на Си, оптимизированном с помощью флагов -O0, -O1, -O2, -O3, -Ofast, -Os:
![image](https://user-images.githubusercontent.com/97717897/197251602-2f0317c2-9542-48dc-809d-e200d4e62415.png)

Справедливости ради, стоит заметить, что в программе на Си используется статическое выделение памяти, а в программе на ассемблере - динамическое. Поэтому ассемблерный код программы на Си мог бы быть короче на какое-то количество строк.

Как видим, флаги -O1/2/3/fast дают значительный прирост в скорости выполнения программы(основной цикл работы также повторяется 200'000'000 раз), некоторые из них делают программу даже быстрее написанной вручную, однако ни один из флагов, кроме -O3(c учётом абзаца выше) не позволяет сделать ассемблерный код короче написанного вручную.

Также видим, что флаги -O0/1/2/3/s дают одинаковый размер исполняемого файла, меньше, чем размер исполняемого файла, порождаемого ассемблерным кодом, написанным вручную, -Ofast же напротив, заметно повышает размер исполняемого файла, чтобы обеспечить максимальное быстродействие.
