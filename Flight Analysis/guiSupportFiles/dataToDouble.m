function output = dataToDouble(input)

fields = fieldnames(input);
for i = 1:numel(fields)
    if isnumeric(input.(fields{i}).data)
        input.(fields{i}).data = double(input.(fields{i}).data);
    end
end
output = input;