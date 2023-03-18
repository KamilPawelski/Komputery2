# Definicje nazw symbolicznych. Pod nazwa kryją się konkretne wartości.
SYSEXIT = 1
EXIT_SUCCESS = 0
SYSWRITE = 4
STDOUT = 1

# definicje stałych reprezentujących łańcuchy znaków
.text
msg: .ascii "Hello! \n" # pod msg schowany "Hello! \n"
msg_len = . - msg # długość naszego "Hello! \n"

# początek programu 
.global _start
_start:
# Podawania wartości do konkretnych rejestrów i wywoływanie funkcji (system call)
mov $SYSWRITE,%eax #system call sys_write
mov $STDOUT,%ebx 
mov $msg,%ecx
mov $msg_len,%edx
int $0x80  #procedura przerwania (interrupt)
#zakończenie programu sukcesem
mov $SYSEXIT, %eax #system call sys_exit
mov $EXIT_SUCCESS, %ebx #kończymy zwracając 0
int $0x80
