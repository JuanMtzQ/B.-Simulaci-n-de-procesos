using PyPlot
# Datos iniciales
factor = 0.005 # Factor de friccion
D = 0.5 # m
rho = 1.23 # kg/m^3 
L3 = L5 = L8 = L9 = 2 # m
L2 = L4 = L6 = 4 # m
L7 = 8 # m
Q1 = 1 # m^3/s

# Constantes 
C = (16*factor*rho)/(π^2*2*D^5)

function alpha(L)
    alpha = C*L
    return alpha
end

a_p = alpha(L3)
a_m = alpha(L2)
a_7 = alpha(L7)

a_p_m = a_p/a_m
a_6_7 = a_m/a_7

# Ecuacion despejada
function FQ6(Q)
    fx_1 = - 2*a_p_m*(Q^2 + 2*a_p_m*(Q+√(a_6_7*Q^2))^2 + Q^2 + a_6_7*Q^2 + 2*Q*√(a_6_7*Q^2))
    fx_2 = √(Q^2 + 2*a_p_m * (Q + √(a_6_7*Q^2))^2)
    fx_3 = ( (Q+√(a_6_7*Q^2)) * ( - 4*a_p_m+2) - 2*Q1)
    fx_4 = Q1^2 + Q^2 + a_6_7*Q^2 - 2*Q1*Q + √(a_6_7*Q^2)*(2*Q - 2*Q1)
    fx = fx_1 + fx_2 * fx_3 + fx_4
    return fx
end
# Busqueda de la raiz 
function Dif_Atras(f, x0, h)
    x = x0 - h
    fx_prima = (f(x0) - f(x))/h
    return fx_prima
end

# Secante(funcion, punto_inicial, tamaño de paso (entre más pequeño mejor), criterio de convergencia (ej: 0.0001))
function Secante(f, x0, h, ϵ)
    i = 1
    while f(x0) <= -ϵ || f(x0) >= ϵ
        xr = x0 - f(x0)/Dif_Atras(f, x0, h)
        x0 = xr
        i += 1
    end
    return x0
end

Q6 = Secante(FQ6, 3, 0.001, 0.001)

# Balances
Q7 = √(a_m*Q6^2)/a_7
Q5 = Q6 + Q7 
Q4 = √(Q6^2 + 2*a_p_m*(Q6 + Q7)^2)
Q3 = Q4 + Q5
Q2 = Q1 - Q3
Q8 = Q5
Q10 = Q1
Q9 = Q3
Q = [Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10]
for i in 1:length(Q)
    println(" Caudal Q[", i, "] = ", round(Q[i], digits=4), " m^3/s")
end