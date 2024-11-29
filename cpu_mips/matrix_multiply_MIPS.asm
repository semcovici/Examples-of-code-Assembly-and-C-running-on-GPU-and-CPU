.data
N: .word 131 #1031
M: .word 125 #1025
P: .word 135 #1035
A:
	#.align 2	 
	.space 67500  # 16875 * 4   #4243500   # 1060875 * 4
B: 
	#.align 2
	.space 70740  #17685 * 4 #4268340   # 1067085 * 4
C: .space 48

# caminho para os arquivos
matriz_a: .asciiz "./matriz_a.txt"
matriz_b: .asciiz "./matriz_b.txt"

msg_inita: .asciiz "Teste 3 primeiros 3 ultimos dados\n"
msg_a: .asciiz "\nValor de A\n"

# N: .word  1025            # Linhas de A
# M: .word  1035            # Colunas de A e linhas de B
# P: .word  1031            # Colunas de B
# A: .word  1, 2, 3, 4, 5, 6         # { {1, 2}, {3, 4}, {5, 6} }
# B: .word  8, 7, 6, 5, 4, 3, 2, 1   # { {8, 7, 6, 5}, {4, 3, 2, 1} }
# C: .space 4227100

newline: .asciiz "\n"  # Define a string com a quebra de linha


start_ts: 
.align 2
.space 4
end_ts: 
.align 2
.space 4
elapsed_time: 
.align 2
.space 4

elapsed_time_msg: .asciiz "Tempo decorrido para realizar a multiplicação de matrix: \n"
  
.text

# leitura dos dados da matriz A
la $a0, matriz_a          # caminho para o arquivo da matriz
la $a1, A                 # endereço do vetor da matriz 
jal readFileMainInt          # chamar função para ler o arquivo
move $t0, $v0             # armazenar o número de valores lidos em $t0

# leitura dos dados da matriz B
la $a0, matriz_b          # caminho para o arquivo da matriz
la $a1, B                 # endereço do vetor da matriz 
jal readFileMainInt          # chamar função para ler o arquivo
move $t1, $v0             # armazenar o número de valores lidos em $t1

la $a3, A
la $s7, B

#-------------------- TESTA DATA LOAD -------------------------
# inicia teste A
li $v0, 4
la $a0, msg_inita
syscall

# imprime primeiro valor
li $v0, 1
lw $t0, 0($a3)
addiu $a0, $t0, 0
syscall

li $v0, 4
la $a0, newline
syscall

# imprime segundo valor
li $v0, 1
lw $t0, 4($a3)
addiu $a0, $t0, 0
syscall

li $v0, 4
la $a0, newline
syscall

# imprime terceiro valor
li $v0, 1
lw $t0, 8($a3)
addiu $a0, $t0, 0
syscall

li $v0, 4
la $a0, newline
syscall

# imprime antipenultimo valor
li $v0, 1
lw $t0, 67492($a3)
addiu $a0, $t0, 0
syscall

li $v0, 4
la $a0, newline
syscall

# imprime penultimo valor
li $v0, 1
lw $t0, 67496($a3)
addiu $a0, $t0, 0
syscall

li $v0, 4
la $a0, newline
syscall

# imprime ultimo valor
#li $v0, 1
#lw $t0, 67500($a3)
#addiu $a0, $t0, 0
#syscall

#li $v0, 4
#la $a0, newline
#syscall

############################################

# inicia teste B
li $v0, 4
la $a0, msg_inita
syscall

# imprime primeiro valor
li $v0, 1
lw $t0, 0($s7)
addiu $a0, $t0, 0
syscall

li $v0, 4
la $a0, newline
syscall

# imprime segundo valor
li $v0, 1
lw $t0, 4($s7)
addiu $a0, $t0, 0
syscall

li $v0, 4
la $a0, newline
syscall

# imprime terceiro valor
li $v0, 1
lw $t0, 8($s7)
addiu $a0, $t0, 0
syscall

li $v0, 4
la $a0, newline
syscall

# imprime antipenultimo valor
li $v0, 1
lw $t0, 70732($s7)
addiu $a0, $t0, 0
syscall

li $v0, 4
la $a0, newline
syscall

# imprime penultimo valor
li $v0, 1
lw $t0, 70736($s7)
addiu $a0, $t0, 0
syscall

li $v0, 4
la $a0, newline
syscall

# imprime ultimo valor
#li $v0, 1
#lw $t0, 70740($s7)
#addiu $a0, $t0, 0
#syscall

#li $v0, 4
#la $a0, newline
#syscall
#--------------------------------------------------------------

# Captura do tempo inicial
li   $v0, 30          # Syscall para obter tempo em milissegundos
syscall

# salva valor de inicio
la $t0, start_ts
sw $a0, 0($t0) 

# Store M, N, P in $a? registers
lw   $a0, N
lw   $a1, M
lw   $a2, P
jal  multiply

# Captura do tempo inicial
li   $v0, 30          # Syscall para obter tempo em milissegundos
syscall

# salva valor de inicio
la $t0, end_ts
sw $a0, 0($t0) 

# printa tempo decorrido na multiplicacao
la $t0, start_ts
lw $t0, ($t0)

la $t1, end_ts
lw $t1, 0($t1)

sub $t1, $t1, $t0


li $v0, 4          # Código da syscall para print_string
la $a0, elapsed_time_msg    # Carrega o endereço da string "\n" em $a0
syscall            # Chama a syscall para imprimir a quebra de linha

