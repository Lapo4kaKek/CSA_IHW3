	.intel_syntax noprefix                # Синтаксис интел
	.text                                 #
.LC0:                                       # Метка .LC0
	.string	"%lf"                       # формат числа с плавающей точкой
	.text                               #
input:                                        # функция по вводу значения Х
	push	rbp                           # Пролог функции (1 из 3) Сохранили предыдущий рбп на стек
	mov	rbp, rsp                      # Пролог функции (2 из 3) вместе рбп записали рсп
	sub	rsp, 16                       # Пролог функции (3 из 3) Сдвинули рсп на 16 байта
	mov	rax, QWORD PTR fs:40          #
	mov	QWORD PTR -8[rbp], rax        # rbp[-8], rax
	xor	eax, eax                      # более быстрый способ установки eax на 0
	lea	rax, -16[rbp]                 # rax := rbp[-16]
	mov	rsi, rax                      # rsi := rax
	lea	rax, .LC0[rip]                # rax := rip[.LC0]
	mov	rdi, rax                      # rdi:= rax
	mov	eax, 0                        # eax := 0
	call	__isoc99_scanf@PLT            # вызов scanf
	movsd	xmm0, QWORD PTR -16[rbp]      # копирует двойное слово из ячейки памяти по адресу xmm0
	movq	rax, xmm0                     # rax = rax/xmm0
	mov	rdx, QWORD PTR -8[rbp]        # rdx := rbp[-8]
	sub	rdx, QWORD PTR fs:40          #
	je	.L3                           # если равен 1 то переход к метке
	call	__stack_chk_fail@PLT          # указание компиляции
.L3:                                        # метка .L3
	movq	xmm0, rax                   # xmm0 = xmm0/rax
	leave                               #
	ret                                 # 
output:                                       # функция output
	push	rbp                           # Пролог функции (1 из 3) Сохранили рбп на стек
	mov	rbp, rsp                      # Пролог функции (2 из 3) Вместо рбп записали рсп
	sub	rsp, 16                       # Пролог функции (3 из 3) Сдвинули рсп на 16 байт
	movsd	QWORD PTR -8[rbp], xmm0       # копирует двойное слово из ячейки памяти по адресу
	mov	rax, QWORD PTR -8[rbp]        # rax := rbp[-8]
	movq	xmm0, rax                     # xmm0 /= rax 
	lea	rax, .LC0[rip]                # 
	mov	rdi, rax                      # rdi := rax
	mov	eax, 1                        # eax := 1
	call	printf@PLT                    # вызов printf
	nop                                   # Инструкция предписывает ничего не делать
	leave                                 #
	ret                                   #
check:                                           # Функция output
	push	rbp                              # Пролог функции (1 из 2) Сохранили рбп на стек
	mov	rbp, rsp                         # Пролог функции (2 из 2) Вместо рбп записали рсп
	movsd	QWORD PTR -24[rbp], xmm0         # копирует двойное слово из ячейки памяти по адресу rbp[-24]
	movsd	QWORD PTR -32[rbp], xmm1         # копирует двойное слово из ячейки памяти по адресу rbp[-32]
	movsd	xmm0, QWORD PTR -24[rbp]         # копирует двойное слово из ячейки памяти по адресу xmm0
	movsd	xmm1, QWORD PTR .LC1[rip]        # копирует двойное слово из ячейки памяти по адресу xmm1
	divsd	xmm0, xmm1                       # Делит значение с плавающей запятой низкой двойной точки. Конечный операнд - регистр ХММ
	movsd	QWORD PTR -8[rbp], xmm0          # копирует двойное слово из ячейки памяти по адресу xmm0
	movsd	xmm0, QWORD PTR -24[rbp]         # копирует двойное слово из ячейки памяти по адресу xmm0
	subsd	xmm0, QWORD PTR -32[rbp]         # Вычесть скалярное значение с плавающей точкой
	movq	xmm1, QWORD PTR .LC2[rip]        # xmm1 := xmm1/rip[.Lc2]
	andpd	xmm0, xmm1                       # 
	comisd	xmm0, QWORD PTR -8[rbp]          # Сравнить упорядоченно одиночные короткие вещ. значения и установить EFLAGS по сравнению
	jbe	.L10                             # Команда условного перехода (если первый операнд меньше второго)
	mov	eax, 1                           # eax := 1
	jmp	.L8                              # перейти к метке .L8
.L10:                       # метка .L10
	mov	eax, -1     # eax:= -1
