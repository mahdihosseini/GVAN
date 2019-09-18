function [ESP_Solution] = ESP_Selector(ESP_method)
%The selector for the different ESP solutions. 
switch lower(ESP_method)
    case 'proposed'
        ESP_Solution = 1;
    case 'traub'
        ESP_Solution = 2;
    case 'yang'
        ESP_Solution = 3;
    case 'mikkawy'
        ESP_Solution = 4;
end
end