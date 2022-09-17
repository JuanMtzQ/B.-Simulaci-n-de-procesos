using LinearAlgebra

A = [2 8 6; 4 2 -2; 3 -1 1]
b = [20; -2; 11]
DetA = det(A) # El determinante de A será usado para encontrar x1, x2, x3

# Obteniendo el valor de x1
Apivot = copy(A) # Para evitar que la matriz original se modifique, utilizamos copy
# Reemplazando la primera columna de la matriz de coeficientes (copia)
# por el vector de resultados
Apivot[:,1] = b #Como queremos todo el vector, no es necesario indicar un rango
# Aplicando determinante a la matriz pivoteada
DetApivot = det(Apivot)
# Obteniendo el valor de x1
x1 = DetApivot/DetA

# Aplicando para x2 
Bpivot = copy(A) # La diferencia de A, B, Cpivot unicamente es para diferenciar en este caso
DetB = det(Bpivot)
Bpivot[:,2] = b
DetBpivot = det(Bpivot)
x2 = DetBpivot/DetA

#Aplicando para x3
Cpivot = copy(A)
DetC = det(Cpivot)
Cpivot[:,3] = b
DetCpivot = det(Cpivot)
x3 = DetCpivot/DetA

