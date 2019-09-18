function [sgm] = ESP_Mikkawy_analysis(setOfValues)
%FOR ESP ANALYSIS ONLY
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

%% This layout is for elementary symmetric analysis
%This is the original Mikkawy implementation:
%sgm layout: 
%rows: the number of elements (starting at 1 element)
%colms: the number of multipliers (j'th elementary symm function) starting
%at 0
sgm = ones(1,N);
sgm_inner = ones(N-1,N);
setOfValues(1) = [];
sgm_inner(1,2) = setOfValues(1);
for n = 3: N
    %we need 1' in the first column for later calculations. so shift
    %everything right once. that is why the colm element is n and not n-1
    sgm_inner(n-1,n) = sgm_inner(n-2,n-1)*setOfValues(n-1);
    
    %vectorized
    sgm_inner(n-1,2:n-1)= sgm_inner(n-2,1:n-2)*setOfValues(n-1) + sgm_inner(n-2,2:n-1);
end
sgm = sgm_inner;

sgm = sgm_inner(end,2:end).';