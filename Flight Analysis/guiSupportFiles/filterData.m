function [output] = filterData(input)

% filter the Euler Anglers
output = eulerKalman(input);

% filter the wind angles
output = windKalman(output);
