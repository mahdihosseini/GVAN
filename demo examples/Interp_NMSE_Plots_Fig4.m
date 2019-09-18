clear all
close all
clc

% This function creates an NMSE vs sample size plot. Specifically, a sample
% of the plots seen in figure 4 in "On the Closed Form Expression Of
% Elementary Symmetric Polynomials and the Inverse of Vandermonde Matrix"
% by Mahdi S. Hosseini, Alfred Chen, and Konstantinos N. Plataniotis.
% Submitted to SIAM Journal On Scientific Computing, 2019

%%  parameter setup
analytical_func = 'sin';  % 'sin', 'tanh', 'exp'
N_range = [17: 45];  % range of discritization
t = 1;  % tunning parameter for analytical function description
shift_x = 0.0; %xshift of the interpolation
cutoff = 0; %amount of nodes to cutoff from the endpoints

% set the ESP solution used in each respective inverse
ESP_method_proposed = 'Mikkawy';   % 'proposed', 'Traub', 'Yang', 'Mikkawy'
ESP_method_eisin = 'proposed';   % 'proposed', 'Traub', 'Yang'
node_type = ['Equidistant'];% 'Chebyshev', 'Extended Chebyshev', 'Gauss Lobbatto'

%% Setting up environment
addpath([pwd, filesep, '../third party codes'])
addpath([pwd, filesep, '../utilities'])
addpath([pwd, filesep, '../data'])

%% Plot properties
col = [0, .45, 0;
    1, .6, 0;];
markers = {'s', 'o'};
window_size = [325, 350];
marker_size = [7, 7];
legend_string = {...
    strcat('Thrm2: ', ESP_method_proposed), ...
    strcat('Eisin: ', ESP_method_eisin)};

%% Calculations
iteration_N=0;
for N = N_range
    iteration_N = iteration_N + 1;
    %%  define sample nodes for interpolation and super-resolution
    [x_interp, x_super] = node_sampling(N, node_type);
    x_interp = x_interp + shift_x;
    x_super = x_super + shift_x;
    
    %%  define analytical function for creating samples
    [y] = analytical_function(t, analytical_func);
    
    %%  sample analytical function with given nodes
    y_interp = y(x_interp);
    y_super = y(x_super);
    y_super = y_super(cutoff+1: end-cutoff);
    
    %%  solve Vandermonde system of equation to approximate interpolating polynomials
    [p_closed_proposed] = polyfit_custom(x_interp, y_interp, ESP_method_proposed, 'proposed');
    [p_closed_eisin] = polyfit_custom(x_interp, y_interp, ESP_method_eisin, 'eisin');
    
    %%  super-resolve (interpolate) for higher sampling nodes using estiamted polynomials
    [y_super_estimated_proposed] = polyval(p_closed_proposed(end:-1:1), x_super);
    [y_super_estimated_eisin] = polyval(p_closed_eisin(end:-1:1), x_super);
    y_super_estimated_proposed = y_super_estimated_proposed(cutoff+1: end-cutoff);
    y_super_estimated_eisin = y_super_estimated_eisin(cutoff+1: end-cutoff);
    NMSE(iteration_N, 1) = ...
        norm(y_super - y_super_estimated_proposed)/norm(y_super);
    NMSE(iteration_N, 2) = ...
        norm(y_super - y_super_estimated_eisin)/norm(y_super);
end

plot(N_range, squeeze(NMSE(:,1)),...
    [markers{1}, '--'], ...
    'Color', col(1, :), ...
    'MarkerSize', marker_size(1))
hold on

plot(N_range, squeeze(NMSE(:,2)),...
    [markers{2}, '-'], ...
    'Color', col(2, :), ...
    'MarkerSize', marker_size(2))

set(gca, 'FontSize', 12, 'YScale', 'log')
grid
xlabel('Sample Nodes (N)')
ylabel('NMSE')
legend(legend_string, 'FontSize', 8)


