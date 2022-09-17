# Problema 8
# Datos 
P = 13.5 # atm 
T = 20 + 273.15 # °C => K
n = 1.5 # Moles de nitrogeno
a = 1.39 # mPa L^2/mol^2
b = 0.03913 # L/mol
R = 0.082057 # (atm L) / (mol K)

# Conversion de unidades
P_atm(P_mPa) = P_mPa/0.101325

function VdW_mod(V)
    a_atm = P_atm(a) 
    VdW_mod = P - (n*R*T)/(V-n*b) - (n^2*a_atm)/V^2 # Despeje de la funcion
    return VdW_mod
end

# Busqueda de la raíz
function Dif_Atras(f, xi, h)
    x0 = xi - h
    fx_prima = (f(xi) - f(x0))/h
    return fx_prima
end

# Secante(funcion, punto_inicial, tamaño de paso (entre más pequeño mejor), criterio de convergencia (ej: 0.0001))
function Secante(f, x0, h, ϵ)
    while f(x0) <= -ϵ || f(x0) >= ϵ
        xr = x0 - f(x0)/Dif_Atras(f, x0, h)
        x0 = xr
    end
    return x0
end

V_L = Secante(VdW_mod, 5, 0.01, 0.001)
V_m3 = V_L/1000
println("Volumen en litros = ", round(V_L, digits = 4))
println("Volumen en m^3 = ", round(V_m3, digits = 4))