close all
clear all
clc

% Creates the 2D plots for Figure 5 in "On the Closed Form Expression Of Elementary
% Symmetric Polynomials and the Inverse of Vandermonde Matrix" by Mahdi S. Hosseini
% Alfred Chen, and Konstantinos N. Plataniotis.
% Submitted to SIAM Journal On Scientific Computing, 2019

%%  parameter setup
analytical_func = 'tanh';  % 'sin', 'tanh', 'exp'
N = 37;  % range of discritization
t = 4;  % tunning parameter for analytical function description
shift_x = 0.0; %xshift of the interpolation
cutoff = 0; %amount of nodes to cutoff from the endpoints

% set the ESP solution used in each respective inverse
ESP_method_proposed = 'Mikkawy';   % 'proposed', 'Traub', 'Yang', 'Mikkawy'
ESP_method_eisin = 'proposed';   % 'proposed', 'Traub', 'Yang'

%% Setting up environment
addpath([pwd, filesep, '../third party codes'])
addpath([pwd, filesep, '../utilities'])
addpath([pwd, filesep, '../data'])
switch analytical_func
    case 'sin'
        axis_limit = [-1, 1, -1.1, 1.9];
  y_label_text = ['f(x) = sin(2{\pi}', num2str(t), 'x)'];
    case 'tanh'
        axis_limit = [-1, 1, -1.5, 1.5];
        y_label_text = ['f(x) = tanh(', num2str(t), 'x)'];
    case 'exp'
        axis_limit = [-1, 1, -5, 60];
        y_label_text = ['f(x) = e^{', num2str(t), 'x}'];
end
node_type_range = {'Equidistant', 'Chebyshev', 'Extended Chebyshev', 'Gauss Lobbatto'};  % 'equidistant', 'chebyshev', 'extended_chebyshev', 'gauss_lobbatto', 'fekete'
%%
iteration_node = 0;
for node_type = node_type_range
    node_type  =node_type{1};
    iteration_node = iteration_node + 1;
    %%
    fprintf(['N: ', num2str(N), ', '...
        't: ', num2str(t), ', '...
        'fun: ', analytical_func, ', '...
        'node: ', node_type, '\n'])
    %%  define sample nodes for interpolation and super-resolution
    [x_interp, x_super] = node_sampling(N, node_type);
    [x_c] = node_sampling(1000, node_type);
    x_interp = x_interp + shift_x;
    x_super = x_super + shift_x;
    x_c = x_c + shift_x;
    
    %%  define analytical function for creating samples
    [y] = analytical_function(t, analytical_func);
    
    %%  sample analytical function with given nodes
    y_interp = y(x_interp);
    y_super = y(x_super);
    y_c = y(x_c);
    
    %%  solve Vandermonde system of equation to approximate interpolating polynomials
    iV_method = 'proposed'; % 'proposed', 'eisin'
    [p_closed_proposed] = polyfit_custom(x_interp, y_interp, ESP_method_eisin, iV_method);
    %
    iV_method = 'eisin'; % 'proposed', 'eisin'
    [p_closed_eisin] = polyfit_custom(x_interp, y_interp, ESP_method_proposed, iV_method);
    
    %%  super-resolve (interpolate) for higher sampling nodes using estiamted polynomials
    [y_super_estimated_proposed] = polyval(p_closed_proposed(end:-1:1), x_super);
    [y_super_estimated_eisin] = polyval(p_closed_eisin(end:-1:1), x_super);
    
    %%  apply cutoff
    y_super_cutoff = y_super(cutoff+1: end-cutoff);
    x_super_cutoff = x_super(cutoff+1: end-cutoff);
    y_super_estimated_proposed_cutoff = y_super_estimated_proposed(cutoff+1: end-cutoff);
    y_super_estimated_eisin_cutoff = y_super_estimated_eisin(cutoff+1: end-cutoff);
    
    %%
    NMSE_proposed = norm(y_super_cutoff - y_super_estimated_proposed_cutoff)/norm(y_super_cutoff)
    NMSE_eisin = norm(y_super_cutoff - y_super_estimated_eisin_cutoff)/norm(y_super_cutoff)
    
    %%
    window_size = [350, 600];
    figure_handle = figure('rend','painters','pos', [window_size(2)*(iteration_node-1)+iteration_node*30, 50 , window_size(2), window_size(1)]);
    marker_size = 7;
    plot(x_c, y_c, '-', 'Color', [.8, 0, 0])
    hold on
    plot(x_interp, y_interp, 's', 'MarkerSize', marker_size+2, 'Color', [0, 0, .6])
    plot(x_super, y_super_estimated_proposed, 'o', 'MarkerSize', marker_size, 'Color', [0, .6, 0])
    plot(x_super, y_super_estimated_eisin, 'x', 'MarkerSize', marker_size, 'Color', [1, .6, 0])
    axis(axis_limit)
    title(node_type);
    legend('True Profile', ...
        'Interpolating Samples', ...
        'V^{-1}: Thrm 1, ESP: Thrm 2', ...
        'V^{-1}: Eisin, ESP: Traub');
    xlabel('Sample Domain (x)')
    ylabel(y_label_text)
    set(gca, 'FontSize', 12)
end












