f(x) = exp(x^2) + x^2 
# f(x) = 0.2 + 25*x - 200*x^2 + 675*x^3 - 900*x^4 + 400*x^5

# Regla del trapecio
function Int_Trapecio(f, a, b)
    Integral = (b - a)*(f(a) + f(b))/2
    return Integral
end

Integral = Int_Trapecio(f, 0, 1)
println("Integral con regla del trapecio = ", Integral)