import random

def generate_matrix_data(rows, cols, label):
    print(f"{label}: .word ", end="")
    elements = [random.randint(-5, 5) for _ in range(rows * cols)]
    print(", ".join(map(str, elements)))
    return elements

# Dimensões das matrizes
M, K, N = 1025, 1035, 1031

# Gerar matriz A
generate_matrix_data(M, K, "A")

# Gerar matriz B
generate_matrix_data(K, N, "B")