.L8:                     # метка .L8
	pop	rbp      # извлечь операнд из стека
	ret              #
Factorial:                                  # функция по подсчету факториала
	push	rbp                         # Закидываем операнд в стек
	mov	rbp, rsp                    # rbp := rsp
	movsd	QWORD PTR -24[rbp], xmm0    # копирует двойное слово из ячейки памяти
	movsd	xmm0, QWORD PTR .LC3[rip]   # копирует двойное слово из ячейки памяти
	movsd	QWORD PTR -8[rbp], xmm0     # копирует двойное слово из ячейки памяти
	mov	DWORD PTR -12[rbp], 1       # rbp[-12] := 1
	jmp	.L12                        # переход к метке .L12
.L13:                                               # метка .L13
	pxor	xmm0, xmm0                          # побитная операция исключающая "ИЛИ" над 64 битами xmm0 xmm0
	cvtsi2sd	xmm0, DWORD PTR -12[rbp]    # Преобразует целое число в значение с плавающей точкой
	movsd	xmm1, QWORD PTR -8[rbp]             # копирует двойное слово из ячейки памяти
	mulsd	xmm0, xmm1                          # xmm0 *= xmm1
	movsd	QWORD PTR -8[rbp], xmm0             # копирует двойное слово из ячейки памяти
	add	DWORD PTR -12[rbp], 1               # целочисленое сложение rbp[-12] и 1 (rbp[-12]+=1)
.L12:                                              # .L12
	pxor	xmm1, xmm1                         # побитная операция исключающая "ИЛИ" над 64 битами xmm0 xmm0
	cvtsi2sd	xmm1, DWORD PTR -12[rbp]   # Преобразует целое число в значение с плавающей точкой
	movsd	xmm0, QWORD PTR -24[rbp]           # копирует двойное слово из ячейки памяти
	comisd	xmm0, xmm1                         # Сравнить упорядоченно одиночные короткие вещ. значения и установить EFLAGS по сравнению
	jnb	.L13                               # Если операнд не меньше второго то переход к метке 13
	movsd	xmm0, QWORD PTR -8[rbp]            # 
	movq	rax, xmm0                          # rax := rax / xmm0
	movq	xmm0, rax                          # xmm0 := xmm0/rax
	pop	rbp                                # извлечь операнд из стека
	ret                                        #
composition:                                  # Вызов функции Composition
	push	rbp                           # Пролог функции (1 из 2) Сохранили рбп на стек
	mov	rbp, rsp                      # Пролог функции (2 из 2) Вместо рбп записали рсп
	movsd	QWORD PTR -24[rbp], xmm0      #  перемещаем 8 байт в младшие 64 бита, зануляя 64 старших xmm0
	movsd	QWORD PTR -32[rbp], xmm1      # перемещаем 8 байт в младшие 64 бита, зануляя 64 старших xmm1
	movsd	xmm0, QWORD PTR .LC3[rip]     # перемещаем 8 байт в младшие 64 бита, зануляя 64 старших
	movsd	QWORD PTR -8[rbp], xmm0       # перемещаем 8 байт в младшие 64 бита, зануляя 64 старших xmm0
	mov	DWORD PTR -12[rbp], 0         # rbp[-12] := 0
	jmp	.L16                          # переход к 16-ой метке 
.L17:                                                # Метка .L17
	pxor	xmm1, xmm1                           # побитная операция исключающая "ИЛИ" над 64 битами xmm1 xmm1
	cvtsi2sd	xmm1, DWORD PTR -12[rbp]     # Преобразует целое число в значение с плавающей точкой
	movsd	xmm0, QWORD PTR -24[rbp]             #
	subsd	xmm0, xmm1                           # вычесть скалярное значение с плавающей запятой двойной точности
	movsd	xmm1, QWORD PTR -8[rbp]              # копирует двойное слово из ячейки памяти
	mulsd	xmm0, xmm1                           # Умножает исходный операнд на операнд назначения (xmm0 *= xmm1)
	movsd	QWORD PTR -8[rbp], xmm0              # копирует двойное слово из ячейки памяти
	add	DWORD PTR -12[rbp], 1                # Целочисленое сложение rbp[-12] и 1 (rbp[-12]+=1)
