import random
'''
def generate_matrix_data(rows, cols, label):
    #print(f"{label}: .word ", end="")
    elements = [random.randint(-5, 5) for _ in range(rows * cols)]
    #print("\n".join(map(str, elements)))
    return elements

# Dimensões das matrizes
M, K, N = 1025, 1035, 1031

# Gerar matriz A
a = generate_matrix_data(M, K, "A")

# Gerar matriz B
b = generate_matrix_data(K, N, "B")

'''

def generate_matrix_data(rows, cols):
    return [random.randint(-5, 5) for _ in range(rows * cols)]

# Dimensões das matrizes
M, K, N = 125, 135, 131 #1025, 1035, 1031

# Gerar matriz A
a = generate_matrix_data(M, K)

# Salvar matriz A no arquivo 'matriz_a.txt'
with open("matriz_a.txt", "w") as file_a:
    file_a.write("\n".join(map(str, a)))

# Gerar matriz B
b = generate_matrix_data(K, N)

# Salvar matriz B no arquivo 'matriz_b.txt'
with open("matriz_b.txt", "w") as file_b:
    file_b.write("\n".join(map(str, b)))

