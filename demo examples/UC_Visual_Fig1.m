clear all
close all
clc
% Calculates and visualizes the results from various solution to the 
% Elementary Symmetric Polynomial. 

% It specifically was used to create the figure 1 seen in:
% "On the Closed Form Expression Of Elementary Symmetric Polynomials and 
% the Inverse of Vandermonde Matrix" by 
% Mahdi S. Hosseini, Alfred Chen, and Konstantinos N. Plataniotis.
% Submitted to SIAM Journal On Scientific Computing, 2019

%%  Parameter setup
N = 70;

%% Setting up the environment
addpath(([pwd, filesep, '../third party codes']))
addpath(([pwd, filesep, '../utilities']))
addpath(([pwd, filesep, '../data']))

%% Data initialization
k= 1:N;
set_of_factorials = factorial(k);
set_of_Values_UnitCircle = exp(-1i*2*pi*k/N);

%% ESP Calculations
thrm_1_ans_UC= ESP_Closed(set_of_Values_UnitCircle(2:end),set_of_factorials);
Traub_UC = ESP_Traub(set_of_Values_UnitCircle(2:end));
Traub_UC=Traub_UC(end,2:end);
yang_UC = ESP_Yang(set_of_Values_UnitCircle(2:end));
yang_UC=yang_UC(end,2:end).';
mikkawy_UC = ESP_Mikkawy_analysis(set_of_Values_UnitCircle);

%% Plot Proposed Result
thrm1_fig = figure;
viscircles([0,0],1,'Color','k','LineStyle','--','LineWidth',1);
hold on 
plot(thrm_1_ans_UC,'r.','MarkerSize', 40);
ylabel('Im')
xlabel('Re')
axis square
axis([-1.1 1.1 -1.1 1.1])
grid on
box on
set(gca,'FontSize', 30)
title('Proposed Solution')
%% Plot Traub Result

traub_fig = figure;
viscircles([0,0],1,'Color','k','LineStyle','--','LineWidth',1);
hold on 
plot(Traub_UC,'r.','MarkerSize', 40);
ylabel('Im')
xlabel('Re')
axis square
axis([-1.1 1.1 -1.1 1.1])
grid on
box on
set(gca,'FontSize', 30)
title('Traub')

%% Plot Mikkawy Result

mikkawy_fig = figure;
viscircles([0,0],1,'Color','k','LineStyle','--','LineWidth',1);
hold on 
plot(mikkawy_UC,'r.','MarkerSize', 40);
ylabel('Im')
xlabel('Re')
axis square
axis([-1.1 1.1 -1.1 1.1])
grid on
box on
set(gca,'FontSize', 30)
title('Mikkawy')

%% Plot Yang Result
yang_fig = figure;
viscircles([0,0],1,'Color','k','LineStyle','--','LineWidth',1);
hold on 
plot(yang_UC,'r.','MarkerSize', 40);
ylabel('Im')
xlabel('Re')
axis square
axis([-1.1 1.1 -1.1 1.1])
grid on
box on
set(gca,'FontSize', 30)
title('Yang')
