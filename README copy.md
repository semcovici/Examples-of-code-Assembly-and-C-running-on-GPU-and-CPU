# cuda-ptx : Inline CUDA PTX Assembly Example for Matrix Multiplication

## Sobre o código em PTX e cuda C:

Entrar no diretório:
```
cd gpu_ptx_and_c
```

### 1. Introduction
CUDA PTX (Parallel Thread eXecution)으로 구현한 matrix multiplication 예제입니다.
- src/cuda_c.cu : example via CUDA C
- src/cuda_ptx.cu : example via CUDA PTX   
  
  
설명 : https://computing-jhson.tistory.com/15

### 2. How to Run
1. Compile
    - make
2. Run
    - make run


## Sobre o código em C:

Entrar no diretório:
```
cd c_cpu
```


Compilar:
```
gcc matrix_multiply_cpu.c -o matrix_multiply_cpu
```

Executar:
```
./matrix_multiply_cpu
```


## Sobre o código em MIPS:

Entrar no diretório:
```
cd cpu_mips
```

Execute o mars com:
```
sudo java -jar Mars45.jar
```

Selecione o arquivo `matrix_multiply_MIPS.asm` e o execute.