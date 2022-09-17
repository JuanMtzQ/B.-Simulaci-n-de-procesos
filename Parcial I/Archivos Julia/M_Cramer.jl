using LinearAlgebra

A = [2 8 6; 4 2 -2; 3 -1 1]
b = [20; -2; 11]

function Cramer(A, b)
    DetA = det(A)
    n = length(b)
    xi = []
    for i=1:n
        Apivot = copy(A)
        Apivot[:,i] = b
        DetApivot = det(Apivot)
        x = DetApivot/DetA
        append!(xi, x)
    end
    return xi
end

xi = Cramer(A, b)
println(xi)