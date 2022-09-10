
A = [0 7 -1 3 1; 0 3 4 1 7; 6 2 0 2 -1; 2 1 2 0 2; 3 4 1 -2 1]
b = [5; 7; 2; 3; 4]


#=
A = [3 -2 5 0; 4 5 8 1; 1 1 2 1; 2 7 6 5]
b = [2; 4; 5; 7]
=#

function GaussPivoteoParcial(A, b)
    Ap = float(copy(A)) # Copia flotante para evitar que realice cambios sobre el original
    bp = float(copy(b))
    n = length(b) # Tamaño de la matriz n x n
    x = zeros(n)

    # Proceso de eliminacion
    for k = 1:(n-1) # Indexacion del primer renglon con sus columnas

        # Pivoteo parcial
        if abs(Ap[k, k]) < 1.0e-12 # Si el valor de elemento pivote es cero (practicamente)
            for i = (k+1):n # 
                if abs(Ap[i, k]) > abs(Ap[k, k]) # Si un elemento posterior al elemento pivote es mayor
                    for j = k:n 
                        Ap[k, j], Ap[i, j] = Ap[i, j], Ap[k, j] # Intercambio de elemento pivote Ap
                    end
                    bp[k], bp[i] = bp[i], bp[k] # Intercambio de elemento (correspondiente al renglon del pivote) bp
                    break # Regresa al ciclo anterior para continuar con la eliminacion
                end
            end
        end

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

    #=
    println("Matriz con ceros inferiores")
    println(Ap)
    println("\nVector de b")
    println(bp)
    =#
    
    # Sustitucion hacia atrás para encontrar los valores de x
    x[n] = bp[n] / Ap[n, n] # Solución de xn
    for i = n-1:-1:1 # Recorre la matriz desde el penultimo renglon hasta el primero
        sum_ax = 0.0 
        for j = i+1:n #  
            sum_ax = sum_ax + Ap[i, j]*x[j]
        end
        x[i] = (bp[i] - sum_ax)/Ap[i,i]
    end 
    println("\nSolucion de x[i]")
    println(x)
end

GaussPivoteoParcial(A, b)