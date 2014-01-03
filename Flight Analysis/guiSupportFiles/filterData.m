function [output] = filterData(input)
output.time = input.time;

% % filter the Euler Anglers
% output = eulerKalman(input);

% filter the wind angles
output = windKalman(output);
