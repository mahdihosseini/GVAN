function [out_vector] = ESP_Closed(set_of_Values,set_of_factorials)

%Closed Form of the Elementary Symmetric Polynomials from Theorem 2.1
%
%   [out_vector] = ESP_Closed(set_of_Values,set_of_factorials)
%
%   returns an Nx1 vector containing the results of the i'th ESP over the N
%   set of values (i = 1,2,..,N)
%
%   Input(s):
%   'set_of_Values'       The set of values that the ESP solution is based
%                         over

%   'set_of_factorials'   A list of factorials up to N (1!,2!,..,N!) for
%                         the last step of the recursive solution
%   Output(s):
%   'out_vector'          Nx1 vector answer
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

N = length(set_of_Values);
out_vector = ones(N,1);

for n = 1:N
    C = set_of_Values;
    for i = 1: n-1
        C = set_of_Values .* (sum(C) - (n-i)*C);
    end
    out_vector(n) = sum(C)/set_of_factorials(n);
end
end














