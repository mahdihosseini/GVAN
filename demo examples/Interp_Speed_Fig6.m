close all
clear all
clc

% Calculates and creates figure 6 in "On the Closed Form Expression Of Elementary
% Symmetric Polynomials and the Inverse of Vandermonde Matrix" by Mahdi S. Hosseini
% Alfred Chen, and Konstantinos N. Plataniotis.
% Submitted to SIAM Journal On Scientific Computing, 2019

%% Parameters 
num_of_samples=20;

%% Setting up environment
addpath(([pwd, filesep, '../third party codes']))
addpath(([pwd, filesep, '../utilities']))
addpath(([pwd, filesep, '../data']))

%% Initializations
ESP_case_range = {'Proposed','Traub','Yang','Mikkawy'};
time_eisin = zeros(num_of_samples-9,4);
time_closed = zeros(num_of_samples-9,4);

%% Equidistant between 0,N
for N = 10:num_of_samples
    N
a = -1;
b = 1;
h = (b-a)/(N-1);
x_interpolation = [a: h: b];
x_super = [a: h/2: b];

f = 1;
omega = 2*pi*f;
x_shift = 0;
y = @(x) cos(omega*(x(:)-x_shift));

y_interpolation = y(x_interpolation);
for elementary_symm_sol = 1:length(ESP_case_range)
    ESP_sol = ESP_case_range{elementary_symm_sol};
    time_eisin(N-9,elementary_symm_sol) = timeit(@()polyfit_custom(x_interpolation, y_interpolation,ESP_sol,'eisin'));
    time_closed(N-9,elementary_symm_sol) = timeit(@()polyfit_custom(x_interpolation, y_interpolation,ESP_sol,'proposed'));
end
end
time_closed = time_closed.*1000;
time_eisin = time_eisin.*1000;

fog(1) = figure;
plot(10:num_of_samples,smooth(time_closed(1:num_of_samples-9,1)),'LineWidth',2)
hold on
plot(10:num_of_samples,smooth(time_closed(1:num_of_samples-9,2)),'LineWidth',2)
plot(10:num_of_samples,smooth(time_closed(1:num_of_samples-9,3)),'LineWidth',2)
plot(10:num_of_samples,smooth(time_closed(1:num_of_samples-9,4)),'LineWidth',2)
hold off
leg1=legend({'Thrm1','Traub','Yang','Mikkawy'},'Location','NorthWest');
set(leg1,'FontSize',15);
legend('boxoff');
set(gca, 'YScale', 'log', 'FontSize', 15)

title ('Proposed: Computation time');
axis square
grid  on
xlabel('Number of Samples')
ylabel('Computation Time [ms]')
fog(2) = figure;
plot(10:num_of_samples,smooth(time_eisin(1:num_of_samples-9,1)),'LineWidth',2)
hold on
plot(10:num_of_samples,smooth(time_eisin(1:num_of_samples-9,2)),'LineWidth',2)
plot(10:num_of_samples,smooth(time_eisin(1:num_of_samples-9,3)),'LineWidth',2)

leg2=legend({'Thrm1','Traub','Yang'},'Location','NorthWest');
set(leg2,'FontSize',15);
legend('boxoff');
set(gca, 'YScale', 'log', 'FontSize', 15)

title ('Eisinberg: Computation time');
axis square
grid  on
xlabel('Number of Samples')
ylabel('Computation Time [ms]')
