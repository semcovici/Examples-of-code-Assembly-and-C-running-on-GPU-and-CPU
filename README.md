# Codigos exemplo para multiplicação de matriz utilizando C e assembly, na GPU e CPU

Este repositório contém exemplos de implementação de multiplicação de matrizes utilizando diferentes abordagens: CUDA PTX, CUDA C, C para CPU e MIPS Assembly na CPU.

## Sobre o código em PTX e CUDA C

### Navegar até o diretório correspondente:
```bash
cd gpu_ptx_and_c
```

### 1. Introdução
Este exemplo apresenta a implementação da multiplicação de matrizes utilizando CUDA PTX (Parallel Thread eXecution) e CUDA C.  
Os arquivos principais são:
- `src/cuda_c.cu`: Exemplo com CUDA C.
- `src/cuda_ptx.cu`: Exemplo com CUDA PTX.  

Para mais detalhes, visite: [Blog do desenvolvedor (em coreano)](https://computing-jhson.tistory.com/15).

### 2. Como executar
1. Compilar:
   ```bash
   make
   ```
2. Executar:
   ```bash
   make run
   ```

---

## Sobre o código em C

### Navegar até o diretório correspondente:
```bash
cd c_cpu
```

### Como compilar e executar:
1. Compilar o código:
   ```bash
   gcc matrix_multiply_cpu.c -o matrix_multiply_cpu
   ```
2. Executar o programa:
   ```bash
   ./matrix_multiply_cpu
   ```

---

## Sobre o código em MIPS

### Navegar até o diretório correspondente:
```bash
cd cpu_mips
```

### Como executar:
1. Abra o Mars:
   ```bash
   sudo java -jar Mars45.jar
   ```
2. No Mars, selecione o arquivo `matrix_multiply_MIPS.asm`.
3. Execute o código utilizando o ambiente do Mars.

---

### Notas
- Certifique-se de ter as dependências instaladas, como o CUDA Toolkit para os exemplos CUDA e o compilador GCC para o exemplo em C.
---