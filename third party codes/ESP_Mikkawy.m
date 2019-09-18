function [sgm] = ESP_Mikkawy(setOfValues)
%This is a matlab implementation of the Mikkawy elementary symmetric
%polynomial formula in "Explicit inverse of a general Vandermonde matrix"
%by Moawwad E.A. El-Mikkawy. Applied Mathematics and Computation 146 (2003)
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

%The layout for this sgm is specfically for the Vandermonde inverse calculation
%By Mahdi S. Hosseini, Alfred Chen, Kostas Plataniotis
%(every element has N elements, where the 1st element is removed in the
%setOfValues for the 1st column. jth row is the j-th symmetric function,
% %(v_r1*..*v_rj)
sgm = ones(N-1,N);
sgm_inner = ones(N-1,N);
for k = 1:N 
    temp_setOfValues = setOfValues;
    temp_setOfValues(k) = [];
    sgm_inner(1,2) = temp_setOfValues(1);
    for n = 3: N
        sgm_inner(n-1,n) = sgm_inner(n-2,n-1)*temp_setOfValues(n-1);
        sgm_inner(n-1,2:n-1)= sgm_inner(n-2,1:n-2)*temp_setOfValues(n-1) + sgm_inner(n-2,2:n-1);
    end
    sgm(:,k) = sgm_inner(end,2:end).';
end
