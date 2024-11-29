#include <stdio.h>
#include <stdlib.h>
#include <time.h>

// Dimensões das matrizes
int M = 125;
int N = 135;
int K = 131;

// Função para inicializar as matrizes com valores aleatórios
void initialize_matrix(int *matrix, int rows, int cols) {
    for (int i = 0; i < rows * cols; i++) {
        matrix[i] = rand() % 11 - 5; // Valores entre -5 e 5
    }
}

// Função para multiplicar as matrizes A[M, K] * B[K, N] = C[M, N]
void matrix_multiply(const int *A, const int *B, int *C, int M, int N, int K) {
    for (int i = 0; i < M; i++) {
        for (int j = 0; j < N; j++) {
            int sum = 0;
            for (int k = 0; k < K; k++) {
                sum += A[i * K + k] * B[k * N + j];
            }
            C[i * N + j] = sum;
        }
    }
}

// Função para verificar o resultado da multiplicação
int check_result(const int *A, const int *B, const int *C, int M, int N, int K) {
    for (int i = 0; i < M; i++) {
        for (int j = 0; j < N; j++) {
            int expected = 0;
            for (int k = 0; k < K; k++) {
                expected += A[i * K + k] * B[k * N + j];
            }
            if (C[i * N + j] != expected) {
                printf("Error at C[%d][%d]: got %d, expected %d\n", i, j, C[i * N + j], expected);
                return 0;
            }
        }
    }
    return 1;
}

int main() {
    // Inicializar gerador de números aleatórios
    srand(time(NULL));

    printf("\n************************************************\n");
    printf("Matrix multiplication on CPU\n");
    printf(" -- A[%d, %d] * B[%d, %d] = C[%d, %d]\n", M, K, K, N, M, N);
    printf("************************************************\n\n");

    // Alocar matrizes na memória
    int *A = (int *)malloc(M * K * sizeof(int));
    int *B = (int *)malloc(K * N * sizeof(int));
    int *C = (int *)malloc(M * N * sizeof(int));

    if (!A || !B || !C) {
        printf("Memory allocation failed!\n");
        return -1;
    }

    // Inicializar matrizes
    initialize_matrix(A, M, K);
    initialize_matrix(B, K, N);

    // Medir o tempo da multiplicação
    clock_t start = clock();
    matrix_multiply(A, B, C, M, N, K);
    clock_t end = clock();

    // Verificar resultado
    if (check_result(A, B, C, M, N, K)) {
        printf("Matrix multiplication successful!\n");
    } else {
        printf("Matrix multiplication failed!\n");
    }

    // Exibir tempo de execução
    double elapsed_time = (double)(end - start) / CLOCKS_PER_SEC;
    printf("Elapsed time: %.3f seconds\n", elapsed_time);

    // Liberar memória
    free(A);
    free(B);
    free(C);

    return 0;
}
