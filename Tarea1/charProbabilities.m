clc
clear all
close all

C = extractFileText('./document.txt');
Cc = double(C{:});                  % Convert Char To Double
B = double('a':'z');      % Create Bin Ranges
Hcts2 = histcounts(Cc,10);          % Do Histogram Counts
CB = char(B);                       % Character Bins
prob=Hcts2/length(Cc);
suma=sum(prob);

% matriz simétrica
% for R=1:27
%     for D = 1:27
%         A(R,D) = prob(R)*prob(D);
%     end
% end

dob=[];
%matriz simetrica
aa=0;
for h=1:14830
    if Cc(h)==Cc(h+1) && Cc(h)~=10
        aa=aa+1;
        dob = [dob char(Cc(h)) char(Cc(h+1))];
    end
end