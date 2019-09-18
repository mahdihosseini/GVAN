function [sgm] = ESP_Traub(set_Of_Values)
%This is a matlab implementation of the Traub elementary symmetric
%polynomial formula in "Associated Polynomials and Uniform Methods for the 
% Solution of Linear Problems"
% by J.F. Traub. SIAM Review Vol 8, No. 3(1966)
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


%FORMAT FOR THIS SGM: count starts at 0. ROW: the number of elements in the
%set. COL: THe i'th elementary symm function. So (row,col) -> (2,3) is the
%2nd elementaryy symm function with 1 elements in the set.. ans is 0.
N = length(set_Of_Values);
sgm = ones(N-1,N);
for s = 0: N
    for m = 0: N
        if s == 0
            sgm(m+1, 1) = 1;
        elseif (s>m)
            sgm(m+1, s+1) = 0;
        else
            sgm(m+1, s+1) = sgm(m, s+1) + set_Of_Values(m)* sgm(m, s);
        end
    end
end