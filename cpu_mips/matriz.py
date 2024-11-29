import random

def generate_matrix_data(rows, cols, label):
    print(f"{label}: .word ", end="")
    elements = [random.randint(1, 10) for _ in range(rows * cols)]
    print(", ".join(map(str, elements)))
    return elements

# Dimensões das matrizes
M, K, N = 1000, 100, 100

# Gerar matriz A
generate_matrix_data(M, K, "A")

# Gerar matriz B
generate_matrix_data(K, N, "B")