syms t n % definim astfel pentru ca avem nevoie pentru functia int care calculeaza
% integrala

P=40;  % Perioada semnalului
w=2*pi/P; 
D=11;  % Durata semnalului dreptunghic
rezolutie=1/30; 
% Rezolutie aleasa ca sa avem imagine mai exacta, dar si sa nu avem timp de rulare foarte mare
semnal=[ones(1,D/rezolutie),zeros(1,(P-D)/rezolutie),ones(1,D/rezolutie),zeros(1,(P-D)/rezolutie),ones(1,D/rezolutie),zeros(1,(P-D)/rezolutie)];
% Semnalul dreptunghiular este format doar din valori de 1 si 0 asa ca am
% facut 4 perioade una dupa alta pentru afisare

timp=0:rezolutie:120-rezolutie; 
% Durata de timp pentru care vom face calculele

n=1:50; % numarul de coeficienti

a0 =(1/P)*int(1,t,0,D)  % formula = integrala din 1 dt de la 0 la D
% de la D la P nu avem nevoie pentru ca atunci valoarea este 0 deci
% integrarea ar fi degeaba
an =(2/P)*int(1*cos(w*n*t),t,0,D) % formula
bn =(2/P)*int(1*sin(w*n*t),t,0,D) % formula
a0=double(a0);
an=double(an);
bn=double(bn);
for a=1:50
    cn1(a)=an(abs(a-51))+i*bn(abs(a-51));
    cn2(a)=an(a)+i*bn(a);
end

cn=[cn1,a0,cn2]; % Valorile coeficientilor

semnal2=a0;
for i=1:50
    semnal2=semnal2+an(i)*cos(w*i*timp)+bn(i)*sin(w*i*timp);
end
% am recreat semnalul insumand coeficientii calculati

figure(1)
plot(timp,semnal);
hold on
plot(timp,semnal2,'.');  % Afisarea pe acelasi grafic a semnalului initial
% si cel reconstruit
title('x(t) (Linie solida) si semnalul reconstruit cu 50 de coeficienti (Linie punctata)')
hold off

f=-50:50;
figure(2)
stem(f,abs(cn));
title('Spectrul semnalului x(t) care se obtine din calculul a 51 de coeficienti')