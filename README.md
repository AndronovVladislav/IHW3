# Андронов Владислав Артёмович, БПИ213
# Вариант 32
## Условие задачи
Разработать программу, определяющую корень уравнения $2^{x^2 + 1} + x^2 - 4 = 0$ методом половинного деления с точностью = $0.00001$ в диапазоне $[0; 1]$. Если диапазон некорректен, то подобрать корректный диапазон.
## На 6
### Опции компиляции
**1.1 gcc -O0 -S -fno-asynchronous-unwind-tables -fcf-protection=none pure_c.c -o pure_c.s -lm**

**1.2 gcc -O0 pure_c.s -o pure_c -lm**

**2.2 gcc main.s funcs.s -o my_asm -lm**

Были добавлены комментарии на 4 балла, поясняющие как использование переменных языка Си конвертируется в использование в регистов процессора. Были вручную раскрыты все макросы _leave_. Программа на Си не потребовала изменений для использования локальных переменных, так как не использовала глобальные переменные и функции в ней изначально были написаны с передачей данных через параметры. Также были внесены необходимы комментарии на 5 баллов.

Также добавлен файл, в котором программа значительно переработана. Была незначительно переработана функция _sign_, полностью переписаны функции _f_ и _bisection_solution_, чтобы минимизировать суммарное количество обращений к стеку. Размер объектного файла, порождаемого программой на Си - 16936 байт, размер объектного файла, порождаемого программой, написанной на ассемблере вручную - 16880 байт. Также были внесены необходимы комментарии на 6 баллов.

### Тестовое покрытие на 4
![image](https://user-images.githubusercontent.com/97717897/202545362-a16b5fff-19a0-4746-b772-ff2c96dbde01.png)

### Тестовое покрытие на 6
![image](https://user-images.githubusercontent.com/97717897/202596137-cc01a5c1-5750-497f-8d94-011115752ff7.png)

## На 9
### На 7
Программа на ассемблере осталось разбитой на два модуля main.s и funcs.s. Оба модуля подверглись рефакторингу, в main.s стали использоваться функции fopen, fclose, fscanf и fprintf. Программу запускать с указанием сначала названия файла с вводными данными данными(файл __должен__ существовать), затем названия файла для выходных данных.

### Тестовое покрытие на 7
![image](https://user-images.githubusercontent.com/97717897/202915580-cc05b428-f012-4d27-a639-525581a7bca7.png)

Взглянув на содержимое файлов с тестами и сравнив с предыдущими результатами работы программы, легко видеть, что программа на тех же тестах, что и первоначальная программа, работает корректно.

### На 8
В программу была добавлена возможность запуска в режиме случайного теста. Для этого достаточно запустить скомпилированную программу командой ./filename -r iterations_number, при этом результат работы программы нигде не сохраняется, а в терминал выводится время, потраченное на _iterations_number_ итераций функции _bisection_solution_ в секундах. Работа с файлами осуществляется как прежде. Результаты замеров представлены ниже(500000 итераций, время в секундах).

![image](https://user-images.githubusercontent.com/97717897/202916266-16f51df7-0684-4dba-b774-522a1b1caa58.png)

Из таблицы видно, что обе реализации алгоритма работают очень быстро(порядка O(log(1))), но код на ассемблере имеет чуть большую устойчивость(разброс времени работы меньше).

### На 9
Сравнение ассемблерного файла с файлом на Си, оптимизированном с помощью флагов -O0, -O1, -O2, -O3, -Ofast, -Os:
![image](https://user-images.githubusercontent.com/97717897/202917323-a5654d7d-5eac-48a7-9816-d93a3d886e24.png)

Легко видеть, что флаги -O1/2/3/fast/s дают значительный прирост в скорости выполнения программы по сравнению с -O0, и даже делают программу быстрее написанной вручную, а -O1/s позволяют сделать ассемблерный код короче написанного вручную.

Также видим, что флаги -O1/s и -O2/3 дают одинаковый размер исполняемого файла, меньше, чем размер исполняемого файла, порождаемого ассемблерным кодом, написанным вручную, -Ofast же напротив, заметно повышает размер исполняемого файла, чтобы обеспечить максимальное быстродействие.
