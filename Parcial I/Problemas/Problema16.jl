using LinearAlgebra

A = [-1 1 1 1 1	0 0	0 0	0 0	0;
    0 -1 0 0 0 0 0 0 1 1 1 0; 
    0 0	0 0	-1 1 1 1 0 0 0 0;
    0 0	0 1	0 0	1 0	0 0	1 -1;
    1 0	0 0	0 0	0 0	0 0	0 0;
    0 0	0 0	-1 0 0 5 0 0 0 0;
    0 0	0 1	0 0	1 0	0 0	0 -0.84;
    -0.7 1 1 0 0 0 0 0 0 0 0 0;
    -0.55 0	0 0	0 0	0 0	1 0	0 1;
    0 0	0 0	0 0	0 0	-0.2 1 0 0;
    0 -0.85	0 0	0 0	0 0	1 0	1 0;
    0 0	0 0	0 -3.6 1 1 0 0 0 0]

b = [0; 0; 0; 0; 100; 0; 0; 0; 0; 0; 0; 0]

function GaussJordan(A, b)
    Ap = float(copy(A)) # Copia flotante para evitar que realice cambios sobre el original
    bp = float(copy(b))
    n = length(b) # Tamaño de la matriz n x n
    for k = 1:n # Indexacion del primer renglon con sus columnas

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

        # Division de la fila pivote
        pivote = Ap[k, k]
        for j = k:n
            Ap[k, j] = Ap[k, j] / pivote
        end
        bp[k] = bp[k] / pivote 

        # Proceso de eliminacion
        for i = 1:n
            if i == k || Ap[i, k] == 0
                continue
            end 
            factor = Ap[i, k]
            for j = k:n
                Ap[i, j] = Ap[i, j] - Ap[k, j]*factor
            end
            bp[i] = bp[i] - bp[k]*factor
        end
    end
    return bp
end
m = GaussJordan(A, b)
# m = inv(A)*b

for i = 1:length(m)
    println("Flujo m[",i,"] = ", round( m[i], digits=4), " kg/s")
end