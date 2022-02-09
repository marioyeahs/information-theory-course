clc
clear all
close all

load data.mat
N = length(y);
x=[];
for k=1:N
    x(k)=str2double(y(k));
end

h=histogram(x)
prom=h.Values.*10e-5;
[(1:8)',prom']
entropy = -sum(prom.*log2(prom));
