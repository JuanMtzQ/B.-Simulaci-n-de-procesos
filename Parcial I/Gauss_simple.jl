A = [3 -2 5 0; 4 5 8 1; 1 1 2 1; 2 7 6 5]
b = [2; 4; 5; 7]
x = zeros(n)

function Gauss(A, b)
    Ap = float(copy(A)) # Copia flotante para evitar que realice cambios sobre el original
    bp = float(copy(b))
    n = length(b) # Tamaño de la matriz n x n
    x = zeros(n)
    # Proceso de eliminacion
    for k = 1:(n-1) # Indexacion del primer renglon con sus columnas
        for i = (k+1):n # Indexacion de filas restantes
            if Ap[i,k] == 0 # Si el elemento es cero, salta al siguiente
                continue
            end
            factor = Ap[k, k] / Ap[i, k] # factor utilizado para la eliminación de los valores de la columna
            for j = k:n # Indexacion de columnas restantes
                Ap[i, j] = Ap[k, j] - Ap[i, j]*factor # Criterio de eliminación
            end
            bp[i] = bp[k] - bp[i]*factor
        end
    end
    # Sustitucion hacia atrás para encontrar los valores de x
    # Este proceso falla 
    x[n] = b[n] / Ap[n, n]
    for i = n-1:-1:1
        sum_ax = 0.0
        for j = (i+1):n
            sum_ax = sum_ax + Ap[i, j]*x[j]
        end
        x[i] = (b[i] - sum_ax)/Ap[i,i]
    end 
    return Ap, bp, x
end

A, b, x = Gauss(A, b)
println("Matriz con ceros inferiores")
println(A)
println("\nVector de b")
println(b)
println("\nSolucion")
println(x)
