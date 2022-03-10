clc
clear all
close all

%longitud de los símbolos de entrada
N=10;
%amplitud
a=5;
%relación señal a ruido
SNR=500;

potencia_de_ruido=a/(10^(SNR/10));

x_alph=randerr(1,N,[0 N/2;0 1]);
y=zeros(1,N);
y_alph=zeros(1,N);
z2z = 0;
one2one = 0;
z2one = 0;
one2z = 0;
for i=1:N
    y(i) = x_alph(i) + randn(1,1) * sqrt(potencia_de_ruido);
    if y(i) < 0
        y_alph(i) = 0;
    else
        y_alph(i) = 1;
    end
    
end

detector=[x_alph;y;y_alph]'

entrada=detector(1:10);
salida=detector(21:30);


