clear all
close all
clc
%  This demo calculates and plots the Speed of the proposed ESP solution
%  over Unit circle samples. The plot is figure 2b of the paper:
%  "On the Closed Form Expression Of Elementary Symmetric Polynomials and 
%  the Inverse of Vandermonde Matrix" by 
%  Mahdi S. Hosseini, Alfred Chen, and Konstantinos N. Plataniotis. 
%  Submitted to SIAM Journal On Scientific Computing, 2019

%%  Parameters
N = 40:85;

%% Setting up environment
addpath(([pwd, filesep, '../third party codes']))
addpath(([pwd, filesep, '../utilities']))
addpath(([pwd, filesep, '../data']))

%% Data Initialization
thrm_1_time = zeros(length(N),1);
Traub_time = zeros(length(N),1);
yang_time = zeros(length(N),1);
mikkawy_time = zeros(length(N),1);

%% Calculations
for i = N
    k = [1: i]';
    set_of_factorials = factorial(k);
    set_of_Values_UnitCircle = exp(-1i*2*pi*k/i);
    %The N(1)+1 is to offset the array so the results start at the first
    %element
    thrm_1_time(i-N(1)+1) = timeit(@() ESP_Closed(set_of_Values_UnitCircle(2:end),set_of_factorials));
    Traub_time(i-N(1)+1) = timeit(@() ESP_Traub(set_of_Values_UnitCircle(2:end)));
    yang_time(i-N(1)+1) = timeit(@() ESP_Yang(set_of_Values_UnitCircle(2:end)));
    mikkawy_time(i-N(1)+1) = timeit(@() ESP_Mikkawy_analysis(set_of_Values_UnitCircle));
end

%% Plot
Y = 40:85;
figure('rend','painters','pos', [50, 200, 400, 400]);
line_width = 1;
plot(Y, thrm_1_time*1e+3,'b-o','MarkerSize', 7,'LineWidth',line_width)
hold on
plot(Y,Traub_time*1e+3,'-s','MarkerSize', 7,'LineWidth',line_width,'Color',[0.4940 0.1840 0.5560])
plot(Y,yang_time*1e+3,'k-x','MarkerSize', 7,'LineWidth',line_width)
plot(Y,mikkawy_time*1e+3,'r-*','MarkerSize', 7,'LineWidth',line_width)
legend({'Thrm1','Traub','Yang','Mikkawy'},'Location','northwest','Fontsize',12)
set(gca, 'FontSize', 12)
axis([45 85 0 26])
grid
xlabel('Number of samples on unit circle (N)')
ylabel('Computation time [msec]')
