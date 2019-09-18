function [out] = lamdaW(set_of_Values)
% Calculates the lambda in Theorem 2.2 in "On the Closed Form Expression Of Elementary
% Symmetric Polynomials and the Inverse of Vandermonde Matrix" by Mahdi S. Hosseini
% Alfred Chen, and Konstantinos N. Plataniotis.
% Submitted to SIAM Journal On Scientific Computing, 2019
% Specifically, it calculates Equation 2.3 in the paper above.
%
%   Copyright   Mahdi S. Hosseini and Alfred Chen
%               University of Toronto, September 2015
%               The Edward S. Rogers Sr. Department of,
%               Electrical and Computer Engineering (ECE)
%               Toronto, ON, M5S3G4, Canada
%               Tel: +1 (416) 978 6845
%               email: mahdi.hosseini@mail.utoronto.ca,
%               lixiang.chen@mail.utoronto.ca


N = length(set_of_Values);
v_k = repmat(set_of_Values,N-1,1);
v_j = zeros(N-1,N);

for j = 1:N
    v_j(:,j) = set_of_Values([1:j-1,j+1:N]).';
end
out = prod(v_k - v_j).';
end

