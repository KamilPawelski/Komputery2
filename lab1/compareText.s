# Definicje nazw symbolicznych. Pod nazwa kryją się konkretne wartości.
SYSEXIT = 1
EXIT_SUCCESS = 0
SYSREAD = 3
STDIN = 0
SYSWRITE = 4
STDOUT = 1

# definicje stałych reprezentujących łańcuchy znaków
.text
msg: .ascii "Write text (5): \n"
msg_len = . - msg

msg2: .ascii "Written text: "
msg2_len = . - msg2

msg3: .ascii "kowal" #Dodatkowa zmienna do porównania sobie

newline: .ascii "\n"
newline_len = . - newline

# do wyświetlenia jak są równe
equal_msg: .ascii "Strings are equal\n"
equal_msg_len = . - equal_msg

# do wyświetlenia jak nie są równe
not_equal_msg: .ascii "Strings are not equal\n"
not_equal_msg_len = . - not_equal_msg

# Sekcja w pamięci w której zapisaliśmy w tym konkretnym przypadku buf
.data
buf: .ascii "     "
buf_len = . - buf

# początek programu 
.global _start
_start:

# Podawania wartości do konkretnych rejestrów i wywoływanie funkcji (system call)
# użyte sys_write, sys_read, sys_exit
mov $SYSWRITE,%eax
mov $STDOUT,%ebx
mov $msg,%ecx
mov $msg_len,%edx
int $0x80 # procedura przerwania (interrupt)

# wczytanie do buf 5 znakowego stringa
mov $SYSREAD,%eax
mov $STDIN,%ebx
mov $buf,%ecx
mov $buf_len,%edx
int $0x80


mov $SYSWRITE,%eax
mov $STDOUT,%ebx
mov $msg2,%ecx
mov $msg2_len,%edx
int $0x80

mov $SYSWRITE,%eax
mov $STDOUT,%ebx
mov $buf,%ecx
mov $buf_len,%edx
int $0x80

mov $SYSWRITE,%eax
mov $STDOUT,%ebx
mov $newline,%ecx
mov $newline_len,%edx
int $0x80

#zapisanie do rejestru dwóch adresów które chcemy porównać
mov $msg3, %ebx    
mov $buf, %ecx    

# licznik do pętli aby przechodzić do kolejnych znaków
mov $0, %edx      

# (Pytanie) należy określić ograniczenie jakie nakłada na program “compareText” wykorzystanie rejestru akumulatora.
# Etykieta pętli potrzebna do porównania wyrazów (%al jest 8 bitowy jest w stanie przechowywać 1 znak ASCII dlatego porównywać będziem znak po znaku)
loop:
mov (%ebx,%edx), %al    # załadowanie wartości do rejestru al
cmp (%ecx,%edx), %al    # porównanie czy wartości są równe
jne not_equal             # jeśli nie są równe, skaczemy do etykiety not_equal

inc %edx            # zwiększenie liczniku aby przejsc na kolejny znak 
cmp $5, %edx        # porówanie jeśli przejedziemy wszystkie znaki (Max 5 bo tyle możemy zapisać do buf)
jne loop            # to wyjdzie z petli jeśli jeszcze nie to skaczemy do etykiety loop 

#wynik gdy słowa są równe
mov $SYSWRITE,%eax
mov $STDOUT,%ebx
mov $equal_msg, %ecx
mov $equal_msg_len, %edx
int $0x80

# zakończenie programu sukcesem
mov $SYSEXIT, %eax
mov $EXIT_SUCCESS, %ebx
int $0x80

#etykieta not_equal wynik kiedy nie są równe
not_equal:
mov $SYSWRITE,%eax
mov $STDOUT,%ebx
mov $not_equal_msg, %ecx
mov $not_equal_msg_len, %edx
int $0x80

# zakończenie programu sukcesem
mov $SYSEXIT, %eax
mov $EXIT_SUCCESS, %ebx
int $0x80
