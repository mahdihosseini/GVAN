clear all
close all
clc

%  This demo calculates and plots the Accuracy of the proposed ESP solution
%   over Unit circle samples. This is Figure 2a in:
%  "On the Closed Form Expression Of Elementary Symmetric Polynomials and 
%  the Inverse of Vandermonde Matrix" by 
%  Mahdi S. Hosseini, Alfred Chen, and Konstantinos N. Plataniotis. 
%  Submitted to SIAM Journal On Scientific Computing, 2019

%% Parameters
N = 50:90;

%% Setting up environment
addpath(([pwd, filesep, '../third party codes']))
addpath(([pwd, filesep, '../utilities']))
addpath(([pwd, filesep, '../data']))
%%  Data initialization
thrm_1_ans_UC = zeros(length(N),1);
Traub_UC = zeros(length(N),1);
yang_UC = zeros(length(N),1);
mikkawy_UC = zeros(length(N),1);

%% Calculations
for i = N
    k = [1: i]';
    set_of_factorials = factorial(k);

    set_of_Values_UnitCircle = exp(-1i*2*pi*k/i);
    
    temp = ESP_Closed(set_of_Values_UnitCircle(2:end),set_of_factorials);
    thrm_1_ans_UC(i-4)= sum(abs(temp))/length(temp);
    
    temp = ESP_Traub(set_of_Values_UnitCircle(2:end));
    temp = temp(end,2:end);
    Traub_UC(i-4) = sum(abs(temp))/length(temp);
    
    temp = ESP_Yang(set_of_Values_UnitCircle(2:end));
    temp = temp(end,2:end).';
    yang_UC(i-4) = sum(abs(temp))/length(temp);
    
    temp = ESP_Mikkawy_analysis(set_of_Values_UnitCircle);
    mikkawy_UC(i-4) = sum(abs(temp))/length(temp);
end

%% Plot
figure('rend','painters','pos', [50, 200, 400, 400]);
line_width = 1;
plot(thrm_1_ans_UC, 'b-o', 'MarkerSize', 5, 'LineWidth', line_width)
hold on
plot(Traub_UC,'-s','MarkerSize', 10,'LineWidth', line_width,'Color',[0.4940 0.1840 0.5560])
plot(yang_UC,'k-x','MarkerSize', 7,'LineWidth', line_width)
plot(mikkawy_UC,'r-*','MarkerSize', 7,'LineWidth', line_width)
legend({'Thrm1','Traub','Yang','Mikkawy'},'Location','northwest','Fontsize', 12)
set(gca, 'YScale', 'log', 'FontSize', 12)
axis([45 85 0.5 inf])
grid
xlabel('Number of samples on unit circle (N)')
ylabel(['|\sigma_{N,n}| - log scale'])
