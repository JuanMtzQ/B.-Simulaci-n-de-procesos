using PyPlot

x_list = [0.1, 0.25, 0.5, 0.75, 0.9]
t_list = collect(1:60) #Crea un vector de 1 a 60 
k_list = collect(1:100)

function Temperatura(x_list, t_list, k_list)
    Temp_total = []
    for x in x_list
        Temp_xi = []
        for t in t_list
            Suma_k = 0
            for k in k_list
                T = (4 / ((2 * k - 1) * π)) * sin((2 * k - 1) * π * x) * exp(-(2 * k - 1)^2 * π^2 * t)
                Suma_k = Suma_k + T
            end
            append!(Temp_xi, Suma_k)
        end 
        append!(Temp_total, [Temp_xi])
    end   
    return Temp_total
end

Temp_total = Temperatura(x_list, t_list, k_list)
for i = 1:5
    plot(t_list, Temp_total[i], label = ("x[",i,"]")) 
end

title("Comportamiento de la temperatura")
xlabel("Tiempo (s)")
ylabel("Cambio de temperatura (DT)")
legend()