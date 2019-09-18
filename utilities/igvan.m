function [inv_Van] = igvan(nodes,ESP_method,inv_type)

%An inverse caller that returns an inverse vandermonde using a selected
%inverse method using a selected elementary symmetric polynomial solution
%
%   [inv_Van] = igvan(nodes,ESP_sol,inv_type)
%
%   returns an NxN inverse matrix of the Vandermonde with set_of_Values
%   as the nodes. i.e. set_of_Values = {v_1,v_2,..,v_N}
%
%   Input(s):
%   'nodes'       The sampled nodes that will make up the Vandermonde matrix

%   'ESP_method'     The ESP solution used to solve the inverse:
%                 1 - Theorem 1 (Proposed)
%                 2 - Traub
%                 3 - Yang
%                 4 - Mikkawy
%   'inv_type'  The type of inverse method used. 'proposed' or 'eisin'
% 
%   Output(s):
%   'inv_Van'             Inverse Vandermonde matrix N-by-N
%
ESP_solution = ESP_Selector(ESP_method);
switch lower(inv_type)
    case 'proposed'
        inv_Van = INV_Closed(nodes,ESP_solution);
    case 'eisin'
        inv_Van = INV_Eisinberg(nodes(:).',ESP_solution);
end

end

