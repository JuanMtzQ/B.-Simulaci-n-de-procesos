A = 1
B = 2
C = 3

#Comprobación de numeros iguales
if A == B && A == C
    println("A, B y C son iguales")
    println("A = ", A)
    println("B = ", B)
    println("C = ", C)
else
    if A == B && B > C
        println("A y B son iguales")
        println("A = ", A)
        println("B = ", B)
        println("C = ", C)
    else
        if A == C && C > B
            println("A y C son iguales")
            println("A = ", A)
            println("C = ", C)
            println("B = ", B)
        else
            if B == C && C > A
                println("B y C son iguales")
                println("B = ", B)
                println("C = ", C)
                println("A = ", A)
            end
        end
    end
end

#Ordenamiento descendete a partir de A
if A > B && A > C
    println("A = ", A)
    if B > C
        println("B = ", B)
        println("C = ", C)
    else C < B
        println("C = ", C)
        println("B = ", B)
    end
end
#Ordenamiento descendete a partir de B
if B > A && B > C
    println("B = ", B)
    if C > A
        println("C = ", C)
        println("A = ", A)
    else C < A
        println("A = ", A)
        println("C = ", C)
    end
end

#Ordenamiento descendete a partir de C
if C > A && C > B 
    println("C = ", C)
    if B > A
        println("B = ", B)
        println("A = ", A)
    else B < A
        println("A = ", A)
        println("B = ", B)
    end 
end