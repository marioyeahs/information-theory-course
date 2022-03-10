clc
clear all
close all

%longitud de los símbolos de entrada
N=10;
%amplitud
a=5;
%relación señal a ruido
SNR=5;

potencia_de_ruido=a/(10^(SNR/10));

x_alph=randerr(1,N,[0 5;0 1]);
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
    if x_alph(i) == y_alph(i)
        if x_alph(i) == 0
            z2z = z2z + 1;
        else 
            one2one = one2one +1;
        end
    else
       if isequal(x_alph(i),0) && isequal(y_alph(i),1)
           z2one = z2one + 1;
       elseif isequal(x_alph(i),1) && isequal(y_alph(i),0)
           one2z = one2z + 1;
       end
    end       
end

detector=[x_alph;y;y_alph]'

entrada=detector(1:10);
salida=detector(21:30);

z2z_prob = z2z/5;
one2one_prob = one2one/5;
z2one_prob = z2one/5;
one2z_prob = one2z/5;

P_a = [z2z_prob+one2z_prob ; z2one_prob+one2one_prob].*0.5;

%entropia de salida
h_y=sum(-P_a.*log2(P_a));

% entropia hacia delante = 
h_yx0 = -z2z_prob*log2(z2z_prob)-z2one_prob*log2(z2one_prob);
h_yx1 = -one2z_prob*log2(one2z_prob)-one2one_prob*log2(one2one_prob);
h_yx = (h_yx0 + h_yx1)*0.5; 

I_m = h_y-h_yx;

C = max(I_m);

P_e = (z2one_prob+one2z_prob)*0.5;
