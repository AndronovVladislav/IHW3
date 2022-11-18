# Андронов Владислав Артёмович, БПИ213
# Вариант 32
## Условие задачи
Разработать программу, определяющую корень уравнения x<sup>2</sup> 2^{{x^2} + 1} + x^2 − 4 = 0 методом половинного деления с точностью = 0,00001 в диапазоне [0; 1]. Если диапазон некорректен, то подобрать корректный диапазон.
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


## На 7
Функции вынесены в отдельный модуль funcs.s, модуль с функцией main называется main.s. Оба модуля подверглись рефакторингу, в них стали использоваться функции fopen, fclose, fscanf и fprintf. Программу запускать с указанием сначала названия файла с вводными данными данными(файл __должен__ существовать), затем названия файла для выходных данных.

### Тестовое покрытие
![image](https://user-images.githubusercontent.com/97717897/197410836-3ed090e7-1dc4-4a8e-bbee-4529708c37bc.png)

Взглянув на содержимое файлов с тестами и результатами работы программы, легко видеть, что программа на тех же тестах, что и первоначальная программа, работает корректно.

## На 8
В программу была добавлена возможность запуска в режиме случайного теста. Для этого достаточно запустить скомпилированную программу без аргументов, работа с файлами осуществляется как прежде. Замеры по времени имплементированы, как и требуют критерии, в программу на C и на ассемблере, полученную после рефакторинга, то есть в файлы из папки *For_6*. Результаты замеров представлены ниже. В каджой программе функция ___make_new_array___ была выполнена 200'000'000 раз, для того чтобы общее время выполнения было больше одной секунды.
![Screenshot_1](https://user-images.githubusercontent.com/97717897/197063701-395611e7-2c62-4782-8900-e22d35500f56.png)

Диаграмма 1. Программа на C

![Screenshot_4](https://user-images.githubusercontent.com/97717897/197063740-341f7c86-6ddf-46f5-a431-2c6fb8a10810.png)

Диаграмма 2. Программа на ассемблере

Из приведённых диаграмм видно, что оба алгоритма имеют линейную сложность(противное было бы странно), а также то, что хоть программа, написанная на ассемблере вручную, и имеет больший разброс от линии тренда, но работает в несколько раз быстрее, чем скомпилированная с языка C.


### Тестовое покрытие
![image](https://user-images.githubusercontent.com/97717897/197412957-398b7670-be78-4412-97e7-628ea4fa3325.png)
Сравнивая вводные данные и результаты работы программы, понимаем, что она работает правильно.

## На 9
Сравнение ассемблерного файла с файлом на Си, оптимизированном с помощью флагов -O0, -O1, -O2, -O3, -Ofast, -Os:
![image](https://user-images.githubusercontent.com/97717897/197251602-2f0317c2-9542-48dc-809d-e200d4e62415.png)

Справедливости ради, стоит заметить, что в программе на Си используется статическое выделение памяти, а в программе на ассемблере - динамическое. Поэтому ассемблерный код программы на Си мог бы быть короче на какое-то количество строк.

Как видим, флаги -O1/2/3/fast дают значительный прирост в скорости выполнения программы(основной цикл работы также повторяется 200'000'000 раз), некоторые из них делают программу даже быстрее написанной вручную, однако ни один из флагов, кроме -O3(c учётом абзаца выше) не позволяет сделать ассемблерный код короче написанного вручную.

Также видим, что флаги -O0/1/2/3/s дают одинаковый размер исполняемого файла, меньше, чем размер исполняемого файла, порождаемого ассемблерным кодом, написанным вручную, -Ofast же напротив, заметно повышает размер исполняемого файла, чтобы обеспечить максимальное быстродействие.