.L16:                                              # метка .L16
	pxor	xmm0, xmm0                         # побитная операция исключающая "ИЛИ" над 64 битами xmm0 xmm0
	cvtsi2sd	xmm0, DWORD PTR -12[rbp]   # Преобразует целое число в значение с плавающей точкой
	ucomisd	xmm0, QWORD PTR -32[rbp]           #
	jp	.L17                               # переходит если четность (PF=1) к заданному адресу (в данном случае 17 метка)
	ucomisd	xmm0, QWORD PTR -32[rbp]           # неупорядоченное сравнение скалярных значений и установка EFGLAGS
	jne	.L17                               # переход если не равно
	movsd	xmm0, QWORD PTR -8[rbp]            # копирует двойное слово из ячейки памяти
	movq	rax, xmm0                          # rax:= xmm0
	movq	xmm0, rax                          # xmm0:=rax
	pop	rbp                                # извлечь операнд из стека
	ret
work:                                              # функция степенного ряда
	push	rbp                                # Пролог функции (1 из 3) Сохранили предыдущий рбп на стек
	mov	rbp, rsp                           # Пролог функции (2 из 3) Вместо рбп записали рсп
	sub	rsp, 64                            # пролог фукнкции (3 из 3) Сдвинули рсп на 64 байта
	movsd	QWORD PTR -40[rbp], xmm0           # перемещает скалярное значение с xmm0
	pxor	xmm0, xmm0                         # побитная операция исключающая "ИЛИ" над 64 битами xmm0 xmm0
	movsd	QWORD PTR -32[rbp], xmm0           # перемещает скалярное значение с xmm0
	movsd	xmm0, QWORD PTR .LC5[rip]          # перемещаем 8 байт в младшие 64 бита 
	movsd	QWORD PTR -8[rbp], xmm0            # перемещаем 8 байт в младшие 64 бита 
	movsd	xmm0, QWORD PTR -8[rbp]            # перемещаем 8 байт в младшие 64 бита 
	movapd	xmm1, xmm0                         #
	mulsd	xmm1, QWORD PTR -40[rbp]           # xmm1 *= rbp[-40]
	movsd	xmm0, QWORD PTR .LC3[rip]          #
	addsd	xmm1, xmm0                         # добавить скалярное значение xmm0
	movsd	QWORD PTR -48[rbp], xmm1           #
	movsd	xmm0, QWORD PTR -8[rbp]            #
	movsd	xmm1, QWORD PTR .LC3[rip]          #
	subsd	xmm0, xmm1                         # вычесть второе значение с плавающей запятой из первого (xmm0 -= xmm1)
	mulsd	xmm0, QWORD PTR -8[rbp]            # xmm0 *= rbp[-8]
	movsd	QWORD PTR -56[rbp], xmm0           #
	movsd	xmm0, QWORD PTR .LC6[rip]          #
	mov	rax, QWORD PTR -40[rbp]            # rax := rbp[-40]
	movapd	xmm1, xmm0                         #
	movq	xmm0, rax                          # Копируем 64 разряда из операнда-источника в xmm0
	call	pow@PLT                            # вызов функции возведения в степень
	mulsd	xmm0, QWORD PTR -56[rbp]           # xmm0 *= rbp[-56]
	movsd	xmm1, QWORD PTR .LC6[rip]          # перемещаем 8 байт в младшие 64 бита 
	divsd	xmm0, xmm1                         # xmm0 /= xmm1
	addsd	xmm0, QWORD PTR -48[rbp]           # добавить скалярное значение
	movsd	QWORD PTR -48[rbp], xmm0           #
	movsd	xmm0, QWORD PTR -8[rbp]            #
	movsd	xmm1, QWORD PTR .LC3[rip]          #
	subsd	xmm0, xmm1                         # xmm0 -= xmm1
	movapd	xmm1, xmm0                         # перемещение выровненных упакованных значений с плавающей запятой
	mulsd	xmm1, QWORD PTR -8[rbp]            # xmm1 *= rbp[-8]
	movsd	xmm0, QWORD PTR -8[rbp]            #
	movsd	xmm2, QWORD PTR .LC6[rip]          #
	subsd	xmm0, xmm2                         # перемещение выровненных упакованных значений с плавающей запятой
	mulsd	xmm1, xmm0                         # xmm1 *= xmm0
	movsd	QWORD PTR -56[rbp], xmm1           #
	movsd	xmm0, QWORD PTR .LC7[rip]          #
	mov	rax, QWORD PTR -40[rbp]            # rax := rbp[-40]
	movapd	xmm1, xmm0                         # перемещение выровненных упакованных значений с плавающей запятой
	movq	xmm0, rax                          # Копируем 64 разряда из операнда-источника в операнд-назначение
	call	pow@PLT                            # вызов функции возведения в степень
	mulsd	xmm0, QWORD PTR -56[rbp]           # xmm0 *= rbp[-56]
	movsd	xmm1, QWORD PTR .LC8[rip]          # перемещаем 8 байт в младшие 64 бита 
	divsd	xmm0, xmm1                         # xmm0 /= xmm1
	addsd	xmm0, QWORD PTR -48[rbp]           # добавить скалярное значение k xmm0 rbp[-48]
	movsd	xmm1, QWORD PTR -32[rbp]           # move or merge scalar double
	addsd	xmm0, xmm1                         # добавить скалярное значение xmm0
	movsd	QWORD PTR -32[rbp], xmm0           # move or merge scalar double
	movsd	xmm0, QWORD PTR -32[rbp]           #
	addsd	xmm0, xmm0                         # добавить скалярное значение xmm0
	movsd	QWORD PTR -24[rbp], xmm0           #
	movsd	xmm0, QWORD PTR .LC9[rip]          #
	movsd	QWORD PTR -16[rbp], xmm0           # перемещаем 8 байт в младшие 64 бита в xmm0
	jmp	.L22                               # Переход к метке 22
