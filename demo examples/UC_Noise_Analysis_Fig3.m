close all
clear all
clc

%  This demo calculates the NMSE of a vandermonde inverse method quantitatively.
%  The calculations complement figure 3 of the paper:
%  "On the Closed Form Expression Of Elementary Symmetric Polynomials and 
%  the Inverse of Vandermonde Matrix" by 
%  Mahdi S. Hosseini, Alfred Chen, and Konstantinos N. Plataniotis. 
%  Submitted to SIAM Journal On Scientific Computing, 2019


%%  Specified parameters for experimentation
ESP_case_range = {'Proposed','Traub','Yang','Mikkawy'};
inverse_type = 'proposed'; %'proposed' or 'eisin'
N = 37; % Number of samples
sigma_noise_nodes = 0.05; %significance of the noise along the unit circle
sigma_noise_magnitudes = 0.05;%signifcant of the deviation from the radius 1

%% Setting up environment
addpath([pwd, filesep, '../third party codes'])
addpath([pwd, filesep, '../utilities'])
addpath([pwd, filesep, '../data'])

%% NMSE Calculations for the Vandermonde inverse solution
iteration_ESP = 0;
for ESP_case = 1:length(ESP_case_range)
    ESP_case = ESP_case_range{ESP_case};
    iteration_ESP = iteration_ESP + 1;
    fprintf(['ESP Case: ', num2str(ESP_case), ...
        ', N = ', num2str(N), ...
        ', Node Noise = ', num2str(sigma_noise_nodes), ...
        ', Magnitude Noise = ', num2str(sigma_noise_magnitudes),'\n'])
    %% obtain samples with added noise
    k = [1: N]' + sigma_noise_nodes*randn(N,1);
    node_samples = exp(-1i*2*pi*k/N) + sigma_noise_magnitudes*randn(N,1);
    
    %% calculate the inverse
    V = fliplr(vander(node_samples));
    iV = igvan(node_samples,ESP_case,inverse_type);
    
    
    %%  spectral decomposition
    C = iV.' * (diag(node_samples) * V);
    c = C(:, end);
    I = C(2:end, 1: end-1);
    I_true = eye(N-1);
    
    %% NMSE calculation
    NMSE(iteration_ESP)  = norm(I - I_true)/norm(I_true);
end
log_10_NMSE = log10(NMSE);
%create a table here
ESP_type = ESP_case_range.';
log_10_NMSE = log_10_NMSE.';
T = table(ESP_type,log_10_NMSE)









