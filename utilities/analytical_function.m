function [y] = analytical_function(k, analytical_func)
%A modular function that produces the three true functions,f, used for
%experimental analysis in "On the Closed Form Expression Of Elementary
% Symmetric Polynomials and the Inverse of Vandermonde Matrix" by Mahdi S. Hosseini
% Alfred Chen, and Konstantinos N. Plataniotis.
switch analytical_func
    case 'sin'
        %%  create sinusoid signal
        % t is the frequency parameter for sin
        omega = 2*pi*k;
        y = @(x) cos(omega*x);
    case 'tanh'
        %%  create tanh signal
        % t is the steepness parameter for tanh
        y = @(x) tanh(k*x);
    case 'exp'
        %%  create exponential signal
        % t is the steepness parameter for exp
        y = @(x) exp(k*x);
end