function [sgm] = full_ESP_thrm1(set_Of_Values,set_of_factorials)
%Produces a full ESP matrix using the proposed inverse. Needed for the
%Eisinberg et.al. inverse method. Used when the Eisinberg inverse method
%calls the proposed elementary symmetric polynomial solution.

N = length(set_Of_Values);
sgm = zeros(N+1);
sgm(:,1) = ones(N+1,1);
for i = 1:N
    temp = ESP_Closed(set_Of_Values(1:i),set_of_factorials);
    sgm(i+1,2:length(temp)+1) = temp;
end

end

