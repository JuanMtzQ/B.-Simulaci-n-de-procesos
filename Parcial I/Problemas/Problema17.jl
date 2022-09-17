using LinearAlgebra
Flujos = [120 -20 0; 80 -80 0; 40 60 -120]
Concentraciones = [400; 0; 200]

c = inv(Flujos)*Concentraciones

for i =1:length(c)
    println("Concentracion del reactor ",i ," : ", round( c[i], digits = 4), " mg/m^3")
end
