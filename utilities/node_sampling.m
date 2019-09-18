function [x_interp, x_super] = node_sampling(N, node_type)
% Outputs sampled nodes for interpolation
%
%   [x_interp, x_super] = node_sampling(N, node_type)
%
%   returns the sampled x values (nodes) and the super-resolved nodes that
%   are to be interpolated at.
%
%   Input(s):
%   'N'               Number of nodes
%   'node_type'       Sampling Method
% 
%   Output(s):
%   'x_interp'        Nodes sampled at
%   'x_super'         Nodes to be sampled at

x_interp = [];
x_super = [];
switch lower(node_type)
    case 'equidistant'
        %% 0,N
        a = -1;
        b = 1;
        h = (b-a)/(N-1);
        x_interp = [a: h: b];
        x_super = [a: h/2: b];
    case 'chebyshev'
        k = [1: N];
        x_interp = cos((2*k-1)/2/N*pi);
        kk = [1: 1/2: N];
        x_super = cos((2*kk-1)/2/N*pi);
    case 'extended chebyshev'
        k = [1: N];
        x_interp=cos( ( (2.*k-1) *pi)/(2*N))./cos(pi/(2*N));
        kk = [1: 1/2: N]';
        x_super = cos( ( (2.*kk-1) *pi)/(2*N))./cos(pi/(2*N));
    case 'gauss lobbatto'
        %%(extrema) Chebyshev Node
        k = [1: N];
        x_interp=- cos (((k-1)*pi)/(N-1));
        kk = [1: 1/2: N];
        x_super = - cos (((kk-1)*pi)/(N-1));
    case 'fekete'
        load(sprintf('../data/fek_nodes_%d.mat', N));
        x_interp = x_interpolation(:)';
        x_super = x_super(:)';
    case 'nth_roots'
        %% Nth roots of unity
        k = [1: N]-N/2;
        x_interp = exp(-1i*2*pi*k/N);
        kk = [1: 1/2: N]-N/2;
        x_super = exp(-1i*2*pi*kk/N);
end

if isempty(x_interp)
    error('error message: the node type is not properly called!')
end