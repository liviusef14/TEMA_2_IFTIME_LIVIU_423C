syms t n % definim astfel pentru ca avem nevoie pentru functia int care calculeaza
% integrala

P=40;  % Perioada semnalului
w=2*pi/P; 
D=11;  % Durata semnalului dreptunghic
rezolutie=1/20; 
% Rezolutie aleasa ca sa avem imagine mai exacta, dar si sa nu avem timp de rulare foarte mare
semnal=[ones(1,D/rezolutie),zeros(1,(P-D)/rezolutie),ones(1,D/rezolutie),zeros(1,(P-D)/rezolutie),ones(1,D/rezolutie),zeros(1,(P-D)/rezolutie)];
% Semnalul dreptunghiular este format doar din valori de 1 si 0 asa ca am
% facut 4 perioade una dupa alta pentru afisare

timp=0:rezolutie:120-rezolutie; 
% Durata de timp pentru care vom face calculele

n=-50:-1; % numarul de coeficienti

cnminus=int(power( exp(1),-1j*n*w*t),t,0,D);
m=0; %coeficientul exponential cu minus (nu-l afisam), ci doar incadram cn intre el si
%coeficientul cu plus;
c0=int(power( exp(1),-1j*m*w*t),t,0,D);
p=1:50;
cnplus= int(power( exp(1),-1j*p*w*t),t,0,D) %coeficientul exponential afisat;

cn=[cnminus,c0,cnplus];
cnminus=double(cnminus);
cnplus=double(cnplus);
c0=double(c0);
cn=double(cn);

semnal2=c0/P;
for i=1:50
semnal2=semnal2+2*cnplus(i)*power(exp(1),1j*i*w*timp)/P;
end

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
title('Spectrul semnalului x(t) care obtine din calculul a 51 de coeficienti')