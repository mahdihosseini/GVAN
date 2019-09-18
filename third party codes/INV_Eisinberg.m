function [iM] = INV_Eisinberg(set_Of_Values,ESP_Sol)
%   This is the inverse Vandermonde implementation from the reference [1].
%   [1] Eisinberg, Alfredo, and Giuseppe Fedele. "On the inversion of the 
%   Vandermonde matrix." Applied mathematics and computation 174.2 (2006)"
%   Altered to take in various ESP solutions
%
%
%   Copyright (c) 2019 Mahdi S. Hosseini and Alfred Chen
%
%   University of Toronto
%   The Edward S. Rogers Sr. Department of,
%   Electrical and Computer Engineering (ECE)
%   Toronto, ON, M5S3G4, Canada
%   Tel: +1 (416) 978 6845
%   email: mahdi.hosseini@mail.utoronto.ca, lixiang.chen@mail.utoronto.ca

%%  compute sigma values
L = length(set_Of_Values);
if(ESP_Sol==1)
    set_of_factorials = factorial(1:L);
    sgm = full_ESP_thrm1(set_Of_Values,set_of_factorials);
elseif(ESP_Sol==2)
    sgm = ESP_Traub(set_Of_Values);
else
    sgm = ESP_Yang(set_Of_Values);
end

%%  compute phi
if L == 1
    phi = 1;
else
    phi(2, 1) = 1/(set_Of_Values(2)-set_Of_Values(1));
    phi(2, 2) = phi(2, 1);
end
for m = 2: L-1
    for s = 1: m
        phi(m+1, s) = phi(m, s) / (set_Of_Values(m+1)-set_Of_Values(s));
    end
    phi(m+1, m+1) = 1/prod(set_Of_Values(m+1)-set_Of_Values((1:m)));
end

phi(L, :);

%%
psi(L, :) = (-1).^(L+[1:L]);
for i = L:-1:2
    j = [1: L];
    psi(i-1, j) = set_Of_Values(j).* psi(i, j) - (-1).^(i+j).*sgm(L+1, L+1-i+1);
end

%%  compute the j'th column
for j = 1: L
    w(:, j) = psi(:, j).*phi(L,j);
end
iM = w.';