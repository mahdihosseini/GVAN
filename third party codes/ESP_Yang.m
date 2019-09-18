function [sgm] = ESP_Yang(setOfValues)
%This is a matlab implementation of the Yang elementary symmetric
%polynomial formula in "Symmetric Polynomial Matrices and Vandermonde
%Matrices"
%by Sheng-Liang Yang and Yan-Yi Jia Indian J. Pure Applied Math (2009)
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

N = numel(setOfValues);
sgm = ones(N+1);

for m = 0: N
    %why m+2?
    sgm(m+1, m+2:end) = 0;
    %in the end, you will need m+1 slots for the array. so preallocate it
    commul_mult_L = ones(m+1,1);
    %for s==m, every element but the last is 0
    for s = 1: m-1
        recursive_R = ones(m+1,1);
        commul_mult_L(s+1) = prod(setOfValues(m-s+1:m));
        %recursive_R is created top side up so i=1 is value of j-1
        %  (always will be 1, so skip to i=s+1, s-(s+1)+1)
        % where s+1 = j
        for i = 1:s
            recursive_R(i) = sgm(m-i+1,s-i+2);
        end
        recursive_R(s+2:end) = 0;
        %m+1 in matlab is m in the paper
        sgm(m+1,s+1) = sum(commul_mult_L.*recursive_R);
    end
    %for the last element, s = m, (index is shifted by 1)
    sgm(m+1,m+1) = prod(setOfValues(1:m));
end
end
