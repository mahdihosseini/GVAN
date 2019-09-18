function [inv_Van] = INV_Closed(set_of_Values,ESP_Sol)

%Closed Form Vandermonde Inverse from Theorem 2
%
%   [inv_Van] = INV_Closed(set_of_Values,ESP_Sol)
%
%   returns an NxN inverse matrix of the Vandermonde with set_of_Values
%   as the nodes. i.e. set_of_Values = {v_1,v_2,..,v_N}
%
%   Input(s):
%   'set_of_Values'       The nodes that make up the Vandermonde matrix

%   'ESP_Sol'             The ESP solution used to solve the invers:
%                         1 - Theorem 1 (Proposed)
%                         2 - Traub
%                         3 - Yang
%                         4 - Mikkawy
% 
%   Output(s):
%   'inv_Van'             Inverse Vandermonde matrix N-by-N
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

set_of_Values = set_of_Values(:).';
N = length(set_of_Values);
j = [1:N];
%% Calculation for the fraction portion
den_lambda = 1./lamdaW(set_of_Values);
num_ones = (-1).^(N-j);
frac_part = den_lambda*num_ones;

%% Calculation for the fraction portion
sum_part = big_S(set_of_Values,ESP_Sol);

%create the matrix
inv_Van = frac_part.*sum_part;
end

