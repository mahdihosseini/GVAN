function [out_matrix] = big_S(set_of_Values,ESP_sol)
%Uses the various ESPs to solve the proposed Vandermonde inverse
%   Copyright   Mahdi S. Hosseini and Alfred Chen
%               University of Toronto, September 2015
%               The Edward S. Rogers Sr. Department of,
%               Electrical and Computer Engineering (ECE)
%               Toronto, ON, M5S3G4, Canada
%               Tel: +1 (416) 978 6845
%               email: mahdi.hosseini@mail.utoronto.ca,
%               lixiang.chen@mail.utoronto.ca

%% Intializations
N = length(set_of_Values);
out_matrix = zeros(N);
set_of_factorials = factorial(1:N);
out_matrix(:,N) = 1;

%% Calculation
if(ESP_sol ~= 4)
    for i = 1:N
        v_0 = set_of_Values([1:i-1,i+1:N]);
        if(ESP_sol == 1)
            %% Proposed Theorem 1 Solution
            sum_vector = ESP_Closed(v_0,set_of_factorials);
        elseif(ESP_sol == 2)
            %% Traub Solution
            sum_vector = ESP_Traub(v_0);
            sum_vector = sum_vector(end,2:end).';
        else
            %% Yangjia Solution
            temp = ESP_Yang(v_0);
            sum_vector = temp(end,2:end).';
        end
        out_matrix(i,1:N-1) = fliplr(sum_vector.');
    end
else
    %% Mikkawy Solution
    out_matrix = ones(N);
    out_matrix(1:N,1:N-1) = fliplr(ESP_Mikkawy(set_of_Values).');
end
end