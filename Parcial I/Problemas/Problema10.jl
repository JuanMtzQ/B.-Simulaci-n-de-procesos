# Problema 10
# Datos
# Tubo liso
L = 0.2 # m
rho = 1.23 # kg/m^3
mu = 1.79*10^-5 # Ns/m^2
D = 0.005 # m
V = 40.0 # m/s
eps_1 = 1.5e-6 # Tubo liso,
eps_2 = 4.5e-5 # Tubo acero comercial

# Calculo del Reynolds para cada tubo
Re = rho*V*D/mu
println("Número de Reynolds = ", Re)

Blasius = 0.316/Re^0.25 
println("Dado que Re < 10^5, usando la formula de Blasius, f = ", Blasius)

ff_1(f) = -2*log10(eps_1/(3.7*D) + 2.51/(Re*√f)) - 1/√f
ff_2(f) = -2*log10(eps_2/(3.7*D) + 2.51/(Re*√f)) - 1/√f

# Método de la secante
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

# Cálculo del factor de friccion
ff_1_cal = Secante(ff_1, 0.001, 0.0001, 0.001)
ff_2_cal = Secante(ff_2, 0.001, 0.0001, 0.001)
ff_list = [ff_1_cal, ff_2_cal]

# Cálculo de la caida de presión
for i = 1:2
    DP = ff_list[i]*L*rho*V^2/(2*D)
    println("\nCon un coeficiente de friccion = ", ff_list[i])
    println("La caida de presión para el tubo [", i,"] es = ", DP)
end

println("Diferencia en la caida de presión entre el tubo[1] y tubo[2]", )