.L23:                                         # метка .L23
	movsd	xmm0, QWORD PTR -32[rbp]      # перемещаем байт rbp[-32] в xmm0
	movsd	QWORD PTR -24[rbp], xmm0      # перемещаем байт xmm0 в rbp[-24]
	movsd	xmm0, QWORD PTR -16[rbp]      # перемещаем байт rbp[-16] в xmm0
	mov	rax, QWORD PTR .LC5[rip]      # rax:= rip[.Lc5]
	movapd	xmm1, xmm0                    # movapd - более быстрая операция чем movsd
	movq	xmm0, rax                     # Копируем 64 разряда из операнда-источника в xmm0
	call	composition                   # вызов функции composition (произведение в числителе)
	movsd	QWORD PTR -48[rbp], xmm0      #
	movsd	xmm0, QWORD PTR -16[rbp]      # 
	mov	rax, QWORD PTR -40[rbp]       # rax := rbp[-40]
	movapd	xmm1, xmm0                    #
	movq	xmm0, rax                     #
	call	pow@PLT                       # вызов pow (возведение в степень)
	movapd	xmm3, xmm0                    #
	mulsd	xmm3, QWORD PTR -48[rbp]      # xmm3 *= rbp[-48]
	movsd	QWORD PTR -48[rbp], xmm3      #
	mov	rax, QWORD PTR -16[rbp]       # rax := rbp[-16]
	movq	xmm0, rax                     #
	call	Factorial                     # вызов функции подсчета факториала
	movsd	xmm1, QWORD PTR -48[rbp]      #
	divsd	xmm1, xmm0                    # xmm1 /= xmm0
	movsd	xmm0, QWORD PTR -32[rbp]      #
	addsd	xmm0, xmm1                    #
	movsd	QWORD PTR -32[rbp], xmm0      #
	movsd	xmm1, QWORD PTR -16[rbp]      #
	movsd	xmm0, QWORD PTR .LC3[rip]     #
	addsd	xmm0, xmm1                    # xmm0 += xmm1
	movsd	QWORD PTR -16[rbp], xmm0      #
.L22:                                        # метка .L22
	movsd	xmm0, QWORD PTR -24[rbp]     #
	mov	rax, QWORD PTR -32[rbp]      # rax := rbp[-32]
	movapd	xmm1, xmm0                   # перемещение упакованных значений xmm1 в xmm0
	movq	xmm0, rax                    # 
	call	check                        # вызов функции check (проверка на точность)
	test	eax, eax                     #
	jg	.L23                         # если первый операнд больше второго, то переход
	movsd	xmm0, QWORD PTR -32[rbp]     #
	movq	rax, xmm0                    # Копируем 64 разряда из rax в xmm0 
	movq	xmm0, rax                    # Копируем 64 разряда из xmm0 в rax 
	leave                                #
	ret                                  #
	.section	.rodata
.LC11:  
	.string	"Incorrect input, |x| <= 1"  # сообещние при некорректном вводе
.LC12:
	.string	"%s"                          # формат = строка
.LC13:
	.string	"%d"                     # формат - целое число
	.text
	.globl	main                     # указываем точку входа
