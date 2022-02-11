% programa que carga un archivo de texto, este archivo se convierte en una
% cadena de caracteres. una vez se tenga en caracteres se debe obtener el
% código UNICODE ó ASCII para poder mostrar el histograma y ver las
% probabilidades de cada símbolo Al obtener las probabilidades podemos
% sacar la entropía de la fuente. El alfabeto reducido contiene los sig
% caracteres {‘a’, …, ’z’, ‘á’, …, ’ú’, ’ ‘, ‘.’, ‘,’, ‘´’, ‘?’, ‘!’}
% En ASCII a-z|97-122, á-ú|(225 ,233,237,243,250), Á-Ú|(193,201,205,211,218),
% A-Z|65-90
% ' '|32,'.'|46, ','|44, '"'|34, '¿?'|63, '¡!'|33
clc
clear all
close all

str = extractFileText('./Don Miguel Ruiz - Los Cuatro Acuerdos_ Una Guia Practica para la Libertad Personal (1999).docx');

% get de reduced alphabet
a_z = 97:122;
a_u = [225 233 237 243 250];
A_U = [193 201 205 211 218];
A_Z = 65:90;
punctuation = [32,46,44,34,63,33,161,191];
reduced_alphabet=sort([a_z a_u A_U A_Z punctuation]);

file_char = char(str);
ascii_file = double(file_char);

reduced_text=ismember(ascii_file,reduced_alphabet);
reduced_text=reduced_text.*ascii_file;
vector_reduced_text=nonzeros(reduced_text)';

h = histogram(vector_reduced_text,'BinWidth',1);
prob = h.Values.*10e-6; 
chars_ascii = h.BinEdges;
chars_ascii=chars_ascii(1:end-1);
chars_ascii',prob';
sum(prob)




