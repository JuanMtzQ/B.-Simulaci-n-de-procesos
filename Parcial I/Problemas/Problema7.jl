# Datos
p = 3 # atm
K = 0.05
xI = 0 #limite inf fracción de agua
xS = 0.5 # limite sup fracción de agua


fI = xI*sqrt((2*p)/(2+xI))/(1-xI)-K
fS = xS*sqrt((2*p)/(2+xS))/(1-xS)-K
er = 100
xN = 0
n = 0
while er>=0.0001
    global xN=(xI+xS)/2
    global fN=xN*sqrt(2*p/(2+xN))/(1-xN)-K
    a=fN*fS
    b=fN*fI
    if fN == 0
        continue
    end
    if a<0 && b>0
        global xI=xN
        global fI=xI*sqrt(2*p/(2+xI))/(1-xI)-K
    end
    if a>0 && b<0
        global xS=xN
        global fS=xS*sqrt(2*p/(2+xS))/(1-xS)-K
    end
    global n=n+1
    global er=abs((xS-xI))
end

println("La raíz es ", xN ,  "\nNúmero de iteraciones = ", n, "\nError = ", er)
