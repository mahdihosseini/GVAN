function [p_closed] = polyfit_custom(x_interp, y_interp, ESP_method, iV_method)
%Polynomial Fitting
%
%   [p_closed] = polyfit_custom(x_interp, y_interp, ESP_method, iV_method)
%
%   returns the coefficients of a fitted polynomial using a selected 
%   vandermonde inverse method with a selected ESP method
%
%   Input(s):
%   'x_interp'       The sampled nodes
%   'y_interp'       The sampled values at those nodes
%   'iV_method'      The Vandermonde inverse method 
%   'ESP_method'     The ESP solution used to solve the invers:
%                    1 - Theorem 1 (Proposed)
%                    2 - Traub
%                    3 - Yang
%                    4 - Mikkawy
% 
%   Output(s):
%   'p_closed'       coefficients to the fitted polynomial
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

% inputs: x_interpolation, y_interpolation
% output: coefficients of a polynomial P(x) fitting y_interpolation

ESP_Solution = ESP_Selector(ESP_method);

switch iV_method
    case 'proposed'
        %   Closed Form inverse Vandermonde calculation
        iV = INV_Closed(x_interp, ESP_Solution);
    case 'eisin'
        %   Eisinberg inverse Vandermonde calculation
        iV = INV_Eisinberg(x_interp, ESP_Solution);
end

%   approximate the polynomial coefficeints
p_closed = iV.'*y_interp(:);