function [output] = filterData(input)
output.time.data = input.time.data;
output.time.units = input.time.units;

% filter the Euler Anglers
output = eulerKalman(input);

% filter the wind angles
output = windKalman(output);
