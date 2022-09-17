using LinearAlgebra

A = [0.3 0.52 1; 0.5 1 1.9; 0.1 0.3 0.5] # Matriz de coeficientes
b = [-0.01; 0.67; -0.44] # Matriz de soluciones

DetA = det(A) # Determinante de A, en la matriz original 

Apivot = copy(A) # Para evitar que la matriz original se modifique, utilizamos copy

# Reemplazando la primera columna de la matriz de coeficientes (copia)
# por el vector de resultados
Apivot[:,1].= b[:] 
# Aplicando determinante a la matriz pivoteada
DetApivot = det(Apivot)
# Obteniendo el valor de x1
x1 = DetApivot/DetA

# Aplicando para x2 
Bpivot = copy(A)
DetB = det(Bpivot)
Bpivot[:,2].= b[:]
DetBpivot = det(Bpivot)
x2 = DetBpivot/DetA

#Aplicando para x3
Cpivot = copy(A)
DetC = det(Cpivot)
Cpivot[:,3].= b[:]
DetCpivot = det(Cpivot)
x3 = DetCpivot/DetA

println([x1, x2, x3])