main:                                      # основная функция программы
	push	rbp                        # Пролог (1 из 3) размещаем рбп на стек
	mov	rbp, rsp                   # Пролог (2 из 3) Вместо рбп записали рсп
	sub	rsp, 16                    # Пролог (3 из 3) сдвинули рсп на 16 байт
	mov	eax, 0                     # eax:=0
	call	input                      # вызов функции input 
	movq	rax, xmm0                  # rax := xmm0
	mov	QWORD PTR -16[rbp], rax    # rbp[-16] := rax
	movsd	xmm0, QWORD PTR .LC10[rip] #
	comisd	xmm0, QWORD PTR -16[rbp]   # Сравнить упорядоченно одиночные короткие вещ. значения и установить EFLAGS по сравнению
	ja	.L26                       # переход в 26 метку
	movsd	xmm0, QWORD PTR -16[rbp]   #
	movsd	xmm1, QWORD PTR .LC3[rip]  #
	comisd	xmm0, xmm1                 # Сравнить упорядоченно одиночные короткие вещ. значения и установить EFLAGS по сравнению
	jbe	.L37                       # если первый меньше или равен то в 37 метку
.L26:                               # .L26
	lea	rax, .LC11[rip]     #
	mov	rsi, rax            # rsi := rax
	lea	rax, .LC12[rip]     #
	mov	rdi, rax            # rdi := rax
	mov	eax, 0              # eax:=0
	call	printf@PLT          # вызов printf
	jmp	.L29
.L37:
	pxor	xmm0, xmm0                    # побитная операция исключающая "ИЛИ" над 64 битами xmm0 xm0
	ucomisd	xmm0, QWORD PTR -16[rbp]      # неупорядоченное сравнение скалярных значений и установка EFGLAGS
	jp	.L30                          # переход в .L30
	pxor	xmm0, xmm0                    # побитная операция исключающая "ИЛИ" над 64 битами xmm0 xm0
	ucomisd	xmm0, QWORD PTR -16[rbp]      # неупорядоченное сравнение скалярных значений и установка EFGLAGS
	jne	.L30                          # переход если не равно
	mov	esi, 1                        # esi := 1
	lea	rax, .LC13[rip]               #
	mov	rdi, rax                      # rdi := rax
	mov	eax, 0                        # eax := 0
	call	printf@PLT                    # вызов printf
	jmp	.L29                          # переход в .L29
.L30:
	movsd	xmm0, QWORD PTR .LC10[rip]  #
	ucomisd	xmm0, QWORD PTR -16[rbp]    # неупорядоченное сравнение скалярных значений и установка EFGLAGS
	jp	.L32                        # переход в 32-ую метку если честность (PF=1) к заданному адресу
	movsd	xmm0, QWORD PTR .LC10[rip]  #
	ucomisd	xmm0, QWORD PTR -16[rbp]    # неупорядоченное сравнение скалярных значений
	jne	.L32                        # .L32
	mov	esi, 0                      # esi := 0
	lea	rax, .LC13[rip]             #
	mov	rdi, rax                    # rdi := rax
	mov	eax, 0                      # eax := 0
	call	printf@PLT                  # вызов printf
	jmp	.L29                        # безусловный переход в .L29
.L32:
	mov	rax, QWORD PTR -16[rbp]   # rax := rbp[-16]
	movq	xmm0, rax                 # пересылаем 64 бита из rax в xmm0
	call	work                      # вызов функции work
	movq	rax, xmm0                 # пересылаем 64 бита из xmm0 в rax
	mov	QWORD PTR -8[rbp], rax    # rbp[-8] := rax
	mov	rax, QWORD PTR -8[rbp]    # rax := rbp[-8]
	movq	xmm0, rax                 # пересылаем 64 бита из rax в xmm0
	call	output                    # вызов функции output 
.L29:
	mov	eax, 0
	leave
	ret
	.size	main, .-main
	.section	.rodata
	.align 8
.LC1:
	.long	0
	.long	1080623104
	.align 16
.LC2:
	.long	-1
	.long	2147483647
	.long	0
	.long	0
	.align 8
.LC3:
	.long	0
	.long	1072693248
	.align 8
.LC5:
	.long	0
	.long	1071644672
	.align 8
.LC6:
	.long	0
	.long	1073741824
	.align 8
.LC7:
	.long	0
	.long	1074266112
	.align 8
.LC8:
	.long	0
	.long	1075314688
	.align 8
.LC9:
	.long	0
	.long	1074790400
	.align 8
.LC10:
	.long	0
	.long	-1074790400