# Imprime o tempo decorrido
li   $v0, 1           # Syscall para imprimir inteiro
move $a0, $t1
syscall


#li $v0, 4          # Código da syscall para print_string
#la $a0, newline    # Carrega o endereço da string "\n" em $a0
#syscall            # Chama a syscall para imprimir a quebra de linha

# Após jal multiply
#jal print_matrix


# finaliza programa
li $v0, 10
syscall

multiply:
  # Register usage:
  # n is $s0, m is $s1, p is $s2,
  # r is $s3, c is $s4, i is $s5,
  # sum is $s6

  # Prologue
  sw   $fp, -4($sp)
  la   $fp, -4($sp)
  sw   $ra, -4($fp)
  sw   $s0, -8($fp)
  sw   $s1, -12($fp)
  sw   $s2, -16($fp)
  sw   $s3, -20($fp)
  sw   $s4, -24($fp)
  sw   $s5, -28($fp)
  sw   $s6, -32($fp)
  addi $sp, $sp, -36

  # Save arguments
  move $s0, $a0             # n
  move $s1, $a1             # m
  move $s2, $a2             # p

  li   $s3, 0               # r = 0
  li   $t0, 4               # sizeof(Int)

mult_loop:
  bge  $s3, $s0, mult_end   # if r >= n, branch
  li   $s4, 0               # c = 0

mult_loop2:
  bge  $s4, $s2, mult_end2  # if c >= p, branch
  li   $s6, 0               # int sum = 0;
  j    mult_loop3

mult_store:
  mul  $t3, $s3, $s2        # t3 = r * p
  mul  $t3, $t3, $t0        # t3 = t3 * 4
  mul  $t4, $s4, $t0        # t4 = c * 4
  add  $t3, $t3, $t4        # t3 = t3 * t4 = (r * p * 4) + (c * 4)
  sw   $s6, C($t3)          # C[r][c] = sum;

  addi $s4, $s4, 1          # c++

  li   $s5, 0               # i = 0
  j    mult_loop2

mult_loop3:
  bge  $s5, $s1, mult_store # if i >= m, branch

  # A[r][i]
  mul  $t5, $s3, $s1        # t5 = r * m
  mul  $t5, $t5, $t0        # t5 = t5 * 4
  mul  $t6, $s5, $t0        # t6 = i * 4
  add  $t5, $t5, $t6        # t5 = (r * m * 4) + (i * 4)
  lw   $t5, A($t5)

	# Imprimi A
	#li $v0, 4
	#la $a0, msg_a
	#syscall

	# imprime primeiro valor
	#li $v0, 1
	## lw $t0, 0($a3)
	#addiu $a0, $t5, 0
	#syscall


  # B[i][c]
  mul  $t7, $s5, $s2        # t7 = i * n
  mul  $t7, $t7, $t0        # t7 = t7 * 4
  mul  $t8, $s4, $t0        # t8 = 4 * c
  add  $t7, $t7, $t8        # t7 = (i * n * 4) + (c * 4)
  lw   $t7, B($t7)

  mul  $t7, $t5, $t7        # t7 = t5 * t7
  add  $s6, $s6, $t7        # sum = sum + t7

  addi $s5, $s5, 1          # i++
  j    mult_loop3

mult_end2:
  addi $s3, $s3, 1          # r++
  j    mult_loop

mult_end:
  # Epilogue
  lw   $ra, -4($fp)
  lw   $s0, -8($fp)
  lw   $s1, -12($fp)
  lw   $s2, -16($fp)
  lw   $s3, -20($fp)
  lw   $s4, -24($fp)
  lw   $s5, -28($fp)
  lw   $s6, -32($fp)
  la   $sp, 4($fp)
  lw   $fp, ($fp)
  jr   $ra


# Função para imprimir a matriz C
print_matrix:
    # Registrar os parâmetros da matriz (n, p)
    lw   $t0, N            # $t0 = n (número de linhas)
    lw   $t1, P            # $t1 = p (número de colunas)
    li   $t2, 0            # $t2 = linha atual (r)

print_row_loop:
    bge  $t2, $t0, print_end  # Se $t2 >= n, termina

    li   $t3, 0            # $t3 = coluna atual (c)

print_col_loop:
    bge  $t3, $t1, next_row  # Se $t3 >= p, vai para a próxima linha

    # Calcula o endereço do elemento C[r][c]
    mul  $t4, $t2, $t1     # $t4 = r * p
    add  $t4, $t4, $t3     # $t4 = (r * p) + c
    mul  $t4, $t4, 4       # $t4 = (r * p + c) * 4
    lw   $t5, C($t4)       # Carrega C[r][c] em $t5

    # Printar o elemento C[r][c]
    li   $v0, 1            # Syscall para printar inteiro
    move $a0, $t5
    syscall

    # Adiciona espaço entre elementos
    li   $v0, 11           # Syscall para printar caractere
    li   $a0, 32           # Código ASCII para espaço (' ')
    syscall

    addi $t3, $t3, 1       # c++
    j    print_col_loop

next_row:
    # Pula para a próxima linha
    li   $v0, 11           # Syscall para printar caractere
    li   $a0, 10           # Código ASCII para nova linha ('\n')
    syscall

    addi $t2, $t2, 1       # r++
    j    print_row_loop

print_end:
    jr   $ra
