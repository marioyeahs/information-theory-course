clc
clear all
close all

text = extractFileText('./document.txt');
str = double(text{:});                  % Convert Char To Double
alph = double('a':'z');                % Create Bin Ranges
Hcts2 = histcounts(str,10);          % Do Histogram Counts
CB = char(alph);                       % Character Bins
prob=Hcts2/length(str);
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
    if str(h)==str(h+1) && str(h)~=10
        aa=aa+1;
        dob = [dob char(str(h)) char(str(h+1))];
    end
end

for i=str
    if str(i)-str(i+1)==1
        disp("mayot")
    end
end

m_prob = zeros(27,27);
for i=alph
    for j=str
        
    end
end

pair = {};
counter=1;
% CB='abcdefghijl....'

for j = CB
    for i=CB
        pair = [pair, strcat(j,i)];
        counter = counter+1;
    end
end



for p=pair
    disp(count(str,p))
end

    

