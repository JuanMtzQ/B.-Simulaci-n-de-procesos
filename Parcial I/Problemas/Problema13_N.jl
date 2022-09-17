# Problema 13 (Da error)
# Especie: nitrogeno
P = 13.5 # atm 
T = 30 + 273.15 # °C => K
n = 1.5 # Moles de nitrogeno
a = 1.39 # mPa L^2/mol^2
b = 0.03913 # L/mol
R = 0.082057 # (atm L) / (mol K)
Rc = 3.0
MW = 14.0067 # g/mol


# Conversion de unidades
P_atm(P_mPa) = P_mPa/0.101325

# Primera estimacion
V_aprox = R*T/P

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

function Secante(f, x0, h, ϵ)
    while f(x0) <= -ϵ || f(x0) >= ϵ
        xr = x0 - f(x0)/Dif_Atras(f, x0, h)
        x0 = xr
    end
    return x0
end

# Calculo del factor de compresibilidad
V_num = Secante(VdW_mod, V_aprox, 0.01, 0.001)
z = V_num/V_aprox

# Cálculo de HP
HP_aprox = z*R*T/MW

function HP_num(n)
    HP_num = z*R*T/MW * n/(n-1)*(Rc^((n-1)/n)-1) - HP_aprox
    return HP_num
end

HP = Secante(HP_num, HP_aprox, 0.01, 0.001)
println("La energia del compresor es: ", HP) # Da error