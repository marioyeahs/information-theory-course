clc
clear all
close all

% Given H Matrix
H = [1 0 1 1 1 0 0;
	1 1 0 1 0 1 0;
	0 1 1 1 0 0 1]

k = 4;
n = 7;

% Generating G Matrix

% Taking the H Matrix Transpose
P = H';

% Making a copy of H Transpose Matrix
L = P;

% Taking the last 4 rows of L and storing (deleting the last 4 rows of L)
L((5:7), : ) = [];

% Creating a Identity matrix of size K x K
I = eye(k);

% Making a 4 x 7 Matrix
G = [I L]

% Generate U data vector, denoting all information sequences
no = 2 ^ k

% Iterate through an Unit-Spaced Vector
for i = 1 : 2^k

    % Iterate through Vector with Specified Increment
    % or in simple words here we are decrementing 4 till we get 1	
    for j = k : -1 : 1
        if rem(i - 1, 2 ^ (-j + k + 1)) >= 2 ^ (-j + k)
            u(i, j) = 1;
        else
            u(i, j) = 0;
        end

        % To avoid displaying each iteration/loop value
        echo off;
    end
end

echo on;
u

% Generate CodeWords
c = rem(u * G, 2)

% Find the min distance
w_min = min(sum((c(2 : no, :))'))

% channel % Given Received codeword


P_e = [0.5 0.5];
ber = 0;

% for m = 1:no

    e = randsrc(1,1, [0 1; P_e]); % 0-1
    j = randi([1 16],1,1); % 1-16
    i = randi([1 7],1,1);  % 1-7
    r_ = c(j,:) % row of codeword matrix
    r = c(j,:);
    r(i) = e % bit of row from codeword matrix
    %ber = ber + biterr(r_,r);

% end

P = [G(:, n - k + 2 : n)];

%Find Syndrome
ht = transpose(H)

s = rem(r * ht, 2)

M = size(ht);
for i = 1:M
    if(ht(i,1:3)==s)
        r(i) = 1-r(i);
        break;
    end
end

disp('The Error is in bit:')
disp(i)

disp('The Corrected Codeword is :') % palabra decodificada
disp(r)
% 
% % % error a nivel de símbolo SER
% % if b ~= b_
% %     cont = cont + 1;
% % end
