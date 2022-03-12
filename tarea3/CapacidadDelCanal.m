% 2ASK
clc
clear all
close all

P_x = [0.5 0.5];
a = 1;
SNR = 0:15;
x_pow = 1;
n_pow = x_pow./(10.^(SNR/10));
err = zeros(size(SNR));
z2o = zeros(size(SNR));
o2z = zeros(size(SNR));
o2o = zeros(size(SNR));
z2z = zeros(size(SNR));
N = 100;
N_s = 10000;
for i = 1:N
    for j = 1:length(SNR)
        x = randsrc(1,N_s, [-1 1; P_x]);
        % la variable de salida contaminada está en función de la varianza de la potencia de ruido
        % con un promedio de x=[-5 5]
        y = sqrt(n_pow(j))*randn(1,N_s) + x;
        xe = (y>=0)*2 - 1;
        % se contabilizan todos los errores para cada valor de SNR
        err(j) = err(j) + sum(x~=xe);
        % obtenemos los índices de los símbolos que tuvieron un error de
        % transmisión
        indx_err = find((x~=xe)==1);
        % conteo de transiciones
        for k = indx_err
            if x(k)==1 & xe(k)==-1
                o2z(j) = o2z(j) +1;
            elseif x(k)==-1 & xe(k)==1
                z2o(j) = z2o(j) +1;
            end
        end
        indx_nerr = find((x~=xe)==0);
        for k = indx_nerr
            if x(k)==1 & xe(k)==1
                o2o(j) = o2o(j) +1;
            elseif x(k)==-1 & xe(k)==-1
                z2z(j) = z2z(j) +1;
            end  
        end
    end
    P_e =  err/(i*N_s);
    semilogy(SNR,P_e)
    title(i*N_s)
    xlabel('SNR (dB)')
    ylabel('Errores')
    drawnow
end

%probabilidades de transición
z2z_prob = z2z/((N*N_s)/2);
o2o_prob = o2o/((N*N_s)/2);
z2o_prob = z2o/((N*N_s)/2);
o2z_prob = o2z/((N*N_s)/2);

% probabilidad  de salida del canal para cada SNR
P_o = [z2z_prob+o2z_prob ; z2o_prob+o2o_prob]*0.5;

% %entropia de salida
h_y=sum(-P_o.*log2(P_o));

% entropia hacia delante = 
h_yx0 = -z2z_prob.*log2(z2z_prob)-z2o_prob.*log2(z2o_prob);
h_yx1 = -o2z_prob.*log2(o2z_prob)-o2o_prob.*log2(o2o_prob);
h_yx = (h_yx0 + h_yx1)*0.5; 

I_m = h_y-h_yx;

C = 1 + P_e.*(log2(P_e)) + (1-P_e).*log2(1-P_e);

figure(2)
plot(SNR,C)
title('')
xlabel('SNR (dB)')
ylabel('Capacidad del canal (bits/s)')