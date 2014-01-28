function [output] = filterData(input)
output = input; %structs are generally the same so copy them

% % filter the Euler Anglers
% output = eulerKalman(input);

% filter the wind angles
[output.alphaP.data,ouput.betaP.data] = windKalman(output);
