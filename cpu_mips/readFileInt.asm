.data

buffer:         .space  1

    # algumas mensagens para serem printadas
start_message:  .asciiz "\n# Inicio da leitura do arquivo #\n"
end_message:    .asciiz "\n# Fim da leitura do arquivo #\n"
save_int_msg:   .asciiz "\nSalvando inteiro na memoria: "
newline:        .asciiz "\n"

error_message:  .asciiz "\nErro de leitura no arquivo!\n"

.text
                .globl  readFileMainInt

readFileMainInt:
    ######################################
    # Entrada funcao:
    # $a0 -> caminho para o txt com dados
    # $a1 -> endereco do vetor dos dados
    # Saída:
    # Não possui saída
    ######################################

    # salva endereco de retorno na pilha
    addi    $sp,            $sp,            -4
    sw      $ra,            ($sp)

    # salva entrada
    move    $s0,            $a0
    move    $s1,            $a1

    # printa a mensagem de inicio de leitura
    li      $v0,            4
    la      $a0,            start_message
    syscall

    # abre arquivo em modo leitura
    move    $a0,            $s0
    li      $a1,            0
    li      $a2,            0
    li      $v0,            13
    syscall
    move    $t0,            $v0

    # Verifica erro na abertura do arquivo
    bltz    $t0,            error_open

    li $s4, 1  # Controle de leitura do arquivo

reset_values:
    li      $t1,            0  # Acumula o número atual
    li      $s2,            0  # Flag para indicar se número negativo

read_loop:
    beq     $s4,            0,              end_read

    # Lê um caractere
    li      $v0,            14
    move    $a0,            $t0
    la      $a1,            buffer
    li      $a2,            1
    syscall
    lb      $t2,            buffer
    move    $s4,            $v0

    # Verifica fim de linha ou fim de arquivo
    beq     $t2,            10,             save_value
    beq     $s4,            0,              save_value

    # Verifica se o caractere é '-'
    li      $t3,            45
    beq     $t2,            $t3,            set_negative

    # Converte caractere ASCII para número inteiro
    andi    $t2,            $t2,            0x0F
    mul     $t1,            $t1,            10
    add     $t1,            $t1,            $t2

    j       read_loop

set_negative:
    li      $s2,            1
    j       read_loop

save_value:
    # Ajusta valor para negativo, se necessário
    beq     $s2,            0,              skip_negate
    sub     $t1,            $zero,          $t1

skip_negate:
    # Printar mensagem de salvamento
    #li      $v0,            4
    #la      $a0,            save_int_msg
    #syscall

    # Imprimir o valor salvo
    #li      $v0,            1
    #move    $a0,            $t1
    #syscall

    # Salvar valor na memória
    sw      $t1,            0($s1)
    addi    $s1,            $s1,            4

    j       reset_values

end_read:
    # Fecha arquivo
    li      $v0,            16
    move    $a0,            $t0
    syscall

    # Recupera endereço de retorno
    lw      $ra,            ($sp)
    addi    $sp,            $sp,            4

    # Printa mensagem de fim
    li      $v0,            4
    la      $a0,            end_message
    syscall

    # Retorna a quantidade de dados lidos
    jr      $ra

error_open:
    # Printa a mensagem de erro
    li      $v0,            4
    la      $a0,            error_message
    syscall

    # Encerra o programa
    li      $v0,            10
    syscall
