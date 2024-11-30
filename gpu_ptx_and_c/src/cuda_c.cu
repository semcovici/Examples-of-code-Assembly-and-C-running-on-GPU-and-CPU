#include "../include/cuda_c.cuh"

#ifdef SHARED

__global__ void matmul_shared(const int* A, const int* B, int* C, const int M, const int N, const int K) {

    int y = blockIdx.y * blockDim.y + threadIdx.y;
    int sy = threadIdx.y;
    int x = blockIdx.x * blockDim.x + threadIdx.x;
    int sx = threadIdx.x;

    extern __shared__ float smem[];
    float *sA = &smem[0];
    float *sB = &smem[blockDim.x*blockDim.x];

    int sum = 0;
    for (int t=0; t<K; t+=blockDim.x) {
        
        if (y<M && sx+t<K) {
            sA[sy*blockDim.x+sx] = A[y*K+(sx+t)];
        } else {
            sA[sy*blockDim.x+sx] = 0;
        }

        if (x<N && sy+t<K) {
            sB[sy*blockDim.x+sx] = B[(sy+t)*N+x];
        } else {
            sB[sy*blockDim.x+sx] = 0;
        }

        __syncthreads();

        for (int k=0; k<blockDim.x; k++) {
            sum += sA[sy*blockDim.x+k]*sB[k*blockDim.x+sx];
        }

        __syncthreads();

    }

    if (y<M && x<N) {
        C[y*N+x] = sum;
    }

}



#else


// Kernel CUDA para multiplicação de matrizes básica
__global__ void matmul_basic(const int* A, const int* B, int* C, const int M, const int N, const int K) {

    // Calcula o índice global da thread na matriz C (coordenada y e x)
    // blockIdx.y e blockIdx.x: índices do bloco atual em ambas as dimensões
    // blockDim.y e blockDim.x: dimensões do bloco (threads por dimensão)
    // threadIdx.y e threadIdx.x: índices da thread dentro do bloco
    int y = blockIdx.y * blockDim.y + threadIdx.y; // Índice da linha na matriz C
    int x = blockIdx.x * blockDim.x + threadIdx.x; // Índice da coluna na matriz C

    // Verifica se a thread está dentro dos limites válidos da matriz C
    if (y < M && x < N) { 
        int sum = 0; // Inicializa o acumulador para calcular C[y][x]

        // Itera sobre os elementos da linha de A e da coluna de B
        for (int k = 0; k < K; k++) {
            // Calcula o produto dos elementos correspondentes de A e B
            // A[y * K + k]: Acessa o elemento da linha y e coluna k em A
            // B[k * N + x]: Acessa o elemento da linha k e coluna x em B
            sum += A[y * K + k] * B[k * N + x];
        }

        // Armazena o resultado na matriz C na posição correspondente
        // C[y * N + x]: Calcula o índice linear da posição (y, x) em C
        C[y * N + x] = sum;
    }
}

#endif